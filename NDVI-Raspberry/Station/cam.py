import time
from datetime import datetime
import picamera
import cv2
import io
import numpy as np
import os.path

x = datetime.today().strftime("%Y-%m-%d")

file = open("speed.txt", "r")
w = file.readlines()

#Creation an im memory strem
stream = io.BytesIO()

speed = int(w[1])
filename='ciat_'+x

file = open("conteo.txt","r")
w = file.readlines()

cuenta = int(w[1])

with picamera.PiCamera() as camera:
    #camera.start_preview()
    #time.sleep(5)
    camera.awb_mode='off'
    camera.awb_gains=(0.57,1.35)
    camera.resolution = (3280, 2464)
    #Parameters fix for exposure
    #camera.exposure_mode = 'off'
    camera.shutter_speed = speed
    camera.ISO = 100
    #Other parameters by default
    camera.brightness = 50
    camera.contrast = 0
    camera.saturation = 0
    camera.sharpness = 0
    camera.exposure_compensation = 0
    camera.capture(stream, format = 'jpeg')


#Convert  the picture into a numpy array
buff = np.fromstring(stream.getvalue(),dtype=np.uint8)

#Now create an OpenCV image
image = cv2.imdecode(buff,1)

dist = np.array([0.177862857743418, -0.254303591272533,  0.005644936356933, 0.001247279996218, 0.000000000000000])
mtx = np.matrix([[2511.826513697280000, 0, 1676.903161780660600],[0, 2695.418467746039800, 1239.544777325847000],[0,0, 1]])

h,  w = image.shape[:2]
newcameramtx, roi=cv2.getOptimalNewCameraMatrix(mtx,dist,(w,h),1,(w,h))

# undistort
dst = cv2.undistort(image, mtx, dist, None, newcameramtx)

# crop the image
x,y,w,h = roi
dst = dst[y:y+h, x:x+w]

#write text
font = cv2.FONT_HERSHEY_SIMPLEX
cv2.putText(dst, 'shutter: '+str(speed)+', ISO: 100, exposure mode: off.', (10,25),font,1,(255,255,255),2)
dst = image

if(cuenta==1):
    cv2.imwrite(filename+'.jpg',dst)
if(cuenta==2):
    cv2.imwrite(str(cuenta)+filename+'.jpg',dst)
if(cuenta==3):
    cv2.imwrite(str(cuenta)+filename+'.jpg',dst)
if(cuenta==4):
    cv2.imwrite(str(cuenta)+filename+'.jpg',dst)
    cuenta = 0
cuenta = cuenta + 1

file = open("conteo.txt","w")
file.write("Cuenta"+"\n"+str(cuenta))
file.close
