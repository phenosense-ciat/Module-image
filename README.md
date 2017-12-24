# Installing OPENCV in Raspbian Stretch Lite on Raspberry Pi

Based in the next link (1): https://www.pyimagesearch.com/2017/09/04/raspbian-stretch-install-opencv-3-python-on-your-raspberry-pi/
and in the next link (2): http://raspberrypiprogramming.blogspot.com.co/2014/08/change-prompt-color-in-bash.html

The next is way to install OpenCV without virtual environment it is based in the link (2)

require "Installing" 

### Generic stuff

```
sudo apt-get update
sudo apt-get upgrade
sudo rpi-update
sudo reboot
sudo apt-get install build-essential git cmake pkg-config
sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev
sudo apt-get install libgtk2.0-dev
sudo apt-get install libatlas-base-dev gfortran
cd ~
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 3.1.0
cd ~
git clone https://github.com/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout 3.1.0
```

### If you want to use OpenCV with python 2.7 :

```
sudo apt-get install python2.7-dev
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
pip install numpy
cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
make -j4
sudo make install
sudo ldconfig
```

or 

### If you want to use OpenCV with python 3 :

```
sudo apt-get install python3-dev
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
pip install numpy
cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
make -j4
sudo make install
sudo ldconfig
```

## Fix some troubles
In ocations we can have in the same environment two versions Python for example 2.7 and 3.5 in the `pip` may be installed in the version Python 3.5 and not in the Python 2.7. We can fall in the error by follow the Link(1) to use the next lines codes:

```
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo python3 get-pip.py
```

Then pip is installed in the Python 3.5 with directory `/usr/local/lib/python3.5/dist-packages` and when you used `pip install` any packages is installed in the Python 3.5 (for example `pip install numpy` is installed in Python 3.5 and not in Python 2.7) The next error to try install the pip in the Python 2.7 besides of has installed `pip` in Python 3.5 with the next command `sudo apt-get install python-pip`. Then the `pip`is installed in Python 2.7 but we have careful because to use `pip` directly in command line will follow installed the packages in the pip of the version of Python 3.5, for install some package with the pip of the Python 2.7 use the next command `sudo python -m pip install [package]`. There arent problem if your objective is to install other package specificing the version of Python but is complicated in the case to install OpenCV for example because in the rutines by default (in the building) uses pip in first instance and then OpenCV finally to install in Python 3.5 or one versioni of Python undeseareble. We recommend in each environment use one version of Python, or create VIRTUAL ENVIRONMENT with an only version of Python like in the Link (1) is recommended. And if we have an environment with 2 Python version is important check what pip of Python do we using with the next command `pip -V`

### Fix the last case one environment with 2 versions of Python 

Its necessary remove the `pip`of all version of Python for install the `pip` in the version Python desirable. The first is remove the version of `pip` installed that appears in the command line (Terminal). In any case if it was Python 2.7 or Python 3.5. Then suppose that was Python 3.5:
```
pip uninstall pip
```
After uninstall `pip` of the version Python 2.7 with:
```
sudo python -m  pip uninstall pip
```
Last, uninstall the pip of the version Python 2.7 what prohibit to reinstall the `pip` in the Python version desirable. 
```
sudo apt-get purge --auto-remove python-pip
```
This manner remove `pip` of all Python versions. Now we can begin install the `pip` in the desirable version Python. Suppose that the desirable version Python is 2.7
```
sudo apt-get install python2.7-dev
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
```
Now, if we use `pip -V` is installed in the correct location:
```
/usr/local/lib/python2.7/dist-packages   (python2.7)
```

Now if the case is the reverse. Suppose what `pip` is the Python 2.7, then use:
```
pip uninstall pip
```
After use:
```
sudo python3 -m  pip uninstall pip
```
By last
```
sudo apt-get purge --auto-remove python3-pip
```
Therefore we can install `pip` in the desirable version Python in this case the Python 3.5

```
sudo apt-get install python3-dev
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
```

# NDVI

Scripts in Python and Matlab relationship with:
Capture image.
Image processing.
Radiometric and Geometric calibration
