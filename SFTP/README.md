# Overview

Download the file and execute the script `my_SFTP.py` the which has the rutine of SFTP connection.

# Introduction

The script `my_SFTP.py` import Python package `pysftp`, `paramiko` and `socket` the which must have install previously in the raspberry client before of run the script `my_SFTP.py`. For install `pysftp` Python Package we can use the next code lines with permission of super user `sudo` :

```
sudo apt-get update
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
sudo pip install pysftp
```

NOTE: With the first line code `sudo pip install pysftp` after installing to check with `pip list` whether the python package paramiko, crypto, socket was installed in the process. If this doesn't correct. Use the next code lines.  
```
sudo pip install paramiko
sudo pip install socket
```

# To install (SFTP) or library pysftp on Raspberry Pi 3 or 2 in Python 2.7

### Step 1
The following command will ensure that the required dependencies are installed:
```
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
```
### Step 2
The next command install pysftp and its necessary libraries correspondent like paramiko, bcrypt, cffi, pycparser, pynacl (exclusives for the version pysftp) 
```
sudo pip install pysftp
```
### Step 3
Finally, to install socket
```
sudo pip install socket
```
# Procedure for installing and run a SFTP server in Ubuntu
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
sudo service ssh restart
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

Install and setup an SFTP server is easier about Ubuntu than in Windows because doesn't require more resource or service that only the present in this description . While in Windows is necessary download software additional for connecting the SFTP server and management . In sometimes to produce problems of open a close connections with the SFTP server . Not is good closed and then is necessary to disconnect the SFTP server and to restart the SFTP server for a new transfer files .


# References

- Aquí en esta página se encontró como realizar carpetas iniciando con punto, por ejemplo .ssh, .rasp etc. desde el CMD:

(https://superuser.com/questions/64471/create-rename-a-file-folder-that-begins-with-a-dot-in-windows)

- Este es el tutorial que se siguió para configurar un SFTP server para Windows
(https://winscp.net/eng/docs/guide_windows_openssh_server)

- Aquí se evita que busque las hostkey, las initializa como vacias.
(http://stackoverflow.com/questions/38939454/finding-the-host-key-with-pysftp)

- Aquí enseña que cuando el comando pip install 'pythonpackagename' no funciona es porque necesita ser super usuario. Por lo tanto anteponer el prefijo 'sudo' ejemplo sudo pip install 'pythonpackagename'
	
(http://stackoverflow.com/questions/31512422/pip-install-r-oserror-errno-13-permission-denied)

- Aquí explica que para instalar cryptography y paramiko necesita actualizar el raspberry sudo apt-get update e instalar las librerias de build-essential libssl-dev, libffi-dev y python-dev.
(http://stackoverflow.com/questions/22073516/failed-to-install-python-cryptography-package-with-pip-and-setup-py)

- Tutoriales de manejo de SFTP 
(https://www.youtube.com/watch?v=sF0VkwqUyek)

- Busquedas relacionadas con subir archivos via sftp con python.
(http://stackoverflow.com/questions/33751854/upload-file-via-sftp-with-python)

- Busqueda relacionada con How to make a ssh connection with python?
(http://stackoverflow.com/questions/6188970/how-to-make-a-ssh-connection-with-python)

- Busqueda relacionda con  Using secure shell (SSH) for login and secure copy (SCP) for data transfer on Linux
(https://www.howtoforge.com/tutorial/ssh-and-scp-with-public-key-authentication/)

- Busqueda relacionada con SCP File Transfer Between Pi and Windows
(https://raspberrypi.stackexchange.com/questions/39990/scp-file-transfer-between-pi-and-windows)

- Video relacion con How to Install OpenSSH to Windows (poco útil)
(https://www.youtube.com/watch?v=FZyUX-LZHts)

- Connection reset by peer [errno 104] in Python 2.7
(http://stackoverflow.com/questions/33111556/connection-reset-by-peer-errno-104-in-python-2-7)

- Python socket.error: [Errno 104] Connection reset by peer
(http://stackoverflow.com/questions/33981141/python-socket-error-errno-104-connection-reset-by-peer)

- Yet Another 'Connection reset by peer' Error
(http://stackoverflow.com/questions/24874894/yet-another-connection-reset-by-peer-error)

- socket.shutdown vs socket.close

(http://stackoverflow.com/questions/409783/socket-shutdown-vs-socket-close)

- No handlers could be found for logger paramiko
(http://stackoverflow.com/questions/19152578/no-handlers-could-be-found-for-logger-paramiko)

- SFTP links:
1. (https://winscp.net/eng/docs/ui_puttygen)
2. (https://winscp.net/eng/docs/guide_windows_openssh_server)
3. (https://www.racf.bnl.gov/docs/authentication/ssh/sshkeygenwin)


4. (http://www.ubuntugeek.com/install-and-configure-sftp-server-on-ubuntu-16-04-xenial-xerus-server.html)
5. (https://askubuntu.com/questions/420652/how-to-setup-a-restricted-sftp-server-on-ubuntu)
6. (http://www.tecmint.com/install-openssh-server-in-linux/)
7. (http://articlebin.michaelmilette.com/setting-up-openssh-sftp-on-ubuntu/)
8. (http://www.linuxtoday.com/storage/install-and-configure-sftp-server-on-ubuntu-16.04-xenial-xerus-server-160601094003.html)
9. (https://www.google.com.co/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=configure+sftp+server+ubuntu)
10. (https://www.youtube.com/watch?v=HCXDaGIgjcQ)

- Enable SSH ang generate Keys publics and privates
(http://pubs.vmware.com/appdirector-5/index.jsp?topic=%2Fcom.vmware.appdirector5.using.doc%2FGUID-9DE98971-C7AD-493C-AEA3-709F5C72FEBF.html)

- Creation of USERS in a ubuntu with its respectly password
(https://www.youtube.com/watch?v=39-NLKPWyTs)

- Create folders with permissions of write, read files
1. (https://askubuntu.com/questions/19898/whats-the-simplest-way-to-edit-and-add-files-to-var-www)
2. (https://askubuntu.com/questions/6723/change-folder-permissions-and-ownership)
3. (http://stackoverflow.com/questions/23144286/paramiko-python-ioerror-errno-13-permission-denied)
