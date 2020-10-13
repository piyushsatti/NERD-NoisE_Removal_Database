% clc;clear;close;
% Img= imread('lena_gray.jpg');   % Reading input image
% d= 0.8;   % Noise density
% nImg= imnoise(Img,'salt & pepper',d);% Introducing noise
% DnImg = aswmf(nImg);
% %imshow(DnImg);
% error = Img - DnImg;
% figure(1); imshow(Img);
% figure(2); imsh ow(nImg);
% figure(3); imshow(DnImg);
% [row , col] = size(DnImg);
% mse = sum(sum((Img - DnImg) .^ 2)) / (row * col);
% PSNRformula = 10 * log10(255 ^ 2 / mse)
% PSNR = psnr(Img, DnImg, 255)
% SSIM = ssim(Img, DnImg)
% psnr(Img , DnImg)
function OutImg= aswmf(nImg)
    % Input Image Size calculation
    [row, col] = size(nImg);
    OutImg = nImg;
    
    pad = 4;
    mfw = 3;
    pixel=0;
    
    % Padding the Image
    imgZP = padarray(nImg,[pad pad]);
    rng = (mfw - 1) / 2;
    flg = zeros(row, col); % flag matrix to store if a pixel is corrupted or not
    
    for i = pad + 1: row + pad
        for j = pad + 1: col + pad
            if (((imgZP(i, j) ~= 0) && (imgZP(i, j) ~= 255)) )
                flg(i - pad, j - pad) = 1;
            else
                flg(i - pad, j - pad) = 0;
            end
        end
    end
    
    
    for i = 1 + pad: row + pad
        for j = 1 + pad:col + pad
            if (flg(i - pad, j - pad) == 1)
                pixel = imgZP(i, j);
            else
                tmp1 = imgZP(i - rng:i + rng, j - rng:j + rng);
                tmp1(tmp1 == 0) = [];
                tmp1(tmp1 == 255) = [];
                
                
                if (~isempty(tmp1))
                    length(tmp1)  ;
                    tmp1 = reshape(imgZP(i - rng:i + rng, j - rng:j + rng), 1, []);
                    tmp1(5) = [];
                    tmp = [tmp1, tmp1];
                    tmp(tmp == 0) = [];
                    tmp(tmp == 255) = [];
                    if mod(length(tmp()), 2) == 1
                        pixel = median(reshape(tmp(), 1, []));
                        
                    else
                        tmp_unique = unique(tmp());
                        if (length(tmp()) ~= length(tmp_unique()))
                            a = mode(tmp());
                            tmp = [tmp, a];
                            pixel = median(reshape(tmp(), 1, []));
                        else
                            tmp1 = reshape(imgZP(i - rng:i + rng, j - rng:j + rng), 1, []);
                            tmp = [tmp1, tmp1];
                            tmp(tmp == 0) = [];
                            tmp(tmp == 255) = [];
                            pixel = median(reshape(tmp(), 1, []));
                        end
                    end
                else
                    tmp1 = imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng);
                    tmp1(tmp1 == 0) = [];
                    tmp1(tmp1 == 255) = [];
                    if (~isempty(tmp1()))
                        tmp1 = reshape(imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng), 1, []);
                        tmp_final = [tmp1 , tmp1];
                        tmp_final = reshape(tmp_final , 1 , []);
                        plus_win = [imgZP(i - 1, j), imgZP(i + 1, j), imgZP(i, j + 1), imgZP(i, j - 1)];%+
                        tmp_final = [tmp_final, plus_win ,plus_win];
                        tmp_final = reshape(tmp_final , 1 , []);
                        w_win = [imgZP(i - 2, j - 1), imgZP(i - 1, j - 1), imgZP(i + 1, j - 1), imgZP(i + 2, j - 1), imgZP(i - 2, j + 1), imgZP(i - 1, j + 1), imgZP(i + 1, j + 1), imgZP(i + 2, j + 1)];
                        tmp_final = [tmp_final, w_win];
                        tmp_final = reshape(tmp_final , 1 , []);
                        tmp_final(tmp_final == 0) = [];
                        tmp_final(tmp_final == 255) = [];
                        tmp = tmp_final;
                        if mod(length(tmp()), 2) == 1
                            pixel = median(reshape(tmp(), 1, []));
                        else
                            tmp_unique = unique(tmp());
                            if (length(tmp()) ~= length(tmp_unique()))
                                a = mode(tmp());
                                tmp = [tmp, a];
                                pixel = median(reshape(tmp(), 1, []));
                            else
                                tmp1 = reshape(imgZP(i - 2*rng:i + 2*rng, j - 2*rng:j + 2*rng), 1, []);
                                tmp1(5) = [];
                                tmp = [tmp1, tmp1];
                                tmp(tmp == 0) = [];
                                tmp(tmp == 255) = [];
                                pixel = median(reshape(tmp(), 1, []));
                            end
                        end
                        
                        
                    else
                        
                        tmp1 = imgZP(i - 3 * rng, j - 3 * rng:j +3 * rng);
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
                            
                            if pixel1==0
                                tmp1 = imgZP(i - 2 * rng:i + 2 * rng, j - 2 * rng:j + 2 * rng);
                                pixel1=mean(reshape(tmp1(),1,[]));
                            end
                            pixel=pixel1;
                            
                        end
                    end
                end
            end
            
            OutImg(i - pad, j - pad) = pixel;
        end
    end
end
