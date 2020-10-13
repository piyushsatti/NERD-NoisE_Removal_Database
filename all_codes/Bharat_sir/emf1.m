% Two new methods for removing salt-and-pepper noise(2016)
% from digital images
% U?gur Erkana, Adem Kilicmanb,
% a Erbaa Vocational School, Gaziosmanpa¸sa, 60500 Erbaa, Tokat, Turkey
% b Department of Mathematics and Institute for Mathematical Research, University Putra Malaysia,
% 43400 UPM, Serdang, Selangor, Malaysiaclc;
clear all;
Img= imread('mandril_gray.tif');   % Reading input image
 d= 0.9;   % Noise density
 nImg= imread('0.1mandril.tif');   % Introducing noise
[row col]=size(nImg);
cof=1.8;
o=0;
 for i= 2:row-2
     for j= 2:col-2
          b= reshape(nImg(i:i+2,j:j+2),1,[]);%a is alpha and sigma is sig
          nImg(i+1,j+1)=b(1,5);
          Pe=nImg(i+1,j+1);
          [m n]=size(b);
          b=sort(b);
          %a=(m*n)^cof;
          a=2.3;
          Py=median(b);
          tmp=b;
          tmp(tmp==Py)=[];
          [row1 col1]=size(tmp);
          for x=1:row1
              for y=1:col1
                  o=o+1;
                  tmp1(1,o)=abs(double(tmp(x,y))-double(Py));
              end
          end
          o=0;
          sig=sum(tmp1);
          if((Pe>=Py+a+sqrt(sig))||(Pe<=Py-a-sqrt(sig)))
             nImg(i+1,j+1)=Py;
             sig=0;
             
          end
     end
 end
 figure(1); imshow(Img);
 figure(2); imshow(nImg);
  PSNR=psnr(nImg,Img)               
          