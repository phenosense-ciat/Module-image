# 1. Order of execution of scripts.

First initialize the script `ndviPortable.py`, inside of it calls to `displayTexto.py`.

# 2. Brief description of each script.
We describe briefly each script that must has to be in the portable, each script has its respect comments where explain in details each  code line.

The scripts that must to be in the station are:
```
ndviPortable.py
displayTexto.py
on_reboot.sh
[font].ttf
```

Below the brief description of each of them.

### ndviPortable.py
Script that has two options read a image saved in the device or take directly a picture from camera and apply a radiometric correction through the Empirical Line Method. Finally, the index is calculated and it is visualized in a display OLED 128x32 Monochrome FeatherWing.

### displayTexto.py
Script that import and use the library Adafruit Python SSD1306 for recieving a string for after to be show in the display OLED 128x32 Monochrome.  

# 3. Installation of library Adafruit Python SSD1306 on Raspberry Pi Zero, 2, 3

### Pinouts

To know the distribution of pinouts of the Adafruit FeatherWing OLED is in the next link: https://learn.adafruit.com/adafruit-oled-featherwing/pinouts

### Wiring

The wiring is following the next tutorial: https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/wiring

### Dependencies

Based in the link: https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/usage

Before using the library you will need to make sure you have a few dependencies installed. Connect to your device using SSH and follow the steps below.

If you're using a Raspberry Pi, install the RPi.GPIO library by executing:
```
sudo apt-get update
sudo apt-get install build-essential python-dev python-pip
sudo pip install RPi.GPIO
```

Finally, on both the Raspberry Pi and Beaglebone Black install the Python Imaging Library and smbus library by executing:
```
sudo apt-get install python-imaging python-smbus
```

Now to download and install the SSD1306 python library code and examples, execute the following commands:
```
sudo apt-get install git
git clone https://github.com/adafruit/Adafruit_Python_SSD1306.git
cd Adafruit_Python_SSD1306
sudo python setup.py install
```

### Usage
We can verify the correct installation assuming that the OLED is good connected.
```
cd Adafruit_Python_SSD1306/examples/
sudo python shapes.py
```
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
