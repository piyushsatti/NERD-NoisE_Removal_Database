% 2007 SPL 
% A New Fast and Efficient Decision-Based Algorithm for Removal of High-Density Impulse Noises

function OutImg = DMF(nImg)
% 
% clc;clear;

% Img= imread('lena_gray_512.tif');   % Reading input image
% d= 0.8;   % Noise density
% nImg= imnoise(Img,'salt & pepper',d);   % Introducing noise
% nImg=imread('0.9lina_256.tif');

pad= 2;
mfw=3; 
[row col]= size(nImg);       % Size calculation
imgZP= zeros(row+2*pad,col+2*pad);  % Zero padding

k=0; p=0;% variable
pix= zeros(mfw*mfw,1);    % Pixels without noise
pixN= zeros(mfw*mfw,1);   % Noisy pixel

imgZP(pad+1:row+pad,pad+1:col+pad)= nImg; %Zero padded image

rng=(mfw-1)/2;
flg= zeros(row,col);

% for i= pad+1: row+pad
%     for j= pad+1: col+pad
%         if((imgZP(i,j)==0)||(imgZP(i,j)==255))
%             flg(i-pad, j-pad)= 1;
%         else
%             flg(i-pad, j-pad)= 0;
%         end      
%     end
% end

Max=3; pp=128;
for i= 1+pad: row+pad
    for j= 1+pad: col+pad
        if((imgZP(i,j)==0)||(imgZP(i,j)==255))
            tmp= sort(sort(imgZP(i-rng:i+rng,j-rng:j+rng)));
            val1=tmp(1,2+rng);val2=tmp(1+rng,1+rng); val3=tmp(2+rng,1);
            if (val1>val2)
                rep=val1;val1=val2;val2=rep;
            end    
            if (val2>val3)
                rep=val2;val2=val3; val3=rep;
            end    
            if (val1>val3)
                rep=val1; val1=val3; val3=rep;
            end 
            tmp(1,2+rng)=val1;tmp(1+rng,1+rng)=val2;tmp(2+rng,1)=val3;         
            if (tmp(1,1)<imgZP(i,j)) && (imgZP(i,j)<tmp(3,3))  && (0<tmp(3,3)) &&(tmp(3,3) <255) 
                pixel=tmp(2,2);
            else
                pixel1=median(reshape(tmp(),1,[]));
                if  (pixel1>tmp(1,1)) && (pixel1>0) && (pixel1<tmp(3,3)) && (pixel1<255)
                    pixel=pixel1;
                else
                    pixel=pp;
                end
            end 
        else
            pixel= imgZP(i,j);
        end
        OutImg(i-pad,j-pad)= uint8(pixel);
        pp= uint8(pixel);
    end
end
 
% error= Img-OutImg;
% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg); 
% mse= sum(sum((Img-OutImg).^2))/(row*col);
% PSNR= 10*log10(255^2/mse)
% PSNRfunc=psnr(Img,OutImg)
% SSIM= ssim(Img, OutImg);

end