% DCT and Inverse DCT for medical image denoising 

I= imread('tm/lena_gray_256.tif');
% In=imnoise(I,'salt & pepper',0.05); 
In=imnoise(I,'gaussian',0,0.05); 
[row col]= size(In);
DCT_in= zeros(row,col);
% dct_x= zeros(8,8);
Adct_x= zeros(16,16);
th=10;
for i=1:row/16
    for j=1:col/16
        x= double(In((i-1)*16+1:i*16,(j-1)*16+1:j*16));
        dct_x= dct2(x);
%          Adct_x(1:16,1:16)= dct_x(1:16,1:16);
        for k=1:th
            for l= 1: th-k+1
                Adct_x(k,l)= dct_x(k,l);    
            end
        end
        y= idct2(Adct_x);
        DCT_in((i-1)*16+1:i*16,(j-1)*16+1:j*16)=y;
    end
end

subplot(1,3,1);imshow(uint8(I));
subplot(1,3,2);imshow(uint8(In));
subplot(1,3,3);imshow(uint8(DCT_in));
PSNR=psnr(uint8(I),uint8(DCT_in));
