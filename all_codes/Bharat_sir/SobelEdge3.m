% sobel edge detector
function Zout = SobelEdge3(B)
% B= imread('standard_test_images/lena_gray_256.tif');
InImg= double(B);
[r, c]= size(B);
Zout= B;
for i=(1:size(InImg,1)-2)
    for j=(1:size(InImg,2)-2)
       Gx=((2*InImg(i+2,j+1)+InImg(i+2,j)+InImg(i+2,j+2))-(2*InImg(i,j+1)+InImg(i,j)+InImg(i,j+2)));
       Gy=((2*InImg(i+1,j+2)+InImg(i,j+2)+InImg(i+2,j+2))-(2*InImg(i+1,j)+InImg(i,j)+InImg(i+2,j)));
       G1=abs(Gx);
       G2=abs(Gy);
       %The gradient of the image
       Zout(i,j)=uint8(((G1)+(G2)));    
    end
end
% imshow(Zout);
end
