#!/usr/bin/python
from Adafruit_MotorHAT import Adafruit_MotorHAT, Adafruit_DCMotor

import RPi.GPIO as GPIO
import time
import os
import atexit
nota = "sudo shutdown now"

mh = Adafruit_MotorHAT(addr=0x60)

def turnOffMotors():
	mh.getMotor(1).run(Adafruit_MotorHAT.RELEASE)

atexit.register(turnOffMotors)

myMotor = mh.getMotor(1)

myMotor.setSpeed(255)
myMotor.run(Adafruit_MotorHAT.FORWARD);

myMotor.run(Adafruit_MotorHAT.RELEASE);

#Adjust for where your switch is connected
buttonPin1 = 17
buttonEnd1 = 27
buttonEnd2 = 22
#Move motor wrist

GPIO.setmode(GPIO.BCM)
GPIO.setup(buttonPin1,GPIO.IN, GPIO.PUD_UP)
GPIO.setup(buttonEnd1,GPIO.IN, GPIO.PUD_UP)
GPIO.setup(buttonEnd2,GPIO.IN, GPIO.PUD_UP)

GPIO.setwarnings(False)

def my_foto(channel):
    myMotor.run(Adafruit_MotorHAT.RELEASE)
    # Uncomment this line of code and comment on the following if you are working with a virtual environment. Otherwise do not take any action.
    #os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
    os.system("sudo python cam.py")
    myMotor.run(Adafruit_MotorHAT.FORWARD)
    #time.sleep(0.3)

GPIO.add_event_detect(buttonPin1, GPIO.FALLING, callback=my_foto, bouncetime=200)

try:
    print("begin")
    myMotor.run(Adafruit_MotorHAT.FORWARD)
    GPIO.wait_for_edge(buttonEnd1, GPIO.FALLING)
    print("stop")
    myMotor.run(Adafruit_MotorHAT.RELEASE)
    #Point control of flag 1
    #print("flag 1")
    print("Returning")
    myMotor.run(Adafruit_MotorHAT.BACKWARD)
    GPIO.remove_event_detect(buttonPin1)
    GPIO.wait_for_edge(buttonEnd2, GPIO.FALLING)
    print("Stop")
    myMotor.run(Adafruit_MotorHAT.RELEASE)
    #Point control flag 2
    #print("Flag 2")
    for x in range (1,5):
        #This prints are point controls in case of bad behaviour. This must have activated.
        #Uncomment this line of code and comment on the following if you are working with a virtual environment. Otherwise do not take any action.
        #os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
        os.system('sudo python ndviEstacionDemo.py')
        print("process_"+str(x))        
    #os.system('sudo python SFTPtutorial7.py')
    print("Envio por sftp")
    os.system(nota)

except KeyboardInterrupt:
    GPIO.cleanup()

GPIO.cleanup()
quit()
#Notas:
#El archivo RunCamPrevio.py es la version
#anterior de RunCam antes de ser editado
#Con esta nueve version.
