import pysftp as sftp
import paramiko
import socket

cnopts = sftp.CnOpts()
cnopts.hostkeys = None
paramiko.util.log_to_file('hist.log')

filename = 'testfile_log.txt'

def sftpExample():
    try:
        s = sftp.Connection(host='192.168.0.5',username='RubenDario', password='nanami89',cnopts=cnopts)

        remotepath='/C:/ftp/rasp/testfile_log.txt'
        localpath=filename
        s.put(localpath,remotepath)
        #s.put('C:\ftp\rasp\example.txt')

        s.close()

    except socket.error, e:
        print str(e)

sftpExample()        
