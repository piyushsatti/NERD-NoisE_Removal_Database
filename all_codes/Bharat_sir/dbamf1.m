% 2007 SPL 
% A New Fast and Efficient Decision-Based Algorithm for Removal of High-Density Impulse Noises
% Improved dbamf by identifying number of noisy pixel and then changing
% which diagonal to be considered for finding median value.
% function OutImg = dbamf(nImg)

clc;clear;
Img= imread('lena_gray_256.tif');   % Reading input image
d= 0.5;   % Noise density
for d= 1:9 
nImg= imnoise(Img,'salt & pepper',0.1*d);   % Introducing noise

pad= 2; mfw=3; 
[row col]= size(nImg);              % Size calculation
imgZP= zeros(row+2*pad,col+2*pad);  % Zero padding

imgZP(pad+1:row+pad,pad+1:col+pad)= nImg; %Zero padded image

rng=(mfw-1)/2;
flg= zeros(row,col);
x= [1 2 3 4 5 6 7 8 9];
for i= pad+1: row+pad
    for j= pad+1: col+pad
        if((imgZP(i,j)==0)||(imgZP(i,j)==255))
            flg(i-pad, j-pad)= 1;
        else
            flg(i-pad, j-pad)= 0;
        end      
    end
end

pp=128;
tmp1= zeros(1,3);
for i= 1+pad: row+pad
    for j= 1+pad: col+pad
        if((imgZP(i,j)==0)||(imgZP(i,j)==255))
            tmp= sort(sort(imgZP(i-rng:i+rng,j-rng:j+rng))');
            CountMin=0;CountMax=0;      % Variable to count Min and Max
            CountMin=sum(reshape(tmp,1,[]) == 0);
            CountMax=sum(reshape(tmp,1,[]) == 255);
            if(CountMin+CountMin<7)
                if(CountMin<=3)&&(CountMax<=3)
                    pixel= median([tmp(1,1),tmp(2,2),tmp(3,3)]);
                else
                    if(CountMin<=1)&&(CountMax<=6)
                        pixel= median([tmp(1,2),tmp(2,1)]);
                    else
                        if(CountMin<=6)&&(CountMax<=1)
                            pixel= median([tmp(2,3),tmp(3,2)]);
                        end
                    end
                end
            else
                tmp= sort(sort(imgZP(i-2*rng:i+2*rng,j-2*rng:j+2*rng))');
                CountMin=0;CountMax=0;      % Variable to count Min and Max
                CountMin=sum(reshape(tmp,1,[]) == 0);
                CountMax=sum(reshape(tmp,1,[]) == 255);
                if(CountMin+CountMin<23)
                    if(CountMin<=10)&&(CountMax<=10)
                        pixel= median([tmp(1,1),tmp(2,2),tmp(3,3),tmp(4,4),tmp(5,5)]);
                    else
                        if(CountMin<=6)&&(CountMax<=15)
                            pixel= median([tmp(4,1),tmp(3,2),tmp(2,3),tmp(1,4)]);
                        else
                            if(CountMin<=3)&&(CountMax<=19)
                                pixel= median([tmp(3,1),tmp(2,2),tmp(1,3)]);
                            else
                                if(CountMin<=1)&&(CountMax<=22)
                                    pixel= median([tmp(2,1),tmp(1,2)]);
                                else
                                    if(CountMin<=15)&&(CountMax<=6)
                                        pixel= median([tmp(5,2),tmp(4,3),tmp(3,4),tmp(2,5)]);
                                    else
                                        if(CountMin<=19)&&(CountMax<=3)
                                            pixel= median([tmp(5,3),tmp(4,4),tmp(3,5)]);
                                        else
                                            if(CountMin<=22)&&(CountMax<=1)
                                                pixel= median([tmp(5,4),tmp(4,5)]);
                                            else
                                             pixel= pp;  
                                            end
                                        end
                                    end
                                end
                            end
                        end                            
                    end
                else
                   pixel= pp;
                end
            end
        else
            pixel= imgZP(i,j);
        end
        OutImg(i-pad,j-pad)= uint8(pixel);
        pp= uint8(pixel);
    end
end

error= Img-OutImg;
% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg); 
% mse= sum(sum((Img-OutImg).^2))/(row*col);
% PSNR= 10*log(255^2/mse);
PSNR= psnr(Img, OutImg);
SSIM= ssim(Img, OutImg);
tmp3(d)= PSNR;
tmp2(d)= SSIM;

end

plot(x,tmp3,':b*');
legend('dbamf', 'Location', 'NorthEast');
title('PSNR Values');
xlabel('Noise Density','FontSize',15,'FontName','Times New Roman');
ylabel('PSNR (db)','FontSize',15,'FontName','Times New Roman');
