import cv2
from matplotlib import pyplot as plt
import numpy as np
from numpy import linalg as LA
import math
import os
import operator
import pandas as pd

# Remove the txt existent
if os.path.exists("testfileRosin"):
    os.remove("testfileRosin.txt")
else:
    pass

# Create a new txt file
file = open("testfileRosin.txt", "w")

# Create a Binary Folder or check the existent of one
binaryFolder = 'Binary Folder Rosin'
if os.path.exists(binaryFolder):
    pass
else:
    os.mkdir(binaryFolder)

# Create a Histogram Folder or check the existent of one
histogramFolder = 'Histogram Folder Rosin'
if os.path.exists(histogramFolder):
    pass
else:
    os.mkdir(histogramFolder)

meanGreen = []
meanRed = []
meanNIR = []

# Begin of for loop
for i in range(0, 51):
    # Read an image and save a variable
    name = "sample-te1-" + str(i).zfill(3)
    image = cv2.imread(name + ".jpg", 1)

    # Extract each channel
    NIR = image[:, :, 0]
    green = image[:, :, 1]
    red = image[:, :, 2]

    # Convert in floating 32 bits
    g = green.astype(np.float32)
    r = red.astype(np.float32)
    nir = NIR.astype(np.float32)

    # Tell numpy not to complain about division by 0:
    np.seterr(invalid='ignore')

    # Calculate Green Normalization
    normalizeGreen = g / (nir + r + g)

    # Convert the normalization in its respective 0-255 DN
    [m, n] = np.shape(normalizeGreen)
    normGreen = np.uint8(255 * normalizeGreen)

    # Configuration of subplot and calculate of histogram
    histr = cv2.calcHist([normGreen], [0], None, [256], [0, 256])
    # plt.subplot(111)
    plt.plot(histr, color='b')
    plt.xlim([0, 256])
    plt.xlabel('Intensity')
    plt.ylabel('Frequency')
    plt.title('Histogram for Green normalization')
    plt.grid(True)
    plt.savefig(os.path.join(histogramFolder, name + '-hist.jpg'))
    plt.close()

    # Rosin's thresholding after Gaussian filtering
    blur = cv2.GaussianBlur(normGreen, (15, 15), 0)

    # find best threshold
    pos_peak, peak_max = max(enumerate(histr), key=operator.itemgetter(1))

    p1 = np.array([pos_peak, peak_max[0]])

    # find last non - empty bin

    ind_nonZero = np.where(histr > 0)[0]
    last_zeroBin = ind_nonZero[-1]
    p2 = np.array([last_zeroBin, histr[last_zeroBin]])
    best_idx = -1
    max_dist = -1
    for x0 in range(pos_peak, last_zeroBin):
        y0 = histr[x0]
        a = p1 - p2
        b = np.array([x0, y0]) - p2
        cross_ab = a[0] * b[1] - b[0] * a[1]
        d = LA.norm(cross_ab) / LA.norm(a)
        if d > max_dist:
            best_idx = x0
            max_dist = d

    # Apply thresholding
    th3 = np.ones((m, n))

    for w in range(0, m):
        for h in range(0, n):
            intensity = normGreen[w, h]
            if intensity <= best_idx - 0.0:
                th3[w, h] = 0.0
            else:
                th3[w, h] = 255.0
                # print x

    th3 = np.uint8(th3)

    cv2.rectangle(th3, (0, 0), (n, m), (0, 0, 0), 250)
    off = 150
    cv2.rectangle(th3, (0 + off, 0 + off), (n - off, m - off), (0, 0, 0), 50)

    # cv2.namedWindow("Binary", cv2.WINDOW_NORMAL)
    # cv2.resizeWindow("Binary", 800, 600)
    # cv2.imshow("Binary", th3)

    cv2.imwrite(os.path.join(binaryFolder, name + '-binary.jpg'), th3)

    sumadorNIR = 0.0  # Acumulate the value of sum of pixel by pixel in the image NIR.
    sumadorGreen = 0.0  # Acumulate the value of sum of pixel by pixel in the image Green.
    sumadorRed = 0.0  # Acumulate the value of sum of pixel by pixel in the image Red.

    cuentaNIR = 0.0  # Conut that there is pixel with value higher than 0.0 grow 1 unit.
    cuentaGreen = 0.0  # Conut that there is pixel with value higher than 0.0 grow 1 unit.
    cuentaRed = 0.0  # Conut that there is pixel with value higher than 0.0 grow 1 unit.

    # Get average of pixel for each channel
    for i in xrange(1, m):
        for j in xrange(1, n):
            if (th3[i, j] > 1.0):  # Contiditon or level for threshold
                if math.isnan(NIR[i, j]):
                    sumadorNIR = sumadorNIR + 0.0
                else:
                    sumadorNIR = sumadorNIR + NIR[i, j]  # acumalate each value of pixel
                    cuentaNIR = cuentaNIR + 1.0  # acumlate the count

                if math.isnan(green[i, j]):
                    sumadorGreen = sumadorGreen + 0.0
                else:
                    sumadorGreen = sumadorGreen + green[i, j]  # acumalate each value of pixel
                    cuentaGreen = cuentaGreen + 1.0  # acumlate the count

                if math.isnan(red[i, j]):
                    sumadorRed = sumadorRed + 0.0
                else:
                    sumadorRed = sumadorRed + red[i, j]  # acumalate each value of pixel
                    cuentaRed = cuentaRed + 1.0  # acumlate the count

    mediaNIR = sumadorNIR / cuentaNIR  # Apply the average of NDVI over plant
    meanNIR.append(mediaNIR)
    s1 = 'The mean NIR by thresholding Rosin = ' + repr(mediaNIR)

    mediaGreen = sumadorGreen / cuentaGreen  # Apply the average of Green over plant
    meanGreen.append(mediaGreen)
    s2 = 'The mean Green by thresholding Rosin = ' + repr(mediaGreen)

    mediaRed = sumadorRed / cuentaRed  # Apply the average of Red over plant
    meanRed.append(mediaRed)
    s3 = 'The mean Red by thresholding Rosin = ' + repr(mediaRed)

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
df.to_csv('list-Rosin.csv', index=False)

# Reference
# http://stackoverflow.com/questions/12881926/create-a-new-rgb-opencv-image-using-python
# https://en.wikipedia.org/wiki/Norm_(mathematics)
# https://docs.scipy.org/doc/numpy/reference/generated/numpy.linalg.norm.html
# http://www.codehamster.com/2015/03/09/different-ways-to-calculate-the-euclidean-distance-in-python/
# http://stackoverflow.com/questions/1401712/how-can-the-euclidean-distance-be-calculated-with-numpy
# https://cheatsheets.quantecon.org/
# https://www.mathworks.com/matlabcentral/answers/117178-what-does-the-function-norm-do
# http://stackoverflow.com/questions/4588628/find-indices-of-elements-equal-to-zero-from-numpy-array
# https://github.com/bornreddy/smart-thresholds/blob/master/basic_threshold.py
# https://www.mathworks.com/help/images/ref/im2uint8.html
#
