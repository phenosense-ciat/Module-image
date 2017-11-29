import RPi.GPIO as GPIO
import time
import os
nota = "sudo shutdown now"

# Adjust for where your switch is connected
buttonPin1 = 17
pinLED = 22
pinLED2 = 23
GPIO.setmode(GPIO.BCM)
GPIO.setup(buttonPin1,GPIO.IN, GPIO.PUD_UP)
GPIO.setup(pinLED,GPIO.OUT)
GPIO.setup(pinLED2,GPIO.OUT)

# Disable alarms 
GPIO.setwarnings(False)

# Number of frequency
number = 100
# Setups PWM pins 
p = GPIO.PWM(pinLED,number)
p1 = GPIO.PWM(pinLED2,number)

#Estado modo estacion
os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
#p.start(80)
#time.sleep(1)
#os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
#time.sleep(1)
#os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
#time.sleep(1)
#os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
print("esperando")
#GPIO.wait_for_edge(buttonPin1, GPIO.RISING)
#p.stop()
#p1.start(80)
print("me devuelvo")
#time.sleep(5)
#GPIO.wait_for_edge(buttonPin1, GPIO.RISING)
#p1.stop()
print("acabe")

os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("primero")
#os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("segundo")
#os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("tercero")
#os.system('/home/pi/.virtualenvs/cv/bin/python ndviEstacionDemo.py')
print("cuarto")
os.system('sudo python SFTPtutorial7.py')
os.system(nota)


    
#Notas:
#El archivo RunCamPrevio.py es la version
#anterior de RunCam antes de ser editado
#Con esta nueve version.
