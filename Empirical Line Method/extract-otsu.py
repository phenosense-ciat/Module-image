import cv2
from matplotlib import pyplot as plt
import numpy as np
import math
import os
import pandas as pd

# Remove the txt existent
if os.path.exists("testfile"):
    os.remove("testfile.txt")
else:
    pass

# Create a new txt file
file = open("testfile.txt", "w")

# Create a Binary Folder or check the existent of one
binaryFolder = 'Binary Folder'
if os.path.exists(binaryFolder):
    pass
else:
    os.mkdir(binaryFolder)

# Create a Histogram Folder or check the existent of one
histogramFolder = 'Histogram Folder'
if os.path.exists(histogramFolder):
    pass
else:
    os.mkdir(histogramFolder)

meanGreen = []
meanRed = []
meanNIR = []

# Begin of for loop
for i in range(0, 2):
    # Read an image and save a variable
    name = "sample-te1-"+str(i).zfill(3)
    image = cv2.imread(name+".jpg", 1)


    # Configurate image
    # imghsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    # imghsv[:, :, 2] = [[max(pixel - 25, 0) if pixel < 190 else min(pixel + 25, 255) for pixel in row] for row in
    #                   imghsv[:, :, 2]]
    # image = cv2.cvtColor(imghsv, cv2.COLOR_HSV2BGR)

    # Extract each channel
    NIR = image[:, :, 0]
    green = image[:,:,1]
    red = image[:,:,2]

    # Convert in floating 32 bits
    g = green.astype(np.float32)
    r = red.astype(np.float32)
    nir = NIR.astype(np.float32)

    # Tell numpy not to complain about division by 0:
    np.seterr(invalid='ignore')

    # Calculate NDVI
    ndvi = (nir - r)/(nir+r)

    # Convert the normalization NDVI in its respective 0-255 DN
    [m,n] = np.shape(ndvi)
    NDVI = np.uint8(127*(ndvi+np.ones((m,n))))

    # Configuration of subplot and calculate of histogram
    histr = cv2.calcHist([NDVI],[0],None,[256],[0,256])
    # plt.subplot(111)
    plt.plot(histr,color = 'b')
    plt.xlim([0,256])
    plt.xlabel('Intensity')
    plt.ylabel('Frequency')
    plt.title('Histogram for NDVI')
    plt.grid(True)
    plt.savefig(os.path.join(histogramFolder, name + '-hist.jpg'))
    plt.close()

    # Otsu's thresholding after Gaussian filtering
    blur = cv2.GaussianBlur(NDVI, (21, 21), 0)
    ret3, th3 = cv2.threshold(blur, 0, 255, cv2.THRESH_OTSU)

    # cv2.namedWindow("Binary", cv2.WINDOW_NORMAL)
    # cv2.resizeWindow("Binary", 800, 600)
    # cv2.imshow("Binary", th3)

    cv2.imwrite(os.path.join(binaryFolder, name + '-binary.jpg') , th3)

    sumadorNIR=0.0  # Acumulate the value of sum of pixel by pixel in the image NIR.
    sumadorGreen=0.0  # Acumulate the value of sum of pixel by pixel in the image Green.
    sumadorRed=0.0  # Acumulate the value of sum of pixel by pixel in the image Red.

    cuentaNIR=0.0 # Conut that there is pixel with value higher than 0.0 grow 1 unit.
    cuentaGreen=0.0 # Conut that there is pixel with value higher than 0.0 grow 1 unit.
    cuentaRed=0.0 # Conut that there is pixel with value higher than 0.0 grow 1 unit.

    # Get average of pixel for each channel
    for i in xrange(1, m):
        for j in xrange(1,n):
            if(th3[i,j]>1.0):  # Contiditon or level for threshold
                if math.isnan(NIR[i,j]):
                    sumadorNIR = sumadorNIR + 0.0
                else:
                    sumadorNIR = sumadorNIR + NIR[i,j]  # acumalate each value of pixel
                    cuentaNIR = cuentaNIR + 1.0  # acumlate the count

                if math.isnan(green[i,j]):
                    sumadorGreen = sumadorGreen + 0.0
                else:
                    sumadorGreen = sumadorGreen + green[i,j]  # acumalate each value of pixel
                    cuentaGreen = cuentaGreen + 1.0  # acumlate the count

                if math.isnan(red[i,j]):
                    sumadorRed = sumadorRed + 0.0
                else:
                    sumadorRed = sumadorRed + red[i,j]  # acumalate each value of pixel
                    cuentaRed = cuentaRed + 1.0  # acumlate the count

    mediaNIR = sumadorNIR/cuentaNIR  # Apply the average of NDVI over plant
    meanNIR.append(mediaNIR)
    s1 = 'The mean NIR by thresholding Otsu = ' + repr(mediaNIR)

    mediaGreen = sumadorGreen/cuentaGreen  # Apply the average of Green over plant
    meanGreen.append(mediaGreen)
    s2 = 'The mean Green by thresholding Otsu = ' + repr(mediaGreen)

    mediaRed = sumadorRed/cuentaRed  # Apply the average of Red over plant
    meanRed.append(mediaRed)
    s3 = 'The mean Red by thresholding Otsu = ' + repr(mediaRed)

    # print s2  # Printing the value Green
    # print s3  # Printing the value Red
    # print s1  # Printing the value NIR

    # plt.show()

    # cv2.imshow("Binary",th3)

    # cv2.imshow("image original",image)

    file.write(name + ".jpg\n")
    file.write(s2 + "\n")
    file.write(s3 + "\n")
    file.write(s1 + "\n")
    file.write("\n")

file.close()
data = np.array([meanGreen, meanRed, meanNIR]).T
df = pd.DataFrame(data)
df.to_csv('list-Otsu.csv', index=False)

