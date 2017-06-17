import cv2
import numpy as np


dist = np.array([0.177862857743418, -0.254303591272533,  0.005644936356933, 0.001247279996218, 0.000000000000000])
mtx = np.matrix([[2511.826513697280000, 0, 1676.903161780660600],[0, 2695.418467746039800, 1239.544777325847000],[0,0, 1]])

img = cv2.imread('calcam6.jpg')
h,  w = img.shape[:2]
newcameramtx, roi=cv2.getOptimalNewCameraMatrix(mtx,dist,(w,h),1,(w,h))

# undistort
dst = cv2.undistort(img, mtx, dist, None, newcameramtx)

# crop the image
x,y,w,h = roi
dst = dst[y:y+h, x:x+w]
cv2.imwrite('calibresult.png',dst)

