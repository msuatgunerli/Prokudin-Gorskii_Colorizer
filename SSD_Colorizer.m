clc
clear all

img = imread('6.jpg');
[ylen,xlen] = size(img);

ylensin = ylen/3;

B = imcrop(img,[1,1,xlen,ylensin-1]);
G = imcrop(img,[1,ylensin+1,xlen,ylensin-1]);
R = imcrop(img,[1,2*ylensin+1,xlen,ylensin-1]);

ref_img_region = G;
[ylenref,xlenref] = size(ref_img_region);
ref_img_region = ref_img_region(ceil((ylenref-50)/2) :ceil((ylenref-50)/2) + 50,ceil((xlenref-50)/2) :ceil((xlenref-50)/2) + 50);
%disp(size(ref_img_region));
ref_img_region = double(ref_img_region);

%view the selected region%
%ref_img_region = uint8(ref_img_region);

%Basic Alignment
ColorImg_aligned_old = cat(3,R,G,B);
imshow(ColorImg_aligned_old);

[red_row,red_col] = size(R);
[green_row,green_col] = size(G);
align(G,R)

% checking SSD for cropped part of the images for faster calculation 
    cropped_red = R(ceil((red_row-50)/2) : ceil((red_row-50)/2) + 50,ceil((red_col-50)/2) :ceil((red_col-50)/2) + 50);
cropped_green = G(ceil((green_row-50)/2) : ceil((green_row-50)/2) + 50,ceil((green_col-50)/2) :ceil((green_col-50)/2) + 50);

    MiN = 9999999999;
    r_index = 0;
    r_dim = 1;
    % Modifications
    for i = -10:10
        for j = -10:10
            ssd = SSD(cropped_green,circshift(cropped_red,[i,j])); %circshift(A,[i,j])
            if ssd < MiN
                MiN = ssd;
                r_index = i;
                r_dim = j;
            end
        end
    end
    
    alignedR = circshift(R,[r_index,r_dim]);
    alignedG = circshift(G,[r_index,r_dim]);
    alignedB = circshift(B,[r_index,r_dim]);
    
ColorImg_aligned(:,:,1) = alignedR;
ColorImg_aligned(:,:,2) = alignedG;
ColorImg_aligned(:,:,3) = alignedB;
%SSD(a1,a2)

%subplot(2,3,1), subimage(R);
%text(0.5,0.5,'Red Channel', 'HorizontalAlignment','left','VerticalAlignment', 'bottom', 'fontsize',16); axis off;
%subplot(2,3,2), subimage(G);
%text(0.5,0.5,'Green Channel','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;
%subplot(2,3,3), subimage(B);
%text(0.5,0.5,'Blue Channel','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;
%subplot(2,3,5), subimage(ref_img_region);
%text(0.5,0.5,'Colorized Image','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;

%ColorImg_aligned = cat(3,alignedR,alignedB,alignedG);
%imshow(ColorImg_aligned)
deltaImage = ColorImg_aligned - ColorImg_aligned_old;
deltaR = alignedR - R;
deltaG = alignedG - G;
deltaB = alignedB - B;

subplot(2,3,1), subimage(ColorImg_aligned_old);
text(0.5,0.5,'Basic Alignment', 'HorizontalAlignment','left','VerticalAlignment', 'bottom', 'fontsize',16); axis off;
subplot(2,3,2), subimage(ColorImg_aligned);
text(0.5,0.5,'SSD Alignment','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;
subplot(2,3,3), subimage(deltaImage);
text(0.5,0.5,'Difference','HorizontalAlignment','left','VerticalAlignment', 'bottom','fontsize',16); axis off;
subplot(2,3,4), subimage(deltaR);
subplot(2,3,5), subimage(deltaG);
subplot(2,3,6), subimage(deltaB);

%imshow(deltaImage);
%ColorImg_aligned == ColorImg_aligned_old;