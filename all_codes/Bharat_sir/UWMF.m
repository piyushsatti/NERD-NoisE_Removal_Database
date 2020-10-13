clc; clear all; 
Img = imread('Lena_gray_512.tif');
d= 0.7;  
nImg= imnoise(Img,'salt & pepper',d);
pad = 4; % according to window size (mfw+1)/2;
imgZP = padarray(nImg,[pad pad],'symmetric');
imgZP = double(imgZP);
mfw =7;

% choose according to noisde density 
% Recommended window sizes for the proposed method.
% Noise density (p) Window size
% p < 20                3 × 3
% 20 ? p < 50       5 × 5
% 50 ? p < 70       7 × 7
% 70 ? p < 85       9 × 9
% 85 ? p < 90       11 × 11
% p ? 90                13 × 13




rng = (mfw - 1) / 2;
[row,col] = size(nImg);
k=5;

% tmp =[192 105 255 81 78;208 163 255 89 255;2524 205 255 255 255;225 0 255 255 89;227 228 222 198 133;];
num =1000000;
count1 =0;
count2=0;
count3=0;
count4=0;
p=1;
for i = 1+pad:row+pad
    for j = 1+pad:col+pad
        if ((imgZP(i,j) == 0) || (imgZP(i,j) == 255))
             count4=count4+1;
            sumi=0;sumwdash=0;
            count255=0;count0=0;
            P=0;Q=0;R=0;S=0;T=0;
            tmp = imgZP(i-rng:i+rng,j-rng:j+rng);
            for x=-rng+i:rng+i
                for y = -rng+j:rng+j
                    if  (imgZP(x,y) ~=0) && (imgZP(x,y) ~=255)
%                         check = imgZP(x,y)  
                        dxyx = x-i;
                        dxyy = y-j;
                        wxy(x-i+pad,y-j+pad) = power(power((power(abs(x-i),p)+power(abs(y-j),p)),1/p),-k);
                        P=P+((wxy(x-i+pad,y-j+pad)*dxyx)*dxyx);
                        Q=Q+((wxy(x-i+pad,y-j+pad)*dxyx)*dxyy);
                        R=R+((wxy(x-i+pad,y-j+pad)*dxyx));
                        S=S+((wxy(x-i+pad,y-j+pad)*dxyy)*dxyy);
                        T=T+((wxy(x-i+pad,y-j+pad)*dxyy));
                        
                    end
                end
            end
            R=-R;
            T=-T;
            gydash= ((P*T)-(Q*R))/((-power(Q,2))+(P*S));
            gxdash= ((R)-(Q*gydash))/P;
            for x=1:length(tmp)
                for y =1:length(tmp)
                    if tmp(x,y)==255
                        count255 =count255+1;
                    elseif tmp(x,y) ==0
                        coutn0=count0+1;
                    else
                        wxydash = wxy(x,y) +(wxy(x,y)*((gxdash*dxyx)+(gydash*dxyy)));
                        sumwdash=sumwdash+wxydash;
                        num = tmp(x,y)*wxydash;
                        sumi = sumi + (tmp(x,y)*wxydash);
                    end
                end
            end
            tmp = imgZP(i-rng:i+rng,j-rng:j+rng);
            if (count255+count0) == power(mfw,2)
                if coutn255>count0
                    imgZP(i,j)=255;
                    count1=count1+1;
                else
                    imgZP(i,j)=0;
                    count2=count2+1;
                end
            else
%                 imgZP(i,j) = (sumi)/(sumwdash);
                   pix =  (sumi)/(sumwdash);
                count3=count3+1;
            end
        else
%            imgZP(i,j) = imgZP(i,j);
                pix = imgZP(i,j);
%             count1=count1+1;

        end
        OutImg(i-pad,j-pad) = uint8(pix);
    end
end

% OutImg = uint8(imgZP(1+pad:row+pad,1+pad:col+pad));

subplot(1,3,1)
imshow(Img)
subplot(1,3,2)
imshow(nImg)
subplot(1,3,3)
imshow(OutImg)



PSNR = psnr(Img,OutImg)




