import pysftp as sftp
import paramiko
import socket

cnopts = sftp.CnOpts()
cnopts.hostkeys = None
paramiko.util.log_to_file('hist.log')
#transport.auth_none('root')

filename = 'ndviColor001'
ext = '.jpg'
data = filename+ext

def sftpExample():
    try:
        s = sftp.Connection(host='192.168.0.6',username='ubuntu', password='usuario',cnopts=cnopts)

        remotepath='/var/www/'+data
        localpath=data
        s.put(localpath,remotepath)
        #s.put('C:\ftp\rasp\example.txt')

        s.close()

    except socket.error, e:
        print str(e)

sftpExample()        
