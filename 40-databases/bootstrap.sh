#!/bin/bash
component = $1
sudo dnf install ansible -y

cd /home/ec2-user
git clone https://github.com/NiteeshGandham/ansible-roboshop-roles-tf.git

cd ansible-roboshop-roles-tf
ansible-playbook -e component=$component roboshop.yaml