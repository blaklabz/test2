#! /bin/bash
systemctl disable firewalld --now
source /etc/profile.d/proxy.sh
hostname

#Install k3s
curl -sfL https://get.k3s.io | K3S_TOKEN=${token} INSTALL_K3S_BIN_DIR=/usr/bin sh -s - --selinux --tls-san ${lb_dns} --datastore-endpoint='postgres://${rds_username}:${postgres_password}@${postgres_endpoint}/k3s' --disable servicelb --disable traefik --disable local-storage --node-taint CriticalAddonsOnly=true:NoExecute
cp /etc/rancher/k3s/k3s.yaml ${of_version}-config.yml

#Copy and upload k3s config file to s3
sed -i "s/default/${of_version}/g" ${of_version}-config.yml
sed -i "s/127.0.0.1/${lb_dns}/g" ${of_version}-config.yml
aws s3 cp ${of_version}-config.yml s3://of-configs/
rm ${of_version}-config.yml

#Update name tag for instance
AWS_AVAIL_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
AWS_REGION="`echo \"$AWS_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
AWS_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
VOLUME_IDS=$(echo $(aws ec2 describe-instances --region $AWS_REGION --instance-id $AWS_INSTANCE_ID --output text --query Reservations[0].Instances[0].BlockDeviceMappings) | grep -o "\(vol-\w*\)")
AWS_IPV4=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
IPV4_OCTET="$${AWS_IPV4: -2}"
AWS_HOSTNAME="${of_subdomain}$${IPV4_OCTET}${of_domain}"
aws ec2 create-tags --resources $VOLUME_IDS --region $AWS_REGION --tags "Key='Name', Value=$AWS_HOSTNAME"
# aws ec2 create-tags --resources $AWS_INSTANCE_ID --region $AWS_REGION --tags "Key='Name', Value=$AWS_HOSTNAME"
