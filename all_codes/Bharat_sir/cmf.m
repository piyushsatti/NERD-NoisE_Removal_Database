% Convetional median filter

function OutImg = cmf(nImg)

% clc;clear;
% Img= imread('lena_gray_256.tif');
% nd= 0.5;
% mfw= 3;
% nImg= imnoise(Img, 'salt & pepper', nd);
% [row col]= size(nImg);

OutImg= medfilt2(nImg);

% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% 
% mse= (sum(sum((Img-OutImg).^2))/(row*col));
% PSNR= 10*log(255^2/mse);
% SSIM= ssim(Img, OutImg);

end
