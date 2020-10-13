
% function OutImg = NAMF(nImg)
% a
% clc; clear;
% Img = imread('lena_gray_256.tif'); % Reading input image
% % d= 0.2;   % Noise density
% % nImg= imnoise(Img,'salt & pepper',d);   % Introducing noise
%  nImg = imread('0.9lina_256.tif');



pad = 2;
mfw = 3;

[row col] = size(nImg); % Size calculation
imgZP = zeros(row + 2 * pad, col + 2 * pad); % Zero padding
OutImg1 = imgZP;
k = 0; p = 0; % variable
pix = zeros(mfw * mfw, 1); % Pixels without noise
pixN = zeros(mfw * mfw, 1); % Noisy pixel

imgZP(pad + 1:row + pad, pad + 1:col + pad) = nImg; % Zero padded image

rng = (mfw - 1) / 2;
flg = zeros(row, col);
t1=80;%threshold 1
t2=2; % threshold 2
%%Creating a record book
a=0
record_book=[];
for i = pad + 1: row + pad
    for j = pad + 1: col + pad
       tmp=imgZP(i-rng:i+rng,j-rng:j+rng);
       value=median(reshape(tmp(),1,[]));
       if (abs(imgZP(i,j)-value)   >= t1)
           record_book=[record_book,imgZP(i,j)];
       end
    end  
end

a=1


xx = unique(record_book);
x=sort(record_book);
t = zeros(size(xx)); % vector for freqs
for i = 1:length(xx)  % frequency for each value
        t(i) = sum(x == xx(i));
end
fmax=max(t);
ft=.45*fmax;


a=2

Sn=[];
for i = pad + 1: row + pad
    for j = pad + 1: col + pad
        frequency=0;
        for a=1:length(record_book)
            if imgZP(i,j)==record_book(i)
                frequency=frequency+1;
            end
        end
        if frequency  >= ft
           Sn=[Sn,imgZP(i,j)];
        end
    end
end

a=3


%code for detection of noisy pixel
for i = pad + 1: row + pad
    for j = pad + 1: col + pad
        frequency=0;
        for a=1:length(record_book)
            if imgZP(i,j)==Sn(i)
                frequency=frequency+1;
            end
        end
        if frequency>=1
            flg(i-pad,j-pad)=1;
        else
            flg(i-pad,j-pad)=0;
        end
        
        
        if (imgZP(i,j)~=0||imgZP(i,j)~=255)   
            if flg(i-pad,j-pad)==1
               dave1=(imgZP(i-1,j-1)+imgZP(i,j)+imgZP(i+1,j+1))./3;
               dave2=(imgZP(i-1,j+1)+imgZP(i,j)+imgZP(i+1,j-1))./3;
               val1=abs(imgZP(i,j)-dave1);
               val2=abs(imgZP(i,j)-dave2);
               if min(val1,val2)<=t2
                  flg(i-pad,j-pad)=0;
               end
            end
        end
        
        if (imgZP(i,j)==0||imgZP(i,j)==255)
            flg(i-pad,j-pad)=1;
        end
        
        
    end
end




a=4


%OutImg=[];     %code for filtering the noisy pixels
for i = pad + 1: row + pad
    for j = pad + 1: col + pad
    if (flg(i-pad,j-pad)==0)
        pixel = imgZP(i,j);
    else
        tmp=imgZP(i-rng:i+rng,j-rng:j+rng);
        tmp(tmp==0)=[];tmp(tmp==255)=[];
        if length(tmp)>4
            pixel=median(reshape(tmp(),1,[]));
        else
            tmp=imgZP(i-2*rng:i+2*rng,j-2*rng:j+2*rng);
            tmp(tmp==0)=[];tmp(tmp==255)=[];
            pixel=median(reshape(tmp(),1,[]));
        end
    end
    OutImg(i-pad,j-pad)=uint8(pixel);
    end
    
end





error = Img - OutImg;
figure(1); imshow(Img);
figure(2); imshow(nImg);
figure(3); imshow(OutImg);

mse = sum(sum((Img - OutImg) .^ 2)) / (row * col);
PSNRformula = 10 * log10(255 ^ 2 / mse)
PSNR = psnr(Img, OutImg, 255)
SSIM = ssim(Img, OutImg)
% 
%   end