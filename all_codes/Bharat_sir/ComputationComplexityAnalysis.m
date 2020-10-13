%%% Function to run all mf functions on Lena benchmark images with varying noise density.
clc; clear all;                                % Clear all existing variables

Img= imread('tm/chest_256.jpg');               % Reading input image
d=0.5;                                          % Default value of Noise density

x= [10 20 30 40 50 60 70 80 90];

for d= 1:9  
    nImg= imnoise(Img,'salt & pepper', 0.1*d);   % Introducing noise

    [tmp1(d,1),tmp2(d,1)] = CCA_ASWMF(nImg);                               % Call mf conventional median filter
    [tmp1(d,2),tmp2(d,2)] = CCA_Prop5(nImg);
end

tmp1(:,1)=tmp1(:,1)./tmp2(:,1);
tmp1(:,2)=tmp1(:,2)./tmp2(:,2);
figure(1);  % Code to print Computations
plot(x,tmp1(1:9,1),':b*'); hold on;   % dotted line
plot(x,tmp1(1:9,2),'-.gs');

tmp3(:,1)= ((tmp1(:,1)-tmp1(:,2))./tmp1(:,1))*100;
plot(x,tmp3(1:9,1),':b*');
% legend('Median filter', 'Prop',  'Location', 'NorthEast');
% title('PSNR');
xlabel('Noise Density (%)','FontSize',15,'FontName','Times New Roman');
ylabel('Compexity Reduction (%)','FontSize',15,'FontName','Times New Roman');

% x= [10 20 30 40 50 60 70 80 90];
% figure(2); % Code to print SSIM
% plot(x,tmp2(:,1),':b*'); hold on;   % dotted line
% plot(x,tmp2(:,2),'--ko'); hold on;  % dashed line
% plot(x,tmp2(:,3),'-.md'); hold on;  % solid line with diamond specifier
% plot(x,tmp2(:,4),'-.y<'); hold on;  % 
% plot(x,tmp2(:,5),'-.cx'); hold on;
% plot(x,tmp2(:,6),'-.gs'); hold on;
% plot(x,tmp2(:,7),'-.r^'); hold on;
% plot(x,tmp2(:,8),'-.b^'); hold on;
% plot(x,tmp2(:,9),'-.g*'); 
% 
% legend('smf', 'mdbutm', 'fsbmmf','RSIF', 'pdbm', 'damf','BPDM','twva','Prop',  'Location', 'NorthEast');
% xlabel('Noise Density (%)','FontSize',15,'FontName','Times New Roman');
% ylabel('SSIM','FontSize',15,'FontName','Times New Roman');
