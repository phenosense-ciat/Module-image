# -*- coding: utf-8 -*-
#Cambio en el ajuste de blancos, con filtro red de infragram
#se agrego el ajuste del parametro brillo
#se ajusto los parametros antes de la toma de la foto
#Modifiction from 12/10/2016

import displayTexto
import cv2
import numpy as np
import io
import picamera
import RPi.GPIO as GPIO
import os
import time
#import sys
#import math
#import requests

buttonCapture = 17
buttonShutdown = 27

# Disable alarms
GPIO.setwarnings(False)

GPIO.setmode(GPIO.BCM)
GPIO.setup(buttonCapture, GPIO.IN, GPIO.PUD_UP)
GPIO.setup(buttonShutdown, GPIO.IN, GPIO.PUD_UP)

def my_thinking(channel):
    # Begin the processing of image
    displayTexto.verDisplay('Thinking')

    #Create a memory stream so photos doesn't need to be saved in a file
    stream = io.BytesIO()

    #Get the picture (low resolution, so it should be quite fast)
    #Here you can also specify other parameters (e.g.:rotate the image)
    with picamera.PiCamera() as camera:
        #camera.start_preview()
        #time.sleep(2)
        camera.shutter_speed = 1000 #values in microseconds 0-6000000
        camera.exposure_mode = 'off'
        camera.iso = 100 #values between 0-800
        camera.awb_mode='off'
        camera.awb_gains=(0.56,1.27)
        camera.resolution = (32, 24)
        #camera.resolution = (3280, 2464)
        #camera.brightness = 20 #Values between 0-100
        camera.capture(stream, format='jpeg')

    #Convert the picture into a numpy array
    buff = np.fromstring(stream.getvalue(), dtype=np.uint8)

    #Now creates an OpenCV image
    img = cv2.imdecode(buff, 1)
    ##cv2.imwrite('ngb.png',img)

    #img = cv2.imread('salida.jpg',1)

    #The order of matrix is in other different blue = [:,:,0], green = [:,:,1], red = [:,:,2]
    #Suppose that NIR is in the channel blue by Rocco Filter

    ##---------
    ##Automatic adjust white balance in the image
    ##grayImage = cv2.cvtColor(img,cv2.COLOR_RGB2GRAY)
    ##
    ##NIR = img[:,:,2]#get NIR band
    ##green = img[:,:,1]#get green band
    ##red = img[:,:,0]#get red band
    ##
    ##meanR = np.mean(red) #get the average of red
    ##meanG = np.mean(green)#get the average of green
    ##meanB = np.mean(NIR)#get average of NIR
    ##
    ##meanGray = np.mean(grayImage)#Get average of image gray scale
    ##
    ##redChannel = np.uint8(red.astype(np.float32)*(meanGray/meanR))#Compute the adjust awb in the red channel by gray point
    ##greenChannel = np.uint8(red.astype(np.float32)*(meanGray/meanG))#Compute the adjust awb in the green channel by gray point
    ##blueChannel = np.uint8(NIR.astype(np.float32)*(meanGray/meanB))#Compute the adjust awb in the blue channel by gray point
    ##
    ##img = cv2.merge((redChannel,greenChannel,blueChannel)) #Concatenate the channels in one image.
    ##cv2.imwrite('ngbawb.jpg',img)


    ###-----
    ###Changing of color space in the image
    ##hsvImage = cv2.cvtColor(img,cv2.COLOR_RGB2HSV)
    ##
    ###get the Hue, Saturation and Value of the image
    ##H = hsvImage[:,:,0]
    ##S = hsvImage[:,:,1]
    ##V = hsvImage[:,:,2]
    ##
    ###Fix a gain for multiply with each array Hue, Saturation, Value
    ##gH = 1
    ##gS = 3.4
    ##gV = 1
    ##
    ###Execute multiply changing of value of each element of array
    ##H = np.uint8(np.round(H*gH))
    ##S = np.uint8(np.round(S*gS))
    ##V = np.uint8(np.round(V*gV))
    ##
    ###Concatenate again the array
    ##hsvImage = cv2.merge((H,S,V))
    ##
    ###Return of color space RGB from HSV modified
    ##img= cv2.cvtColor(hsvImage,cv2.COLOR_HSV2RGB)
    ##cv2.imwrite('hsv2rgb.jpg',img)
    ###-------

    #print('Por aquí ya')

    #Begin calculus of NDVI
    NIR = img[:,:,0]
    green = img[:,:,1]
    red = img[:,:,2]

    #Convert the matrix in floating point of 32 bits
    r = red.astype(np.float16)
    g = green.astype(np.float16)
    nir = NIR.astype(np.float16)

    # Parameters ELM

    #Intercept with the y-axis

    yG = 3.4815
    yR = 3.5595
    yNIR = 3.684

    # Build Slope ELM

    greenV = 75.551
    redV = 78.799
    nirV = 81.147

    negLogG = -0.013272*greenV + yG
    negLogR = -0.013433*redV + yR
    negLogNIR = -0.01298*nirV + yNIR

    mG = (negLogG - yG)/greenV
    mR = (negLogR - yR)/redV
    mNIR = (negLogNIR - yNIR)/nirV


    #Transformation number digital DN to Reflectance value by ELM
    nReflRed = mG*r + yG
    nReflNIR = mNIR*nir + yNIR

    ReflRed = np.exp(-1*nReflRed)
    ReflNIR = np.exp(-1*nReflNIR)

    # Tell numpy not to complain about division by 0:
    np.seterr(invalid='ignore')
    ndviWC = (ReflNIR-ReflRed)/(ReflNIR+ReflRed) #calculate NDVI without correction

    # Brief correction NDVI
    ndvi = 2.3329*ndviWC + 0.1756

    print('Esto si se hizo')

    # Get Max value of the NDVI matrix
    ndviMAX = ndvi.max()
    print("The max NDVI value is = "+repr(ndviMAX))

    # Prepare value to NDVI to send ThinkSpeak
    NDVI = '{0:.2f}'.format(ndviMAX)
    message = 'NDVI:'+NDVI
    fn ='/home/pi/ndviHist.txt'
    file = open(fn,"w")
    file.write(NDVI+'\n')
    file.close

    #Send to display
    displayTexto.verDisplay(message)


    #print('Value of NDVI sends to ThinkSpeak is '+NDVI)
    # Send value NDVI to ThinkSpeak Portal
    #r = requests.get("http://labsistemas.javerianacali.edu.co:8002/update?key=9XUY4FEVNOG29S4U&field1="+NDVI)
    #print (r.status_code, r.reason)

displayTexto.verDisplay('Im Ready')
#raw_input("Waiting the action")

GPIO.add_event_detect(buttonCapture, GPIO.FALLING, callback=my_thinking, bouncetime=200)

try:
    GPIO.wait_for_edge(buttonShutdown, GPIO.FALLING)
    displayTexto.verDisplay("Good bye")
    os.system("sudo shutdown now")
except KeyboardInterrupt:
    # clean up GPIO on CTRL+C exit
    GPIO.cleanup()

# clean up GPIO on normal exit
GPIO.cleanup()

#Exit of the script
quit()


