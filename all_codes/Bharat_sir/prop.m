% window size increased in case of new one with mean =test7
% Proposed Algorimth (Prateek and Nikhil)

function OutImg = prop(nImg)
% clc;clear;
%
% Img= imread('lena_gray_256.tif');   % Reading input image
% d= 0.9;   % Noise density
% nImg= imnoise(Img,'salt & pepper',d);   % Introducing noise
% nImg=imread('0.2lina_256.tif');

pad = 2; mfw = 3;

[row col] = size(nImg); % Size calculation
imgZP = zeros(row + 2 * pad, col + 2 * pad); % Zero padding
OutImg1 = imgZP;
k = 0; p = 0; % variable
pix = zeros(mfw * mfw, 1); % Pixels without noise
pixN = zeros(mfw * mfw, 1); % Noisy pixel

imgZP(pad + 1:row + pad, pad + 1:col + pad) = nImg; %Zero padded image

rng = (mfw - 1) / 2;
flg = zeros(row, col);
count = 0;
for i = pad + 1: row + pad
    for j = pad + 1: col + pad
        if ((imgZP(i, j) == 0) || (imgZP(i, j) == 255))
            flg(i - pad, j - pad) = 1;
            count = count + 1;
        else
            flg(i - pad, j - pad) = 0;
        end
    end
end
noise_density = count ./ (row * col);

Max = 3; pp = 128;

for i = pad + 1: row + pad
    for j = pad + 1: col + pad
        if (flg(i - pad, j - pad) == 0)
            pixel = imgZP(i, j);
        else
            if (noise_density <= .25)
                tmp = imgZP(i - rng:i + rng, j - rng:j + rng);
                tmp(tmp == 0) = [];
                tmp(tmp == 255) = [];
                pixel = median(tmp);
            else
                tmp = imgZP(i - rng:i + rng, j - rng:j + rng);
                tmp(tmp == 0) = [];
                tmp(tmp == 255) = [];
                if length(tmp) >= 1
                    pixel = mean(reshape(tmp(), 1, []));
                else
                    tmp = imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng);
                    tmp(tmp == 0) = [];
                    tmp(tmp == 255) = [];
                    if length(tmp) >= 2
                        pixel = mean(reshape(tmp(), 1, []));
                    else
                        pixel = median(reshape(imgZP(i - rng:i + rng, j - rng:j + rng), 1, []));
                    end
                end
            end
            if ((pixel == 0) || (pixel == 255)) %write code to compute noisy pixel
                if (((i == 3) && (j == 3)) || ((i == 3) && (j == col + 2)) || ((i == row + 2) && (j == 3)) || ((i == row + 2) && (j == col + 2)))
                    tmp = imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng);
                    tmp(tmp == 0) = [];
                    tmp(tmp == 255) = [];
                    pixel = median(tmp);
                elseif ((i == 3) || (i == row + 2))
                    pixel = OutImg(i - 2, j - 3); % previous processed signal
                elseif ((j == 3) || (j == col + 2))
                    pixel = OutImg(i - 3, j - 2); % previous processed signal
                else
                    if (noise_density <= .85)
                        pixel = (double(OutImg(i - 2, j - 3)) + double(OutImg(i - 3, j - 2)) + double(OutImg(i - 3, j - 3)) + double(OutImg(i - 3, j - 1))) / 4;
                    else
                        arr = [OutImg1(i - 2, j - 2:j + 2) OutImg1(i - 1, j - 2:j + 2)];
                        arr = reshape(arr(), 1, []);
                        pixel = mean(reshape(arr(), 1, []));
                    end
                end
            end
        end
        OutImg1(i, j) = pixel;
        OutImg(i - pad, j - pad) = uint8(pixel);
    end
end

 
% error = Img - OutImg;
% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% 
% mse = sum(sum((Img - OutImg) .^ 2)) / (row * col);
% PSNRformula = 10 * log10(255 ^ 2 / mse)
% PSNR = psnr(Img, OutImg, 255)
% SSIM = ssim(Img, OutImg)

end
