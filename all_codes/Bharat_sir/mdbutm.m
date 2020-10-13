% 2011 SPL 
% Removal of High Density Salt and Pepper Noise Through Modified Decision Based Unsymmetric Trimmed Median Filter

function OutImg = mdbutm(nImg)

% clc;clear;
% Img= imread('lena_gray_256.tif');
% d= 0.9;
% nImg= imnoise(Img, 'salt & pepper', d);

[row col]= size(nImg);          % Size calculation
imgZP= zeros(row+2,col+2);      % Zero padding

pix= zeros(9,1);                % Pixels without noise
pixN= zeros(9,1);               % Noisy pixel

imgZP(2:row+1,2:col+1)= nImg;

mfw=3; k=0; p=0;% variable 
 
for i= 2: row+1
    for j= 2: col+1
        tmp= imgZP(i-1:i+1,j-1:j+1);
        nfp=tmp((tmp~=0)&(tmp~=255));
        if(length(nfp)==0)
            OutImg(i-1,j-1)= uint8(sum(sum(tmp))/9);
        else
            OutImg(i-1,j-1)= uint8(median(nfp));
        end
    end
end

% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% 
% mse= sum(sum((Img-OutImg).^2))/(row*col);
% PSNR= 10*log(255^2/mse);
% SSIM= ssim(Img, OutImg);

end
