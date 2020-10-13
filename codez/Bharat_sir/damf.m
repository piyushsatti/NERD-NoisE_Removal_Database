% 2018 AEU 
% Different applied median filter in salt and pepper noise

function OutImg = damf(nImg)
% clc; clear;
% Img= imread('lena_gray_256.tif');   % Reading input image
% d=0.5;   % Noise density
% nImg= imnoise(Img,'salt & pepper',0.5);   % Introducing noise
% Img= [ 0    0   0   8   10
%        255  255 0   10  12
%        0    118 10  12  255
%        12   14  16  18  20
%        2    124 220 128 3];

[row col]= size(nImg);

imgZP= zeros(row+2,col+2);

pix= zeros(9,1);    % Pixel without noise
pixN= zeros(9,1);   % Noisy pixel

for i= 1: row+2
    for j= 1: col+2
        if((i==1)&&(j==1))
            imgZP(i,j)= nImg(i,j);
        elseif((i==1)&&(j==col+2))
            imgZP(i,j)= nImg(i,j-2);
        elseif((i==row+2)&&(j==1))
            imgZP(i,j)= nImg(i-2,j);
        elseif((i==row+2)&&(j==col+2))
            imgZP(i,j)= nImg(i-2,j-2);
        elseif(i==1)
            imgZP(i,j)= nImg(i,j-1);
        elseif(i==row+2)
            imgZP(i,j)= nImg(i-2,j-1);
        elseif(j==1)
            imgZP(i,j)= nImg(i-1,j);
        elseif(j==col+2)
            imgZP(i,j)= nImg(i-1,j-2);
        else
            imgZP(i,j)= nImg(i-1,j-1);
        end
    end
end

mfw=3;k=0; p=0; % variable 

for i= 1: row
    for j= 1: col
        for m= (1:mfw)
            for n= (1:mfw)
                if((imgZP(i+m-1,j+n-1)== 0)||(imgZP(i+m-1,j+n-1)== 255))
                    p=p+1;
                    pixN(p,1)= imgZP(i+m-1,j+n-1);
                else
                    k= k+1;
                    pix(k,1)= imgZP(i+m-1,j+n-1);
                end
            end    
        end
        if(p == 9)                          %check wether all pix are 0 or 255
            pixel= sum(sum(pixN))/9;        % If yes calculate mean of noisy pixels
        else
            pixel= median(pix);             % Else calculate median
        end
        pix= 0;
        pixN= 0;
        k= 0;
        p= 0;
        OutImg(i,j)= uint8(pixel);
    end
end

% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% mse= sum(sum((Img-OutImg).^2))/(row*col);
% PSNR= 10*log(255^2/mse);
% SSIM= ssim(Img, OutImg);

end