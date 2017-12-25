# Overview
Durantly in this project was developed two way to capture NDVI. One a fix station NDVI and a second portable NDVI for cases where the user needs move in the crop. In this folder there are Python scripts developed for both cases. Inside of each folder there are instructions of usage, installation and important information for garantue the major probability of success. The next section says "Runing a Python + OpenCV script on reboot" this topic is global in both cases because station and portable need run Python script from the boot.

# Running a Python + OpenCV script on reboot
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
### Section Running a Python + OpenCV script on reboot:
- https://www.pyimagesearch.com/2016/05/16/running-a-python-opencv-script-on-reboot/ (Running a Python + OpenCV script on reboot)
