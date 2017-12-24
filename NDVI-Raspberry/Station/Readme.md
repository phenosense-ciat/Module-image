# Order of execution of scripts.

First initialize the script `runCamEventos.py`, inside of it calls to `cam.py`, after calls to `ndviEstacionDemo.py` and finally calls to `SFTP.py`. 

# Brief description of each script.
Here a brief description of each file in the station, each script has its respect comments where explain in details each line of code.
### runCamEventos.py

Execute a rutine where the capture and save photos without distortion the which is dependent of the activation of a magnetic sensor pasive "Reedswitch" that when is activated by a magnet. There are 4 magnet in the physical station therefore capture four picture. This happens through a the mobile body spin waiting the activation of a switch that change the turning sense of the mobile body to complete 360 degree and waiting other switch that indicate the end of spin. The before is programmed with interruptions. The second part is calculate the NDVI and send the indices to plaftorm web think "ThinkSpeak" and the last part is sends the photos saved through SFTP protocole to a server.

### cam.py
Script that capture a photo from the camera of the Raspberry and fix the distortion with OpenCV library generate by the build of the lens of the camera. Finally, it saves the picture in the Raspberry Pi. 

### ndviEstationDemo.py
Script that has two options read a image saved in the device or take directly a picture from camera and apply a radiometric correction through the Empirical Line Method. Finally, the index is calculated and this is saved in the text file named 'ndvi.txt' and only when the four indices was calculated they are sent to ThinkSpeak.

### SFTP.py
Script that sends the images to server machine trough SFTP protocole.

### conteo.txt
Text file that allows you to keep track of how many photos have been taken and how many photos have been processed.

### on_reboot.sh
File .sh that contains the library paths that allow to initialize the script of `runCam.py` or `runCamEventos.py` in the boot configured by the `crontab`. Either for a Raspberry Pi with a virtual environment or without it.

