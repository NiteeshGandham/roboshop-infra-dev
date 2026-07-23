#!/bin/bash

#e are created 50Gb root disk. but 20gb is patitoned
#remaining 30Gb we need to extend using below cmnds
growpart /dev/nvme0 4
lvextend -r -L+30G /dev/mapper/RootVG-homeVol
xfx_growfs /home

#install terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

