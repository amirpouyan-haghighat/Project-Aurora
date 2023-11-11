#!/bin/bash
# Install Ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y

# Install unzip
sudo apt-get install unzip -y

# Fetch the Ansible playbook and roles from your storage or repo
wget https://github.com/amirpouyan-haghighat/Project-Aurora/archive/refs/heads/${BRANCH_NAME}.zip -O /tmp/project.zip
unzip /tmp/project.zip -d /tmp
sudo find /tmp -maxdepth 1 -type d -name 'Project-Aurora*' -exec mv {} /tmp/Project-Aurora \;

# Run the playbook
cd /tmp/Project-Aurora/ansible
ansible-playbook ./playbooks/install-nginx.yml
