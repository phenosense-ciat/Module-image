import RPi.GPIO as GPIO
import time
import os
nota = "sudo shutdown now"

#Adjust for where your switch is connected
buttonPin1 = 17
buttonEnd1 = 27
buttonEnd2 = 22
#Move motor wrist
pinLED = 18
pinLED2 = 24
GPIO.setmode(GPIO.BCM)
GPIO.setup(buttonPin1,GPIO.IN, GPIO.PUD_UP)
GPIO.setup(buttonEnd1,GPIO.IN, GPIO.PUD_UP)
GPIO.setup(buttonEnd2,GPIO.IN, GPIO.PUD_UP)
GPIO.setup(pinLED,GPIO.OUT)
GPIO.setup(pinLED2,GPIO.OUT)

GPIO.setwarnings(False)

#Adjust PWM for motor wrist
number = 100
#adjust velocity
velocity = 100
#p spin a side and p1 spin in the other side
p = GPIO.PWM(pinLED,number)
p1 = GPIO.PWM(pinLED2,number)

def my_foto(channel):
    p.stop()
    # Uncomment this line of code and comment on the following if you are working with a virtual environment. Otherwise do not take any action.
    #os.system("/home/pi/.virtualenvs/cv/bin/python cam.py")
    os.system("sudo python cam.py")
    p.start(velocity)
    #time.sleep(0.3)

GPIO.add_event_detect(buttonPin1, GPIO.FALLING, callback=my_foto, bouncetime=200)

try:
    p.start(velocity)
    GPIO.wait_for_edge(buttonEnd1, GPIO.FALLING)
    p.stop()
    #Point control of flag 1
    #print("flag 1")
    print("Returning")
    p1.start(velocity)
    GPIO.remove_event_detect(buttonPin1)
    GPIO.wait_for_edge(buttonEnd2, GPIO.FALLING)
    p1.stop()
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
