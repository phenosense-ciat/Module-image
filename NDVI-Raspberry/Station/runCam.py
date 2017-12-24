import RPi.GPIO as GPIO
import time
import os
nota = "sudo shutdown now"

#Adjust for where your switch is connected
buttonPin1 = 17
#Move motor wrist
pinLED = 18
pinLED2 = 24
GPIO.setmode(GPIO.BCM)
GPIO.setup(buttonPin1,GPIO.IN, GPIO.PUD_UP)
GPIO.setup(pinLED,GPIO.OUT)
GPIO.setup(pinLED2,GPIO.OUT)

GPIO.setwarnings(False)

#Adjust PWM for motor wrist
number = 100
#adjust velocity
velocity = 20
#p spin a side and p1 spin in the other side
p = GPIO.PWM(pinLED,number)
p1 = GPIO.PWM(pinLED2,number)

##while True:
##    #assuming the script to call is long enough we can ignore bouncing
##    if (GPIO.input(buttonPin)):
##        #this is the script that will be called (as root)
##        #os.system("source /usr/local/bin/virtualenvwrapper.sh")
##        #os.system("workon cv")
##        os.system("python /home/pi/cam-fix-undistort.py")
##        os.system("sudo shutdown")

#Begin in the first point
os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
p.start(velocity)
#time.sleep(0.3)
#Waiting the second point
GPIO.wait_for_edge(buttonPin1, GPIO.FALLING)
p.stop()
os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
p.start(velocity)
#time.sleep(0.3)
#Waiting the third point
GPIO.wait_for_edge(buttonPin1, GPIO.FALLING)
p.stop()
os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
p.start(velocity)
#time.sleep(0.3)
#Waiting the fourth point
GPIO.wait_for_edge(buttonPin1, GPIO.FALLING)
p.stop()
os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")

#Point control
#print("flag 1")
print("Returning")
p.stop()
p1.start(velocity)
count=1
while(count<4):
  GPIO.wait_for_edge(buttonPin1, GPIO.FALLING)
  time.sleep(0.2)
  count=count+1
  print("passed")

p1.stop()

#Point control flag 2
#print("Flag 2")

#This prints are point controls in case of bad behaviour. This must have activated

os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("first process")
os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("second process")
os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("third process")
os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("fourth process")
#os.system('sudo python SFTPtutorial7.py')
print("Envio por sftp")
os.system(nota)


#Notas:
#El archivo RunCamPrevio.py es la version
#anterior de RunCam antes de ser editado
#Con esta nueve version.
