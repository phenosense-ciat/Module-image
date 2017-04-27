import pysftp as sftp
import paramiko
import socket

#The next code lines avoid to has the key of the server machine. Doesn't matter is the key is public or private. Not is called for stablish
#the SFTP connection.
cnopts = sftp.CnOpts() 
cnopts.hostkeys = None
paramiko.util.log_to_file('hist.log')

# Name of file. The file must be togheter with of the script SFTP.py. Otherwise is necessary the rute where is ubicate the file 
filename = 'ndviColor001'
# Extention of the file. I.e .jpg, .pdf, .txt, .png 
ext = '.jpg'
# Complete name of file with your respectly extention.
data = filename+ext
# Direction of file in the localpath
location = '/home/pi/CIAT/'

# Method that stablish the connection
def sftpExample():
    try:
        # 'Host' usually is the IP of the server machine, 'username' is the name of user of the server machine with the priviliges of administer or with user that start the server machine. 'password' is the pass of the usuer the cnopts is equal cnopts is default. 
        s = sftp.Connection(host='192.168.0.6',username='ubuntu', password='usuario',cnopts=cnopts)

        # Direction of remotepath in the server machine is necessary to end put the complete filename to send
        remotepath = '/var/www/'+data
        # Direction of localpath in the client machine (ubication + complete name of the file)
        localpath = location+data
        
        # Write in the remotepath a file or other words send a file to server from client (raspberry pi)
        s.put(localpath,remotepath)
        
        # If the server machine is Windows comment of above code and uncomment the next  
        #s.put('C:\ftp\rasp\example.txt')

        # Close the SFTP connection
        s.close()

    except socket.error, e:
        print str(e)

# Called the method that send a file to server machine
sftpExample()        
