% 2015 AEU  
% Removal of high-density impulse noise based on switching morphology-mean filter


clc
clear all
close all

% img=[
% 0 255 255 255 144 145 255 255 0;
% 0 255 0 0 255  0 255 0 144;
% 255 0 0 0 255 255 0 255 255;
% 255 0 255 255 0 0 255 0 255;
% 142 255 0 0 0 0 255 255 142;
% 0 255 255 0 255 0 0 0 0;
% 255 0 255 0 255 0 0 255 142;
% 255 0 255 0 255 255 142 0 0;
% 0 255 140 255 0 0 255 0 255
% ];

img = imread('benchmarkimages/lena_gray_512.tif');
nimg = imnoise(img,'salt & pepper',0.70);
pad = 1;
imzp = padarray(nimg,[pad pad],'symmetric');
mfw =3;
rng = (mfw - 1) / 2;
[row,col] = size(nimg);
row=row+2;
col=col+2;
imzp = double(imzp);

for i=1:row
    for j=1:col
        if imzp(i,j)==0||imzp(i,j)==255
            b_f(i,j) = 0;
        else
            b_f(i,j) = 1;
        end
    end
end

for i=2:row-1
    for j=2:col-1
        if b_f(i,j) == 0
            temp = min(nonzeros(imzp(i-1:i+1,j-1:j+1).*b_f(i-1:i+1,j-1:j+1)));
            if ~isempty(temp)
                imzp(i,j) = temp;
            end
        end
    end
end

for i=1:row
    for j=1:col
        if imzp(i,j)==0||imzp(i,j)==255
            b_g1(i,j) = 0;
        else
            b_g1(i,j) = 1;
        end
    end
end

for i=2:row-1
    for j=2:col-1
        if b_g1(i,j) == 0
            temp = max(nonzeros(imzp(i-1:i+1,j-1:j+1).*b_g1(i-1:i+1,j-1:j+1)));
            if ~isempty(temp)
                imzp(i,j) = temp;
            end
        end
    end
end

for i=1:row
    for j=1:col
        if imzp(i,j)==0||imzp(i,j)==255
            b_g2(i,j) = 0;
        else
            b_g2(i,j) = 1;
        end
    end
end

for i=2:row-1
    for j=2:col-1
        if b_g2(i,j) == 0
            temp = max(nonzeros(imzp(i-1:i+1,j-1:j+1).*b_g2(i-1:i+1,j-1:j+1)));
            if ~isempty(temp)
                imzp(i,j) = temp;
            end
        end
    end
end

for i=1:row
    for j=1:col
        if imzp(i,j)==0||imzp(i,j)==255
            b_g3(i,j) = 0;
        else
            b_g3(i,j) = 1;
        end
    end
end

for i=2:row-1
    for j=2:col-1
        if b_g3(i,j) == 0
            temp = min(nonzeros(imzp(i-1:i+1,j-1:j+1).*b_g3(i-1:i+1,j-1:j+1)));
            if ~isempty(temp)
                imzp(i,j) = temp;
            end
        end
    end
end

for i=1:1:row
    for j=1:col
        if imzp(i,j)==255
            imzp(i,j) = 0;
        end
    end
end

for i=2:row-1
    for j=2:col-1
        if b_f(i,j)==0
            imzp(i,j) = round(mean(nonzeros(imzp(i-1:i+1,j-1:j+1)),'all'));
        end
    end
end

OutImg = uint8(imzp(2:row-1,2:col-1));

psnr(img,OutImg)
ssim(img,OutImg)

imshow(OutImg)