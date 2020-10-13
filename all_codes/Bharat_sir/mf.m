
function OutImg = mf(nImg,mfw)

% clc; clear;
% Img= imread('lena_gray_256.tif');
% nd= 0.3;
% nImg= imnoise(Img, 'salt & pepper', nd);
mfw=5;

% Img=[61	62	64	65	66	66	68	65	64	73
% 57	60	64	67	70	71	65	66	72	82
% 61	62	63	64	65	66	63	72	84	91
% 73	70	67	65	63	61	70	80	91	96
% 81	80	79	78	77	77	84	87	91	95
% 82	86	90	94	97	99	96	91	88	91
% 80	86	93	99	103	105	109	108	106	103
% 86	89	92	95	97	98	107	107	107	107
% 93	93	93	93	93	94	101	102	103	105
% 98	98	98	98	98	98	95	96	97	98];
% nImg=[255	255	255	255	0	0	255	0	0	255
% 0	0	0	0	255	71	0	0	0	0
% 255	255	0	255	0	0	255	0	0	0
% 0	70	0	0	255	0	255	255	0	0
% 0	255	255	0	77	255	0	255	0	95
% 255	0	0	0	0	255	0	255	0	255
% 0	0	0	255	255	255	255	0	0	255
% 255	0	255	0	255	0	255	255	0	0
% 255	255	0	0	0	0	0	0	255	0
% 255	255	255	0	255	0	0	0	255	255];

rng= (mfw-1)/2;
pad=rng;
[row col]= size(nImg);

imgZP= zeros(row+2*rng,col+2*rng);
imgZP(1+pad:row+pad,1+pad:col+pad)= nImg;
% comp=0;
% Nop=0;
% tic     
for i= 1+pad: row+pad
    for j= 1+pad: col+pad
        if(imgZP(i,j)~=0)&&(imgZP(i,j)~=255)
            pixel= imgZP(i,j);
        else
            wind=  imgZP(i-rng:i+rng,j-rng:j+rng);
            pixel= median(reshape(wind(),1,[]));     %else calculate median
%             comp= comp+(2*rng+1);
        end
        OutImg(i-pad,j-pad)= uint8(pixel);
    end
end
% toc
% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% PSNR= 10*log(255^2/(sum(sum((Img-OutImg).^2))/(row*col)));
% SSIM= ssim(Img, OutImg);
% SSIM = ssim(uint8(Img), uint8(OutImg)); PSNR = psnr(uint8(Img), uint8(OutImg));
end

