% 2014 
% Recursive cubic spline interpolation filter approach for the removal of high density salt-and-pepper noise

% clc;clear;close;
% Img= imread('lena_gray.jpg');   % Reading input image
% d= 0.5;   % Noise density
% nImg= imnoise(Img,'salt & pepper',.97);% Introducing noise
% DnImg = rsif(nImg);
% imshow(DnImg);
% psnr(Img , DnImg)
function OutImg = rsif(nImg)
    [row , col] = size(nImg);
    imgZP = zeros(row+4 , col+4);
    imgZP(3:row+2 , 3:col+2) = nImg;
    mfw = 3;
    OutImg = imgZP;
    rng = (mfw-1)/2;
    for i = 3 : row+2
        for j = 3 : col+2
            %pixel = imgZP(i,j);
            if(imgZP(i,j)==0||imgZP(i,j)==255)
                tmp = reshape(OutImg(i-rng : i+rng , j-rng :j+rng) , 1 ,[]);
                tmp(tmp==0) = [];tmp(tmp==255)=[];
                if(size(tmp,2)>1)
                   
                    y = 1:length(tmp);
                    OutImg(i,j)= spline(double(y),double(tmp),median(y,'all'));
                else
                    tmp = reshape(OutImg(i-rng : i+rng , j-rng :j+rng) , 1 ,[]);
                    OutImg(i,j) = mean(tmp);
                end
            end
            %OutImg(i,j) = uint8(pixel);
        end
    end
    OutImg = uint8(OutImg(3:row+2 , 3:col+2));
end
