a = imread('sample-te1-011.jpg');
a = im2double(a);
a1 = a(:,:,1);
a2 = a(:,:,2);
a3 = a(:,:,3);
norm = a2./(a1+a2+a3);
norm2 = 255.*norm;
x = im2uint8(norm);
imhist(x)
[counts,binLocations] = imhist(x);
best_idx = RosinThreshold(counts)

[m,n] = size(norm);
th3=zeros(m,n);
for i=1:m
   for j=1:n
       if x(i,j)<best_idx-6
           y=0;
       else
           y=255;
       end
       th3(i,j)=y;
   end   
end
imshow(th3)

