% 2014 SIViP
% Decision-based neighborhood-referred unsymmetrical trimmed variants filter for the removal of high-density salt-and-pepper noise in images and videos

function OutImg = DBNUTV(nImg)

% clc; clear all;
% Img = imread('tm/lena_gray_512.tif'); % Reading input image
% d = 0.9; % Noise density
% nImg = imnoise(Img, 'salt & pepper', d); % Introducing noise
% % nImg= imread('nImg.tif');

pad = 3; mfw = 3;
[row,col] = size(nImg); % Size calculation
imgZP = zeros(row + 2 * pad, col + 2 * pad); % Zero padding
OutImg = nImg;
imgZP(pad + 1:row + pad, pad + 1:col + pad) = nImg; %Zero padded image
rng = (mfw - 1) / 2;
flg = zeros(row, col);

for i = 1 + pad: row + pad
    for j = 1 + pad:col + pad
        if ((imgZP(i,j) ~= 0) && (imgZP(i,j) ~= 255))
            pixel = imgZP(i, j);
        else
            tmp1 = imgZP(i - rng:i + rng, j - rng:j + rng);
            tmp = [tmp1(1,2), tmp1(2,1), tmp1(2,3), tmp1(3,2)]; % 4 nerest neighbors
            tmp2= tmp1;
            tmp(tmp == 0) = []; tmp(tmp == 255) = [];
            tmp2(tmp2 == 0) = []; tmp2(tmp2 == 255) = [];
            if (length(tmp) == 0) % all neighbour 4 pixs are noisy
               pixel= mean([tmp1(1,2), tmp1(2,1), tmp1(1,3), tmp1(3,2)]);
            elseif(length(tmp2) == 0)
                pixel= mean(tmp2);
            else
                pixel= median(tmp2);
            end
        end
        OutImg(i - pad, j - pad) = uint8(pixel);
    end
end


% error = Img - OutImg;
% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% SSIM = ssim(Img, OutImg); PSNR = psnr(Img, OutImg);

end
               