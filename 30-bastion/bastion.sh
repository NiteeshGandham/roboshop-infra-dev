#!/bin/bash

# Expand the root partition to use the full EBS volume
sudo growpart /dev/nvme0n1 4

# Resize the LVM physical volume
sudo pvresize /dev/nvme0n1p4

# Extend the /home logical volume by 30 GB and resize the filesystem
sudo lvextend -r -L +30G /dev/mapper/RootVG-homeVol

# Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum install -y terraform