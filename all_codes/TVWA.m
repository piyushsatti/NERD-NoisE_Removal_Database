% Removal of salt-and-pepper noise in corrupted image using
% three-values-weighted approach with variable-size window

clc; clear all; close all;

Img = imread("lena_gray_512.tif");
Img = Img(:,:,1);
% nImg = imnoise(Img,'salt & pepper',0.7);
nImg = imread(".7lena512.tif");

oimg = uint8(TVWA(nImg)) ;

psnr(oimg, Img)

function OutImg = TVWA(nImg)

[row, col] = size(nImg);
pad = 3;
imgZP = padarray(nImg, [pad, pad]);

window_size_max = 7;

for i = 1+pad:row+pad
    for j = 1+pad:col+pad
        if (imgZP(i,j)==0)||(imgZP(i,j)==255)
            window_size = 3;
            while window_size <= window_size_max
                % window size variation as mentioned in the paper
                rng = (window_size-1)/2;
                temp = imgZP(i-rng:i+rng,j-rng:j+rng);
                temp(temp==255) = []; temp(temp==0) = [];
                temp = reshape(temp, [1, length(temp)]);
                temp = double(temp);
                
                if ~isempty(temp)
                    pix_max = max(temp);
                    pix_min = min(temp);
                    dist_max = abs(temp - pix_max);
                    dist_min = abs(temp - pix_min);
                    count_max = 0;
                    count_min = 0;
                    for k = 1:length(temp)
                        if dist_max(k)<dist_min(k)
                            count_max = count_max + 1;
                        else
                            count_min = count_min + 1;
                        end
                    end
                    
                    pix_mid = pix_max*count_max/length(temp) + pix_min*count_min/length(temp);
                    dist_mid = abs(temp - pix_mid);
                    
                    count_max = 0;
                    count_min = 0;
                    count_mid = 0;
                    
                    for k = 1:length(temp)
                        if (dist_max(k)<dist_min(k)) || (dist_max(k)<dist_mid(k))
                            count_max = count_max + 1;
                        elseif (dist_min(k)<dist_max(k)) || (dist_min(k)<dist_mid(k))
                            count_min = count_min + 1;
                        else
                            count_mid = count_mid + 1;
                        end
                    end
                    
                    OutImg(i-pad,j-pad) = pix_mid*count_mid/length(temp) + pix_max*count_max/length(temp) + pix_min*count_min/length(temp);
                    break;
                    
                else
                    window_size = window_size + 2;
                end
            end
        else
            OutImg(i-pad,j-pad) = imgZP(i,j);
        end
    end
end

end