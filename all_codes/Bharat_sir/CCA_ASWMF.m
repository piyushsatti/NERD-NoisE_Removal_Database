% 2016 AEU 
% Adaptive switching weighted median filter framework for suppressing salt-and-pepper noise

 function [CC_total,NP]= CCA_ASWMF(nImg)
% clc; clear;
count1 = 0;
count = 0;
count2 = 0; count3 = 0;
%  Img = imread('lena_gray_256.tif'); % Reading input image
%  
% Img=imread('Lena_gray_512.tif');
% 
% d = 0.9; % Noise density
% nImg = imnoise(Img, 'salt & pepper', d); % Introducing noise

pad = 4;
mfw = 3;
count = 0;


[row col] = size(nImg); % Size calculation
imgZP = zeros(row + 2 * pad, col + 2 * pad); % Zero padding
OutImg = nImg;
k = 0; p = 0; % variable
pix = zeros(mfw * mfw, 1); % Pixels without noise
pixN = zeros(mfw * mfw, 1); % Noisy pixel

imgZP(pad + 1:row + pad, pad + 1:col + pad) = nImg; % Zero padded image

rng = (mfw - 1) / 2;
flg = zeros(row, col);

% Code for flag register generation
NP=0;
for i = pad + 1: row + pad
    for j = pad + 1: col + pad
        tmp1 = imgZP(i - rng:i + rng, j - rng:j + rng);
        tmp = mean(reshape(tmp1(), 1, []));
        if (((imgZP(i, j) ~= 0) && (imgZP(i, j) ~= 255)) )
            flg(i - pad, j - pad) = 1;
        else
            flg(i - pad, j - pad) = 0;
            NP=NP+1;
        end
    end
end
CC=0;CC_total=0;
for i = 1 + pad: row + pad
    for j = 1 + pad:col + pad
        if (flg(i - pad, j - pad) == 1)
            pixel = imgZP(i, j);
            CC=0;
        else
            tmp1 = imgZP(i - rng:i + rng, j - rng:j + rng);
            tmp1(tmp1 == 0) = [];tmp1(tmp1 == 255) = [];
            if (length(tmp1) ~= 0)
                tmp1 = reshape(imgZP(i - rng:i + rng, j - rng:j + rng), 1, []);
                tmp1(5) = [];
                tmp = [tmp1, tmp1];
                tmp(tmp == 0) = []; tmp(tmp == 255) = [];
                if mod(length(tmp()), 2) == 1
                    pixel = median(reshape(tmp(), 1, []));
                    pp=pixel;
                    CC= length(tmp);
                else
                    C = unique(tmp());
                    if (length(tmp()) ~= length(C()))
                        a = mode(tmp());
                        tmp = [tmp, a];
                        pixel = median(reshape(tmp(), 1, []));
                        pp=pixel;
                        CC= length(tmp);
                    else % Here should be the insertion of nearest non-noisy pixel 
                        tmp1 = reshape(imgZP(i - rng:i + rng, j - rng:j + rng), 1, []);
                        tmp1(5) = [];
                        tmp = [tmp1, tmp1];
                        tmp(tmp == 0) = []; tmp(tmp == 255) = [];
                        pixel = median(reshape(tmp(), 1, []));
                        pp=pixel; 
                        CC= length(tmp);
                    end
                end
            else
                tmp1 = imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng);
                tmp1(tmp1 == 0) = []; tmp1(tmp1 == 255) = [];
                if (length(tmp1()) ~= 0)
                    count=count+1;
                    tmp1 = reshape(imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng), 1, []);
                    b = [imgZP(i - 1, j), imgZP(i + 1, j), imgZP(i, j + 1), imgZP(i, j - 1)];
                    tmp1 = [tmp1, b, b, b, b];
                    c = [imgZP(i - 2, j), imgZP(i, j - 2), imgZP(i, j + 2), imgZP(i + 2, j)];
                    tmp1 = [tmp1, c, c, c];
                    d = [imgZP(i - 2, j - 1), imgZP(i - 1, j - 1), imgZP(i + 1, j - 1), imgZP(i + 2, j - 1), imgZP(i - 2, j + 1), imgZP(i - 1, j + 1), imgZP(i + 1, j + 1), imgZP(i + 2, j + 1)];
                    tmp1 = [tmp1, d, d];  
                    tmp1(tmp1 == 0) = []; tmp1(tmp1 == 255) = [];
                    tmp = tmp1;
                    if mod(length(tmp()), 2) == 1
                        pixel = median(reshape(tmp(), 1, []));
                        pp=pixel;
                        CC= length(tmp);
                    else
                        C = unique(tmp());
                        if (length(tmp()) ~= length(C()))
                            a = mode(tmp());
                            tmp = [tmp, a];
                            pixel = median(reshape(tmp(), 1, []));
                            pp=pixel;
                            CC= length(tmp);
                        else % Here should be the insertion of nearest non-noisy pixel 
                            tmp1 = reshape(imgZP(i - 2*rng:i + 2*rng, j - 2*rng:j + 2*rng), 1, []);
                            tmp1(5) = [];
                            tmp = [tmp1, tmp1];
                            tmp(tmp == 0) = []; tmp(tmp == 255) = [];
                            pixel = median(reshape(tmp(), 1, []));
                            pp=pixel;
                            CC= length(tmp);
                        end
                    end
                else   % what this else part representing
                    count1 = count1 + 1;
                    tmp1 = imgZP(i - 3 * rng, j - 3 * rng:j + 3 * rng);
                    tmp2 = imgZP(i - 3 * rng:i + 3 * rng, j - 3 * rng);
                    tmp3 = imgZP(i + 3 * rng, j - 3 * rng:j + 3 * rng);
                    tmp4 = imgZP(i - 3 * rng:i + 3 * rng, j + 3 * rng);
                    pixel1 = 0;
                    if pixel1 == 0
                        for value = 1:length(tmp1())
                            if (tmp1(value) ~= 0 && tmp1(value) ~= 255)
                                pixel1 = tmp1(value);
                            end
                        end
                    end
                    if pixel1 == 0
                        for value = 1:length(tmp2())
                            if (tmp2(value) ~= 0 && tmp2(value) ~= 255)
                                pixel1 = tmp2(value);
                            end
                        end
                    end
                    if pixel1 == 0
                        for value = 1:length(tmp3())
                            if (tmp3(value) ~= 0 && tmp3(value) ~= 255)
                                pixel1 = tmp3(value);
                            end
                        end
                    end
                    if pixel1 == 0
                        for value = 1:length(tmp4())
                            if (tmp4(value) ~= 0 && tmp4(value) ~= 255)
                                pixel1 = tmp4(value);
                            end
                        end 
                    end
                    new=[];
                    if pixel1==0
                       count2=count2+1;
                       tmp1 = imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng);
                       pixel1=mean(reshape(tmp1(),1,[]));
                       CC= length(tmp1);
                    end
                    pixel=pixel1;
                end
            end
        end
        OutImg(i - pad, j - pad) = pixel;
        pp=pixel;
        CC_total=CC_total+CC;
    end
end

% error = Img - OutImg;
% figure(1); imshow(Img);
% figure(2); imshow(nImg);
% figure(3); imshow(OutImg);
% 
% mse = sum(sum((Img - OutImg) .^ 2)) / (row * col);
% PSNRformula = 10 * log10(255 ^ 2 / mse)
% PSNR = psnr(Img, OutImg, 255)
% SSIM = ssim(Img, OutImg);
% count;

end