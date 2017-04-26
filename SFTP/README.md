# Introduction

The script `SFTP.py` import Python package `pysftp`, `paramiko` and `socket` the which must have install previously in the raspberry client before of run the script `SFTP.py`. For install the Python Package can use the next lines code with permission of super user `sudo`
```
sudo pip install pysftp

```
NOTE: With the first line code `sudo pip install pysftp` after installing to check with `pip list` whether the python package paramiko, crypto, socket was installed in the process. If this doesn't correct. Use the next code lines.  
```
sudo pip install paramiko
sudo pip install socket
```

# Procedure for install and run a SFTP server in Ubuntu
1. Use of next code in the terminal of Ubuntu for install of SSH or SFTP and begin the setup.

```
sudo apt-get update
sudo apt-get install openssh-server
sudo apt-get install openssh-client
```

2. Enable the SSH connection.

```
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
```

3. Restart the SSH server.

```
service ssh restart
```

4. Can make a copy of sshd_config with the next command
```
sudo cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.original_copy
```
or 
```
sudo cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.original_copy
```

## Create a carpet for Read o write files

1. In the terminal of ubuntu put the next line code: for example in the folder var is create a folder named www
```
sudo mkdir /var/www
[sudo] password for ubuntu: 
```
2. The next gives permission of user for edit, read, write files. For example here of the folder /var/www put the user 'ubuntu' like the user that can modify the folder. Otherwise the user will be 'root' 
```
sudo chown -R ubuntu:ubuntu /var/www
```
3. After we can check the permissions folder is for 'ubuntu'
```
ls -ld /var/www
drwxrwxrwx 2 ubuntu ubuntu 4096 Apr 26 10:40 /var/www
```
### Another direction of remotepath for server  

The reader can to think that is capable create other directory for save, write and read the files in the transfer SFTP server. Well here there is other way of set the remote path of sftp server

```
sudo mkdir /transferencia
sudo mkdir /transferencia/rasp
```

The folder haven't permissions of user only root
```
ls -ld /transferencia/rasp
drwxr-xr-x 2 root root 4096 Apr 26 11:34 /transferencia/rasp
```
Change the permissions of root to i.e. 'ubuntu'
```
sudo chown -R ubuntu:ubuntu /transferencia/rasp
```
Change of the permissions.
```
ls -ld /transferencia/rasp
drwxr-xr-x 2 ubuntu ubuntu 4096 Apr 26 11:34 /transferencia/rasp
```

# Why a SFTP in Ubuntu and not in Windows?

Install and setup a SFTP server is easier in Ubuntu than in Windows because doesn't required more resource or service that only the present in this description. While in Windows is necesary download software additional for connect the SFTP server and management. In sometimes produce problems of open a close connections with the SFTP server.  Not is good closed and then is necessary disconect the SFTP server and to restart the SFTP server for a new transfer files. 
