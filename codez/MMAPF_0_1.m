clear all; clc; close all;

Img = imread('lena_gray_512.tif'); % Reading input image
Img = Img(:,:,1);
nImg = imnoise(Img,'salt & pepper',0.7);
% nImg = imread('.7lena512.tif');

% Img = imread('lena_gray_512.tif'); % Reading input image
% % nImg = imnoise(Img,'salt & pepper',0.7);
% nImg = imread('.7lena512.tif');

oimg = mmapf_01(nImg);
% error = oimg - Img;
% 
% error(error>8) = 0;
% error(error<4) = 0;
% 
% peak_val = double(max(error, [], 'all'));
% error = uint8(error.*(255/peak_val));
% imshow(error)

% I need to reduce the boundary size 

% subplot(1,2,1)
% imshow(edge(Img,'Canny'));
% subplot(1,2,2)
% imshow(edge(oimg,'Canny'));

psnr(oimg, Img)

function OutImg = mmapf_01(nImg)

% Min-Max Average Pooling Filter for Impulse Noise Removal
% Takes nImg <Noisy Image> as input

% calculation of size of Image
[row, col] = size(nImg);

% b_f flags the noisy elements
for i=1:row
    for j=1:col
        if (nImg(i,j) == 0) || (nImg(i,j) == 255)
            b_f(i,j) = 0;
        else
            b_f(i,j) = 1;
        end
    end
end

I_1 = double(nImg);
I_2 = double(nImg);

% Second stage
[I_1, I_2] = CCMP(I_1, I_2, 'Max'); 
[I_1, I_2] = CCMP(I_1, I_2, 'Min'); 
[I_1, I_2] = CCMP(I_1, I_2, 'Min'); 
[I_1, I_2] = CCMP(I_1, I_2, 'Max');

% Final Step for Output Image
OutImg = RnS(I_1, I_2, b_f);

end

function [O_1, O_2] = CCMP(I_1, I_2, str)

[row,col] = size(I_1);

pad = 2;

I_1 = padarray(I_1, [pad pad]);
I_2 = padarray(I_2, [pad pad]);

for i = 1 : row + 2*pad
    for j = 1 : col + 2*pad
        if I_1(i,j)==0||I_1(i,j)==255
            b_g(i,j) = 0;
        else
            b_g(i,j) = 1;
        end
    end
end

for i = 1 + pad : row + pad
    for j = 1 + pad : col + pad
        if b_g(i,j) == 0
            temp_cross = nonzeros([reshape(I_1(i-1:i+1,j).*b_g(i-1:i+1,j), [1, 3]), I_1(i,j-1).*b_g(i,j-1), I_1(i,j+1).*b_g(i,j+1)]);
            temp = nonzeros(I_1(i-1:i+1,j-1:j+1).*b_g(i-1:i+1,j-1:j+1));
            if ~isempty(temp_cross)
                if str == 'Max'
                    I_1(i,j) = max(temp_cross);
                    I_2(i,j) = min(temp_cross);
                elseif str == 'Min'
                    I_1(i,j) = min(temp_cross);
                    I_2(i,j) = max(temp_cross);
                end
            elseif ~isempty(temp)
                if str == 'Max'
                    I_1(i,j) = max(temp);
                    I_2(i,j) = min(temp);
                elseif str == 'Min'
                    I_1(i,j) = min(temp);
                    I_2(i,j) = max(temp);
                end
            end
        end
    end
end

O_1 = I_1(1+pad:row+pad,1+pad:col+pad);
O_2 = I_2(1+pad:row+pad,1+pad:col+pad);

end

function out = RnS(I_1, I_2, b_f)
    
    [row, col] = size(b_f);
    
    rng = 1;
    k = [
        0 1 0;
        1 1 1;
        0 1 0
        ];
    k = k./sum(k,'all');
    
    for i = 1 + rng : row - rng
        for j = 1 + rng : col - rng
            if b_f(i,j)==0
                I_1(i,j) = ceil(sum(I_1(i-rng:i+rng,j-rng:j+rng).*k, 'all'));
                I_2(i,j) = ceil(sum(I_2(i-rng:i+rng,j-rng:j+rng).*k, 'all'));
            end
        end
    end
    oImg = uint8(I_1.* 0.55 + I_2.* 0.45);
    out = oImg;
end