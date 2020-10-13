clc ; clear all; close all;
image_list = dir("image2/");
image_c= 0;
% movefile image_list(3).name image_correct;
for j = 3:length(image_list)
    try
        Img = rgb2gray(imread("image2/"+image_list(j).name));
        %movefile image_list(j).name newFolder;
        image_c = [image_c image_list(j).name];
    catch ME
        %disp(j)
    end
end
image_c
