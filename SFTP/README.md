#Introduction

#Procedure

Use of next code in ubuntu machine 

sudo apt-get update
sudo apt-get install openssh-server
sudo apt-get install openssh-client

Enable the SSH connection.

ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

Restart the SSH server.

service ssh restart

Can make a copy of sshd_config with the next command

sudo cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.original_copy
or 
sudo cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.original_copy
