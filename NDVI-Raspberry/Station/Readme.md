# Overview
In this folder is all scripts to work the calculate of the NDVI from a station mobile. We can download this files and completed repository with the command `git clone` from a Raspberry Pi. The file `my_SFTP.py` is in the folder named SFTP, one is goes out of this folder, why? Because it is file that is generic in any Raspberry Pi, it has a different function to calculate one index. Its function is comunicate two device. Therefore that script is in other folder of the repository. In the other hand, the file `on_reboot.sh` has to be create manually (in the section 3 explains how do it). Finally, to remember read this README completly before of begin any installation, any edition of code, each script in this folder has comments explaining its function.

# 1. Order of execution of scripts.

First initialize the script `runCamEventos.py`, inside of it calls to `cam.py`, after calls to `ndviEstacionDemo.py` and finally calls to `my_SFTP.py`. 

# 2. Brief description of each script.
We describe briefly each script that must has to be in the station, each script has its respect comments where explain in details each  code line.

The scripts that must to be in the station are:
```
runCamEventos.py
cam.py
ndviEstacionDemo.py
my_SFTP.py
conteo.txt
speed.txt
on_reboot.sh
(Optional) runCam.py
```

Below the brief description of each of them.

### runCamEventos.py
Execute a rutine where the capture and save photos without distortion the which is dependent of the activation of a magnetic sensor pasive "Reedswitch" that when is activated by a magnet. There are 4 magnet in the physical station therefore capture four picture. This happens through a the mobile body spin waiting the activation of a switch that change the turning sense of the mobile body to complete 360 degree and waiting other switch that indicate the end of spin. The before is programmed with interruptions. The second part is calculate the NDVI and send the indices to plaftorm web think "ThinkSpeak" and the last part is sends the photos saved through SFTP protocole to a server.

### cam.py
Script that capture a photo from the camera of the Raspberry and fix the distortion with OpenCV library generate by the build of the lens of the camera. Finally, it saves the picture in the Raspberry Pi. 

### ndviEstationDemo.py
Script that has two options read a image saved in the device or take directly a picture from camera and apply a radiometric correction through the Empirical Line Method. Finally, the index is calculated and this is saved in the text file named `ndvi.txt` and only when the four indices was calculated they are sent to ThinkSpeak.

### my_SFTP.py
Script that sends the images to server machine through SFTP protocole. This 

### conteo.txt
Text file that allows you to keep track of how many photos have been taken and how many photos have been processed.

### on_reboot.sh
File .sh that contains the library paths that allow to initialize the script of `runCam.py` or `runCamEventos.py` in the boot configured by the `crontab`. Either for a Raspberry Pi with a virtual environment or without it. **We have to create it file with the instructions of the next section. We not recommend download or use this file of the repository.**

### speed.txt
Text file that contains the exposure speed of the camera, which is requested by the `cam.py` script or `ndviEstationDemo.py`. Therefore, it is a file that should not be deleted. It is useful when working under a graphic environment because you can edit this number easily without entering the thick code to change the exposure speed of the camera, because this file is read automatically

### (Optional) runCam.py
Script that performs the same procedure `runCamEventos.py` with the difference that it does not use interrupts but works with the count of the times that happened under a magnet for the capture of photos, when the automatic count is changed four times the direction of rotation and when counting four times the detection of the magnets will stop to calculate the indices and then send the indices to ThinkSpeak and the SFTP server.


