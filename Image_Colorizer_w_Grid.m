clc
clear all

%Channel Order -top to bottom- = B,G,R%

img = imread('6.jpg');
[x,y,z] = size(img);

if z == 3
img = rgb2gray(img);
end
    
[r,c] = size(img);
rr=r/3;
rr= floor(rr);

B = imcrop(img,[1,1,c,rr-1]);
G = imcrop(img,[1,rr+1,c,rr-1]);
R = imcrop(img,[1,2*rr+1,c,rr-1]);

Colorimg(:,:,1) = R;
Colorimg(:,:,2) = G;
Colorimg(:,:,3) = B;

subplot(2,3,1), subimage(R);
text(0.5,0.5,'Red Channel', 'HorizontalAlignment','left','VerticalAlignment', 'bottom', 'fontsize',16); axis off;
subplot(2,3,2), subimage(G);
text(0.5,0.5,'Green Channel','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;
subplot(2,3,3), subimage(B);
text(0.5,0.5,'Blue Channel','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;
subplot(2,3,5), subimage(Colorimg);
text(0.5,0.5,'Colorized Image','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;
%imshow(Colorimg)