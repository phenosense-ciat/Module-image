# 1. Order of execution of scripts.

First initialize the script `runCamEventos.py`, inside of it calls to `cam.py`, after calls to `ndviEstacionDemo.py` and finally calls to `SFTP.py`. 

# 2. Brief description of each script.
Here a brief description of each file in the station, each script has its respect comments where explain in details each line of code.

### runCamEventos.py
Execute a rutine where the capture and save photos without distortion the which is dependent of the activation of a magnetic sensor pasive "Reedswitch" that when is activated by a magnet. There are 4 magnet in the physical station therefore capture four picture. This happens through a the mobile body spin waiting the activation of a switch that change the turning sense of the mobile body to complete 360 degree and waiting other switch that indicate the end of spin. The before is programmed with interruptions. The second part is calculate the NDVI and send the indices to plaftorm web think "ThinkSpeak" and the last part is sends the photos saved through SFTP protocole to a server.

### cam.py
Script that capture a photo from the camera of the Raspberry and fix the distortion with OpenCV library generate by the build of the lens of the camera. Finally, it saves the picture in the Raspberry Pi. 

### ndviEstationDemo.py
Script that has two options read a image saved in the device or take directly a picture from camera and apply a radiometric correction through the Empirical Line Method. Finally, the index is calculated and this is saved in the text file named `ndvi.txt` and only when the four indices was calculated they are sent to ThinkSpeak.

### SFTP.py
Script that sends the images to server machine trough SFTP protocole.

### conteo.txt
Text file that allows you to keep track of how many photos have been taken and how many photos have been processed.

### on_reboot.sh
File .sh that contains the library paths that allow to initialize the script of `runCam.py` or `runCamEventos.py` in the boot configured by the `crontab`. Either for a Raspberry Pi with a virtual environment or without it. This file we have to creat it with the instructions of the next section. We not recommend download or use this file of the repository.

### speed.txt
Text file that contains the exposure speed of the camera, which is requested by the `cam.py` script or `ndviEstationDemo.py`. Therefore, it is a file that should not be deleted. It is useful when working under a graphic environment because you can edit this number easily without entering the thick code to change the exposure speed of the camera, because this file is read automatically

### runCam.py
Script that performs the same procedure `runCamEventos.py` with the difference that it does not use interrupts but works with the count of the times that happened under a magnet for the capture of photos, when the automatic count is changed four times the direction of rotation and when counting four times the detection of the magnets will stop to calculate the indices and then send the indices to ThinkSpeak and the SFTP server.

# 3. Running a Python + OpenCV script on reboot
The developed here is based in this source: https://www.pyimagesearch.com/2016/05/16/running-a-python-opencv-script-on-reboot/

### Create launcher
Before we can execute our Python script on reboot, we first need to create a shell script that performs two important tasks:

- **(Optional) Accesses our Python virtual environment**. I’ve marked this step as optional only because in some cases, you may not be using a Python virtual environment. But if you’ve followed any of the OpenCV install tutorials on this blog, then this step is not optional since your OpenCV bindings are stored in a virtual environment.
- **Executes our Python script**. This is where all the action happens. We need to (1) change directory to where our Python script lives and (2) execute it

Therefore the optional point can be avoid but not the second part, then we can create a shell script to execute the Python script without virtual environment.
#### case 1
we create a shell script named `on_reboot.sh`. For the case **without virtual environment** or even sill having created it but not use it in the shell script because inside of the Python script we can call and execute inside of such virtual environment. 
```
#!/bin/bash

cd /home/pi
python runCamEventos.py
```
#### case 2
When we have a **virtual environment**. We use the next commands.
```
#!/bin/bash

source /home/pi/.profile
workon cv
cd /home/pi
python runCamEventos.py
```
where (cv) is a **virtual environment** with a specific Python version.

After adding these lines to to your `on_reboot.sh` , save the file and then. Then, to make it executable, you’ll need to `chmod`  it:
```
chmod +x on_reboot.sh
```
After changing the permissions of the file to executable.

### Edit crontab for executing the shell script

Now that we have defined the `on_reboot.sh`  shell script, let’s update the crontab to call it on system reboot.

Simply start by executing the following command to edit the root user’s crontab:
```
sudo crontab -e
```
In the bottom of the file put the next lines codes.
```
@reboot /home/pi/on_reboot.sh
```
Once you have finished editing the crontab, save the file and exit the editor — the changes to crontab will be automatically applied. Then at next reboot, the `on_reboot.sh`  script will be automatically executed.

### Some problems when we create the launcher
In ocations we can have problems when we create the launcher, not working still good done the steps of previous section. One reason is due to previous installations done in the Raspberry Pi by other projects, experiments, hoobies and could to change, to edit or to damage the PATH without knowing us, therefore this launcher maybe not working. One manner of fix this problem is add other code lines to `on_reboot.sh` in the `crontab`.
#### case 1
Edit `on_reboot.sh` this way :
```
#!/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

cd /home/pi
python runCamEventos.py
```
#### case 2
When we have a **virtual environment**.
```
#!/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

source /home/pi/.profile
workon cv
cd /home/pi
python runCamEventos.py
```
where (cv) is a **virtual environment** with a specific Python version.

In the `crontab` edit it in the bottom of the file of the next way. 
But before remember for editing `crontab` use in the terminal
```
sudo crontab -e
```
After edit it
```
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin/:/bin:/sbin

@reboot /home/pi/on_reboot.sh
```
We emphasize that it is not the correct way to fix the damage, the correct thing is to fix the PATH to what it was before modifying it so that in future installations of libraries or execution of Python scripts do not have any inconveniences. What has been done is a solution that works quite well but maybe it only serves for this project and not for others.

# Reference
### Section 3:
- https://www.pyimagesearch.com/2016/05/16/running-a-python-opencv-script-on-reboot/ (Running a Python + OpenCV script on reboot)
