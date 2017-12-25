import pysftp as sftp
import paramiko
import socket
import time
from datetime import datetime

cnopts = sftp.CnOpts()
cnopts.hostkeys = None
paramiko.util.log_to_file('hist.log')
#transport.auth_none('root')

x = datetime.today().strftime("%Y-%m-%d")

filename = 'ciat_'+x
filename1 = '2ciat_'+x
filename2 = '3ciat_'+x
filename3 = '4ciat_'+x
ext = '.jpg'
data = filename+ext
data1 = filename+ext
data2 = filename+ext
data3 = filename+ext
location = '/home/pi/'

ip='131.196.208.135' 

def sftpExample():
    try:
        #File Zero (original)
        s = sftp.Connection(host=ip,port=9023,username='phenosense', password='$P20172!',cnopts=cnopts)
        remotepath='/home/phenosense/phenosense/public/sites/default/files/imagesremote/'+data
        localpath=location+data
        s.put(localpath,remotepath)
        #s.put('C:\ftp\rasp\example.txt')
        s.close()

##        #File 1
##        s = sftp.Connection(host=ip,port=9023,username='phenosense', password='$P20172!',cnopts=cnopts)
##        remotepath='/home/phenosense/phenosense/public/sites/default/files/imagesremote/'+data1
##        localpath=location+data
##        s.put(localpath,remotepath)
##        #s.put('C:\ftp\rasp\example.txt')
##        s.close()
##
##        #File 2
##        s = sftp.Connection(host=ip,port=9023,username='phenosense', password='$P20172!',cnopts=cnopts)
##        remotepath='/home/phenosense/phenosense/public/sites/default/files/imagesremote/'+data2
##        localpath=location+data
##        s.put(localpath,remotepath)
##        #s.put('C:\ftp\rasp\example.txt')
##        s.close()
##
##        #File 3
##        s = sftp.Connection(host=ip,port=9023,username='phenosense', password='$P20172!',cnopts=cnopts)
##        remotepath='/home/phenosense/phenosense/public/sites/default/files/imagesremote/'+data3
##        localpath=location+data
##        s.put(localpath,remotepath)
##        #s.put('C:\ftp\rasp\example.txt')
##        s.close()

    except socket.error, e:
        print str(e)

if __name__=='__main__':

    sftpExample()        
