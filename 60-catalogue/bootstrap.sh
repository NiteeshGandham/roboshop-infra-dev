#!/bin/bash
set -e

component=$1

sudo dnf install ansible -y

cd /home/ec2-user

if [ ! -d "ansible-roboshop-roles-tf" ]; then
    git clone https://github.com/NiteeshGandham/ansible-roboshop-roles-tf.git
fi

cd ansible-roboshop-roles-tf

git pull

ansible-playbook -e "component=${component}" -i inventory.ini roboshop.yaml