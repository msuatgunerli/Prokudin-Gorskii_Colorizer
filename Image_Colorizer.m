img = imread('6.jpg');
img = rgb2gray(img);
[r,c] = size(img);
rr=r/3;

B = imcrop(img,[1,1,c,rr-1]);
G = imcrop(img,[1,rr+1,c,rr-1]);
R = imcrop(img,[1,2*rr+1,c,rr-1]);

Colorimg(:,:,1) = R;
Colorimg(:,:,2) = G;
Colorimg(:,:,3) = B;

imshow(Colorimg)