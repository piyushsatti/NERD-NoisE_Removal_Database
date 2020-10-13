% 2014 AEU 
% Fast switching based median–mean filter for high density saltand pepper noise removal SAP noise removal

function OutImg = fsbmmf5(nImg)

% clc;clear;
% Img= imread('lena_gray_256.tif');   % Reading input image
% d= 0.5;   % Noise density
% % nImg= imnoise(Img,'salt & pepper',d);   % Introducing noise
% nImg= imread('nImgx.tif');

[row col]= size(nImg);       % Size calculation
imgZP= zeros(row+4,col+4);  % Zero padding

imgZP(3:row+2,3:col+2)= nImg; %Zero padded image
imgZP1= zeros(row+4,col+4);

mfw=3; k=0; p=0;% variable 
rng=(mfw-1)/2;
flg= ones(row+4*rng,col+4*rng);

for i= 3: row+2
    for j= 3: col+2
        if((imgZP(i,j)==0)||(imgZP(i,j)==255))
            flg(i, j)= 1;
        else
            flg(i, j)= 0;
        end      
    end
end

Max=3;
thr=30;

for i= 3: row+2
    for j= 3: col+2
        if(flg(i,j)==0) % Stage 1, Check pixel is noisy or not
            pixel= imgZP(i,j);
            imgZP1(i,j)=1;
        else
            count= 9-sum(sum(flg(i-rng:i+rng,j-rng:j+rng)));
            if(count >=2)   % Check no. of non-noisy pixels in 3x3, if sufficient do MFing 
               tmp= imgZP(i-rng:i+rng,j-rng:j+rng);
               tmp(tmp==0)=[];
               tmp(tmp==255)=[];
               pixel= median(tmp);
               Max=Max+1;
              imgZP1(i,j)=2;
            else                                 % Check no. of non-noisy pixels in 5x5, if sufficient do MFing
                count= 25-sum(sum(flg(i-2*rng:i+2*rng,j-2*rng:j+2*rng)));
               if(count>=3)
                  tmp= imgZP(i-2*rng:i+2*rng,j-2*rng:j+2*rng);
                  tmp(tmp==0)=[];
                  tmp(tmp==255)=[];
                  pixel= median(tmp);
                  imgZP1(i,j)=pixel;
               else                                      % Non-noisy pixels are not sufficient, do Interpolation
                   [x1,x2]=interpol(imgZP(i-rng:i+rng,j-rng:j+rng));
                   if(x1==1)    % pixel computed via interpolation
                       pixel= x2;
                       imgZP1(i,j)=4;
                   else         % pixel is computed via average of previously processed pixel
                       if(((i==3)&&(j==3)) || ((i==row+2)&&(j==col+2)))
                            tmp= imgZP(i-2*rng:i+2*rng,j-2*rng:j+2*rng);
                            tmp(tmp==0)=[];
                            tmp(tmp==255)=[];
                            pixel= median(tmp);
                       else
                            if(((i==3)||(i==row+2))&&(j~=3))
                                pixel= OutImg(i-2,j-3); % previous processed signal 
                            else
                                if(((j==3)||(j==col+2)))
                                    pixel= OutImg(i-3,j-2); % previous processed signal
                                else
                                    if(((i==4)||(i==row+1)))
                                        pixel= (double(OutImg(i-2,j-3))+double(OutImg(i-3,j-2)))/2; % previous processed signal
                                    else
                                        if(((j==4)||(j==col+1)))
                                            pixel= (double(OutImg(i-3,j-2))+double(OutImg(i-2,j-3)))/2; % previous processed signal
                                        else
                                        	pixel= (double(OutImg(i-2,j-3))+double(OutImg(i-3,j-2))+double(OutImg(i-3,j-3))+double(OutImg(i-3,j-1))+double(OutImg(i-2,j-4))+double(OutImg(i-4,j-2)))/6;
                                        end
                                    end
                                end
                            end
                       end
                       imgZP1(i,j)=5;
                   end
               end
            end
        end
        OutImg(i-2,j-2)= uint8(pixel);
    end
end

% error= Img-OutImg;
% 
% subplot(1,2,1); imshow(Img);
% subplot(1,2,2); imshow(OutImg);

% mse= sum(sum((Img-OutImg).^2))/(row*col);
% PSNR= 10*log(255^2/mse);
% SSIM= ssim(Img, OutImg);

end


