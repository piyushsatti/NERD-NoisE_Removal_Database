clc; close all; clear all;

image_list = dir("medical");
code_list = dir("test_codes");
addpath("test_codes/")

for i = 3:length(code_list)
    
    code_name = split(code_list(i).name,'.');
    disp(code_name(1))
    test_code = str2func(string(code_name(1)));
    
    for j = 3:length(image_list)
        %disp(image_list(j).name)
        Img = rgb2gray(imread("medical/"+image_list(j).name));
        
        for k = 1:1:9
            nImg = imnoise(Img,'salt & pepper',k/10);
            
            oImg = test_code(nImg);
            
            psnr_medical(j-2,k,i-2) = psnr(Img,oImg);
            ssim_medical(j-2,k,i-2) = ssim(Img,oImg);
            
        end
    end
end
save('psnr_medical');
save('ssim_medical');