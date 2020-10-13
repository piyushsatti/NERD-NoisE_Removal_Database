% Dynamic Adaptive Median Filter (DAMF) for Removal of High Density Impulse Noise

clear all; close all; clc;

Img = imread("lena_gray_512.tif");
nImg = imnoise(Img,"salt & pepper", 0.7);
% nImg = imread('.7lena512.tif'); % Reading input image

oImg = test(nImg);
psnr(oImg,Img)

function OutImg = test(nImg)

[row, col] = size(nImg);
pad = 7;
imgZP = padarray(nImg, [pad, pad]);

window_size_max = 15;

for i = 1+pad:row+pad
    for j = 1+pad:col+pad
        if (imgZP(i,j)==0)||(imgZP(i,j)==255)
            window_size = 3;
            while window_size <= window_size_max
                % window size variation as mentioned in the paper
                rng = (window_size-1)/2;
                temp = imgZP(i-rng:i+rng,j-rng:j+rng);
                temp(temp==255) = []; temp(temp==0) = [];
                if length(temp)>=3
                    OutImg(i-pad,j-pad) = median(temp,'all');
                    break;
                else
                    window_size = window_size + 2;
                    if window_size>window_size_max
                        OutImg(i-pad,j-pad) = mean(temp,'all');
                    end
                end
            end
        else
            OutImg(i-pad,j-pad) = imgZP(i,j);
        end
    end
end

end