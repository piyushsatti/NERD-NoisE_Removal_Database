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


OutImg= S2;

end