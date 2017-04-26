# Introduction

# Procedure
Use of next code in ubuntu machine 

```
sudo apt-get update`
sudo apt-get install openssh-server
sudo apt-get install openssh-client
```

Enable the SSH connection.

ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

Restart the SSH server.

service ssh restart

Can make a copy of sshd_config with the next command

sudo cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.original_copy
or 
sudo cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.original_copy

# Create a carpet for Read o write files

In the terminal of ubuntu put the next line code: for example in the folder var is create a folder named www

sudo mkdir /var/www
[sudo] password for ubuntu: 

The next gives permission of user for edit, read, write files. For example here of the folder /var/www put the user 'ubuntu' like the user that can modify the folder. Otherwise the user will be 'root' 

sudo chown -R ubuntu:ubuntu /var/www

After we can check the permissions folder is for 'ubuntu'

ls -ld /var/www
drwxrwxrwx 2 ubuntu ubuntu 4096 Apr 26 10:40 /var/www

##Segundo intento exitoso

ubuntu@DigSys-VM:~$ sudo mkdir /transferencia
ubuntu@DigSys-VM:~$ sudo mkdir /transferencia/rasp

La carpeta cuando se crea tiene permisos root

ubuntu@DigSys-VM:~$ ls -ld /transferencia/rasp
drwxr-xr-x 2 root root 4096 Apr 26 11:34 /transferencia/rasp
ubuntu@DigSys-VM:~$ sudo chown -R ubuntu:ubuntu /transferencia/rasp

Cambio los permisos para ubuntu

ubuntu@DigSys-VM:~$ ls -ld /transferencia/rasp
drwxr-xr-x 2 ubuntu ubuntu 4096 Apr 26 11:34 /transferencia/rasp

