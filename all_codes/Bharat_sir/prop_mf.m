% function g = prop_mf(img, mfw)
clc;clear;

Img= imread('lena_gray_512.tif');
d= 0.5;
nImg= imnoise(Img, 'salt & pepper', d);

% img= [ 0    0   0   8   10
%        255  255 0   10  12
%        0    118 10  12  255
%        12   14  16  18  20
%        2    124 220 128 3];

[row col]= size(Img);
imgZP= zeros(row+2,col+2);
pix= zeros(9,1);
pix1=  zeros(9,1);

for i= 1: row
    for j= 1: col
        imgZP(i+1,j+1)= nImg(i,j);
    end
end

mfw=3;
k=0; % variable 
p=0; % variable 
for i= 1: row
    for j= 1: col
       for m= (1:mfw)
            for n= (1:mfw)
                if((imgZP(i+m-1,j+n-1)== 0)||(imgZP(i+m-1,j+n-1)== 255))
                    p=p+1;
                    pix1(p,1)= imgZP(i+m-1,j+n-1);
                else
                    k= k+1;
                    pix(k,1)= imgZP(i+m-1,j+n-1);
                end
            end            
        end
        if(p == 9)                          %check wether all pix are 0 or 255
            pixel= sum(sum(pix1))/9;        % if yes calculate mean
        else
            for l= 1:size(pix)-1
                for m= l:size(pix)-1
                    if( floor(pix(m)/16) > floor(pix(m+1)/16) )
                        tmp= pix(l);
                        pix(l)= pix(m+1);
                        pix(m+1)= tmp;
                    end
                end
            end
            pixel= median(pix);
%             if(k == 1)
%                 pixel= pix(1);
%             elseif(k == 2)
%                 pixel= (pix(1)+ pix(2))/2;
%             elseif(k == 3)
%                 pixel= pix(2);
%             elseif(k == 4)
%                 pixel= (pix(2)+ pix(3))/2;
%             elseif(k == 5)
%                 pixel= pix(3);
%             elseif(k == 6)
%                 pixel= (pix(3)+ pix(4));
%             elseif(k == 7)
%                 pixel= pix(4);
%             elseif(k == 8)
%                 pixel= (pix(4)+ pix(5))/2;  
%             elseif(k ==9)
%                 pixel= pix(4);
%             end
            p=0;
        end
        pix=0;
        pix1=0;
        k= 0;
        count_n= 0;
        OutImg(i,j)= uint8(pixel);   
    end
end

figure(1);
imshow(Img);
figure(2);
imshow(nImg);
figure(3);
imshow(OutImg);
mse= sum(sum((Img-OutImg).^2))/(row*col);
PSNR= 10*log(255^2/mse);
SSIM= ssim(Img, OutImg);
