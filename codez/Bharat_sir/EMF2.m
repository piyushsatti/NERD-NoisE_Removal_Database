% Two new methods for removing salt-and-pepper noise(2016)
% from digital images
% U?gur Erkana, Adem Kilicmanb,
% a Erbaa Vocational School, Gaziosmanpa¸sa, 60500 Erbaa, Tokat, Turkey
% b Department of Mathematics and Institute for Mathematical Research, University Putra Malaysia,
% 43400 UPM, Serdang, Selangor, Malaysia
clc
clear all;
Img= imread('mandril_gray.tif');   % Reading input image
 d= 0.9;   % Noise density
 nImg= imread('0.7mandril.tif');   % Introducing noise
[row col]=size(nImg);
for i= 2:row-2
     for j= 2:col-2
          b= reshape(nImg(i:i+2,j:j+2),1,[]);
          nImg(i+1,j+1)=b(1,5);
          Pe=nImg(i+1,j+1);
          [m n]=size(b);
          b=sort(b);
          a=(m*n);% a is alpha
          Py=median(b);
          tmp=b;
          tmp(tmp==Py)=[];
          [row1 col1]=size(tmp);
          if(Pe>=Py+a)||(Pe<=Py-a)
              nImg(i+1,j+1)=Py;
          end
     end
end
figure(1); imshow(Img);
 figure(2); imshow(nImg);
  PSNR=psnr(Img,nImg)    