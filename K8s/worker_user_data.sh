#!/bin/bash
pvcreate /dev/nvme1n1
vgextend os /dev/nvme1n1
lvextend os/var /dev/nvme1n1
xfs_growfs /var
systemctl disable firewalld --now
source /etc/profile.d/proxy.sh
hostname

#Install k3s
IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
/sbin/iptables -t nat -A PREROUTING -p tcp -d 169.254.169.254 --dport 80 -j DNAT --to-destination $IP:9181 -i cni0 --wait
curl -sfL https://get.k3s.io | K3S_URL=https://${lb_dns}:6443 K3S_TOKEN=${token} INSTALL_K3S_BIN_DIR=/usr/bin sh -s - --selinux

#Create/update tags for instances and volumes
AWS_AVAIL_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
AWS_REGION="`echo \"$AWS_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
AWS_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
VOLUME_IDS=$(echo $(aws ec2 describe-instances --region $AWS_REGION --instance-id $AWS_INSTANCE_ID --output text --query Reservations[0].Instances[0].BlockDeviceMappings) | grep -o "\(vol-\w*\)")
AWS_IPV4=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
IPV4_OCTET="$${AWS_IPV4: -2}"
AWS_HOSTNAME="${of_subdomain}$${IPV4_OCTET}${of_domain}"
aws ec2 create-tags --resources $VOLUME_IDS --region $AWS_REGION --tags "Key='Name', Value=$AWS_HOSTNAME"
# aws ec2 create-tags --resources $AWS_INSTANCE_ID --region $AWS_REGION --tags "Key='Name', Value=$AWS_HOSTNAME"
