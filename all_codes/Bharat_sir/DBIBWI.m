% 2017 EURASIP
% An adaptive decision based interpolation scheme for the removal of high density salt and pepper noise in images

% function OutImg = DBIBWI(nImg)

clc; clear all;
Img = imread('tm/lena_gray_512.tif'); % Reading input image
d = 0.98; % Noise density
nImg = imnoise(Img, 'salt & pepper', d); % Introducing noise
% nImg= imread('nImg.tif');

pad = 20; mfw = 3;
[row, col] = size(nImg); % Size calculation
imgZP = zeros(row+2*pad, col+2*pad); % Zero padding
OutImg = nImg;
imgZP(pad+1:row+pad, pad+1:col+pad) = nImg; %Zero padded image
rng = (mfw - 1) / 2;
flg = zeros(row, col);

for i = pad + 1: row + pad
    for j = pad + 1: col + pad
        if ((imgZP(i, j) == 0) || (imgZP(i, j) == 255))
            flg(i - pad, j - pad) = 1;
        else
            flg(i - pad, j - pad) = 0;
        end
    end
end

for i = 1 + pad: row + pad
    for j = 1 + pad:col + pad
        if (flg(i - pad, j - pad) == 0)
            pixel = imgZP(i, j);
        else
            flgReg=1; sum_di=0; sum_gi=0;
            while(flgReg)
                tmp1 = imgZP(i-rng:i+rng, j-rng:j+rng);
                tmp = tmp1;
                tmp(tmp == 0) = [];  tmp(tmp == 255) = [];
                if (length(tmp) >= 3)  % Do median filtering using DBIBWI
                for k= 1: 2*rng+1
                   for l= 1: 2*rng+1
                       if((tmp1(k,l)~=0)&&(tmp1(k,l)~=255))% Apply EGO/ant-colony to get optimum value of p 
                        di= 1/((k-rng-1)^2+(l-rng-1)^2)^2; % Inverse distance
                        gi= di* tmp1(k,l);                   % weight factor
                        sum_di= sum_di+di;                   % sum of IDs
                        sum_gi= sum_gi+gi;                   % sum of WF
                       end
                   end
                end
                pixel=  sum_gi/sum_di;                    % Estimated pix using IDIBWI
                flgReg=0;
                break;
                elseif(length(tmp) == 2)
                    rng= rng+1;
                    continue;
                elseif(length(tmp) == 1)
                    rng= rng+2;
                    continue;
                else
                    rng= rng+3;
                    continue;
                end
            end
        end
    OutImg(i - pad, j - pad) = uint8(pixel);    
    end
end

error = Img - OutImg;
subplot(1,3,1); imshow(Img);
subplot(1,3,2); imshow(nImg);
subplot(1,3,3); imshow(OutImg);
SSIM = ssim(Img, OutImg); PSNR = psnr(Img, OutImg);

% end