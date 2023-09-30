#!/bin/bash
# Install Ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y

# Install unzip
sudo apt-get install unzip -y

# Fetch the Ansible playbook and roles from your storage or repo
wget https://github.com/amirpooyan-haghighat/DemoSRE/archive/refs/heads/main.zip -O /tmp/ansible.zip
unzip /tmp/ansible.zip -d /tmp

# Run the playbook
cd /tmp/DemoSRE-main/ansible
ansible-playbook ./playbooks/install-nginx.yml
