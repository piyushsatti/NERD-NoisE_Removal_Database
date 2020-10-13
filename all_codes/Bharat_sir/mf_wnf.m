
function OutImg = mf_wnf(nImg,mfw)

% clc; clear;
% Img= imread('lena_gray_256.tif');
% nd= 0.5;
% nImg= imnoise(Img, 'salt & pepper', nd);
% mfw=5;

rng= (mfw-1)/2;
pad=rng;
[row col]= size(nImg);

imgZP= zeros(row+2*rng,col+2*rng);
imgZP(1+pad:row+pad,1+pad:col+pad)= nImg;
      
for i= 1+pad: row+pad
    for j= 1+pad: col+pad
        if(imgZP(i,j)~=0)&&(imgZP(i,j)~=255)
            pixel= imgZP(i,j);
        else
            wind=  imgZP(i-rng:i+rng,j-rng:j+rng);
            tmp=wind;
            tmp(tmp==0)=[]; tmp(tmp==255)=[];
            if(size(tmp,1)>0)
                pixel= median(reshape(tmp,1,[]));
            else
                pixel= median(reshape(wind(),1,[]));     %else calculate median
            end
        end
        OutImg(i-pad,j-pad)= uint8(pixel);
    end
end

% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% PSNR= 10*log(255^2/(sum(sum((Img-OutImg).^2))/(row*col)));
% SSIM= ssim(Img, OutImg);

end

