#!/bin/bash

yum -y update
yum -y install net-tools wget telnet yum-utils device-mapper-persistent-data lvm2

### Add Docker repository.
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo -y

## Install Docker CE.
yum -y update && yum install docker-ce docker-ce-cli containerd.io -y

## Create /etc/docker directory.
mkdir /etc/docker

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart Docker
systemctl daemon-reload
systemctl enable docker
systemctl restart docker

# Disable swap
swapoff -a
sed -i 's/^\(.*swap.*\)$/#\1/' /etc/fstab 

# load netfilter probe specifically
modprobe br_netfilter


#disable firewall on local machine 
#systemctl stop firewalld
#systemctl disable firewalld


# Install kuberentes packages
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# disable SELinux. If you want this enabled, comment out the next 2 lines. But you may encounter issues with enabling SELinux
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum -y install kubectl kubelet kubeadm -disableexcludes=kubernetes 
systemctl  restart kubelet && systemctl enable kubelet && systemctl start kubelet


# Enable IP Forwarding
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# Restarting services
systemctl daemon-reload
systemctl restart kubelet

# Install nfs utils for Kubernetes NFS driver
yum -y install nfs-utils