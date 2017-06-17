# import the necessary packages
import argparse
import cv2
from cv2 import CV_LOAD_IMAGE_COLOR
import numpy as np

# initialize the list of reference points and boolean indicating
# whether cropping is being performed or not
refPt = []
cropping = False

def click_and_crop(event, x, y, flags, param):
    # grab references to the global variables
    global refPt, cropping

    # if the left mouse button was clicked, record the starting
    # (x, y) coordinates and indicate that cropping is being
    # performed
    if event == cv2.EVENT_LBUTTONDOWN:
        refPt = [(x, y)]
        cropping = True

    # check to see if the left mouse button was released
    elif event == cv2.EVENT_LBUTTONUP:
        # record the ending (x, y) coordinates and indicate that
        # the cropping operation is finished
        refPt.append((x, y))
        cropping = False

        # draw a rectangle around the region of interest
        cv2.rectangle(image, refPt[0], refPt[1], (0, 255, 0), 2)
        cv2.imshow("image", image)


#This code is for input by console supposed Linux, Mac or by he same Command Prompt

# ap = argparse.ArgumentParser()
# ap.add_argument("-i", "--image", required=True, help="Path to the image")
# args = vars(ap.parse_args())

# load the image, clone it, and setup the mouse callback function
image = cv2.imread("sample-te1-011.jpg",1)
clone = image.copy()
cv2.namedWindow("image",cv2.WINDOW_NORMAL)
cv2.resizeWindow("image", 1200,720)
cv2.setMouseCallback("image", click_and_crop)

# keep looping until the 'q' key is pressed
while True:
    # display the image and wait for a keypress
    # cv2.namedWindow("image", cv2.CV_WINDOW_AUTOSIZE)
    # cv2.setWindowProperty("image", cv2.WND_PROP_FULLSCREEN, cv2.cv.CV_WINDOW_FULLSCREEN)
    cv2.imshow("image", image)
    key = cv2.waitKey(1) & 0xFF

    # if the 'r' key is pressed, reset the cropping region
    if key == ord("r"):
        image = clone.copy()

    # if the 'c' key is pressed, break from the loop
    elif key == ord("c"):
        break

# if there are two reference points, then crop the region of interest
# from teh image and display it
if len(refPt) == 2:
    roi = clone[refPt[0][1]:refPt[1][1], refPt[0][0]:refPt[1][0]]
    cv2.imshow("ROI", roi)

    #extract the waveband of the image Green, red, NIR
    NIR = roi[:, :, 0]
    green = roi[:,:,1]
    red = roi[:,:,2]

    #Calculate the mean of each band and is printed
    meanGreen = np.mean(green)
    print (meanGreen)
    meanRed = np.mean(red)
    print (meanRed)
    meanNIR = np.mean(NIR)
    print (meanNIR)

    cv2.waitKey(0)

# close all open windows
cv2.destroyAllWindows()