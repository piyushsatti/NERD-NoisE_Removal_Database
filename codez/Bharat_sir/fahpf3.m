% 2016 AEJ 
% An extremely fast adaptive high-performance filter to remove salt and pepper noise using overlapping medians in images

function OutImg = fahpf3(nImg)

% clc;clear;
% Img= imread('lena_gray_512.tif');   % Reading input image
% d= 0.92;   % Noise density
% nImg= uint8(imnoise(Img,'salt & pepper',d));   % Introducing noise

[row col]= size(nImg);       % Size calculation

% Stage 1: Initial stage filtering via TMF with 3x3 and 5x5 window based on noise density
F1= nImg;     % Compute F1 with m1
m1= F1; m1(m1==0|m1==255)=0; m1(m1>0&m1<255)=1; 
F3= mf_wnf(nImg,3);      % Compute F3 with m3
m3= F3; m3(m3==0|m3==255)=0; m3(m3>0&m3<255)=1;
F5= mf_wnf(nImg,5);      % Compute F5 with m5
m5= F5; m5(m5==0|m5==255)=0; m5(m5>0&m5<255)=1;
m1bar= 1-m1; m3bar= 1-m3;
OM= F1.*m1 + F3.*uint8(m1bar & m3) + F5.*uint8(m1bar & m3bar & m5);
S1= uint8(OM);

% Stage 2: Unbiased Trimmed Median filter with 5x5 window
S2= uint8(mf_wnf(S1,7));

S3= S2;
% Running average of noise-free pixel in 3x3 window for noisy pixel only
for i= 3 : row-2
    for j= 3 : col-2
        if(S2(i,j)==0)||(S2(i,j)==255)
            tmp=S2(i-2:i+2,j-2:j+2);
            tmp(tmp == 0) = []; tmp(tmp == 255) = [];
            tmp1 = reshape(tmp, 1, []);
            S3(i,j)= mean(tmp1);
        end
    end
end

S4= S3; % Initialization of S4
% Averaging for noisy pixel
for i= 1 : row
    for j= 1 : col-1
        if((i==1)&&(j==1))
            if((S3(i,j)==0)||(S3(i,j)==255))
               tmp=S3(1:5,1:5);
               tmp(tmp == 0) = []; tmp(tmp == 255) = [];
               tmp1 = reshape(tmp, 1, []);
               if(length(tmp1)==0)
                    S4(i,j)= mean(tmp1);
               else
                    break;
               end
            end
        elseif(((i==1)&&(j~=1)))
            if((S3(i,j)==0)||(S3(i,j)==255))
               S4(i,j)= S3(i,j-1);
            end
        elseif(((i~=1)&&(j==1)))
            if((S3(i,j)==0)||(S3(i,j)==255))
               S4(i,j)= S3(i-1,j);
            end
        elseif(S3(i,j)==0)||(S3(i,j)==255)
            tmp= [S3(i-1,j-1), S3(i-1,j), S3(i-1,j+1), S3(i,j-1)];
            tmp(tmp == 0) = []; tmp(tmp == 255) = [];
            tmp1 = reshape(tmp, 1, []);
            if(length(tmp1)==0)
               S4(i,j)= mean(tmp1);
            else
               break;
            end
        end
    end
end


% subplot(2,3,1); imshow(Img);
% subplot(2,3,2); imshow(nImg);
% subplot(2,3,3); imshow(S1);
% subplot(2,3,4); imshow(S2);
% subplot(2,3,5); imshow(S3);
% subplot(2,3,6); imshow(S4);
% PSNR1= psnr(Img, S1);PSNR2= psnr(Img, S2);PSNR3= psnr(Img, S3);PSNR4= psnr(Img, S4);
% SSIM1= ssim(Img, S1);SSIM2= ssim(Img, S2);SSIM3= ssim(Img, S3);SSIM4= ssim(Img, S4);

OutImg= S4;

end