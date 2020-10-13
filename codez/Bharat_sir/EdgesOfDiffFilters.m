clc;clear;

B=imread('standard_test_images/lena_gray_256.tif');
OIE= SobelEdge3(B);

for i= 1: 9
    tmp= SobelEdge3(imread(['Limages/mf' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/mf' num2str(i) '.jpg']);
    edgeSSIM(i,1) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/dbamf' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/dbamf' num2str(i) '.jpg']);
    edgeSSIM(i,2) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/l2ITSAMFT' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/l2ITSAMFT' num2str(i) '.jpg']);
    edgeSSIM(i,3) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/mdbutm' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/mdbutm' num2str(i) '.jpg']);
    edgeSSIM(i,4) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/fsbmmf' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/fsbmmf' num2str(i) '.jpg']);
    edgeSSIM(i,5) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/RSIF' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/RSIF' num2str(i) '.jpg']);
    edgeSSIM(i,6) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/pdbm' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/pdbm' num2str(i) '.jpg']);
    edgeSSIM(i,7) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/damf' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/damf' num2str(i) '.jpg']);
    edgeSSIM(i,8) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/BPDM' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/BPDM' num2str(i) '.jpg']);
    edgeSSIM(i,9) = ssim(OIE,tmp);
    tmp= SobelEdge3(imread(['Limages/Prop' num2str(i) '.jpg']));
    imwrite(tmp, ['EdgeImages/Prop' num2str(i) '.jpg']);
    edgeSSIM(i,10) = ssim(OIE,tmp);
%     edgeSSIM(i,1) = ssim(OIE,SobelEdge3(imread(['Limages/mf' num2str(i) '.jpg'])));    
%     edgeSSIM(i,2) = ssim(OIE,SobelEdge3(imread(['Limages/dbamf' num2str(i) '.jpg'])));
%     edgeSSIM(i,3) = ssim(OIE,SobelEdge3(imread(['Limages/l2ITSAMFT' num2str(i) '.jpg'])));
%     edgeSSIM(i,4) = ssim(OIE,SobelEdge3(imread(['Limages/mdbutm' num2str(i) '.jpg'])));
%     edgeSSIM(i,5) = ssim(OIE,SobelEdge3(imread(['Limages/fsbmmf' num2str(i) '.jpg'])));
%     edgeSSIM(i,6) = ssim(OIE,SobelEdge3(imread(['Limages/RSIF' num2str(i) '.jpg'])));
%     edgeSSIM(i,7) = ssim(OIE,SobelEdge3(imread(['Limages/pdbm' num2str(i) '.jpg'])));
%     edgeSSIM(i,8) = ssim(OIE,SobelEdge3(imread(['Limages/damf' num2str(i) '.jpg'])));
%     edgeSSIM(i,9) = ssim(OIE,SobelEdge3(imread(['Limages/BPDM' num2str(i) '.jpg'])));
%     edgeSSIM(i,10) = ssim(OIE,SobelEdge3(imread(['Limages/Prop' num2str(i) '.jpg'])));
end
