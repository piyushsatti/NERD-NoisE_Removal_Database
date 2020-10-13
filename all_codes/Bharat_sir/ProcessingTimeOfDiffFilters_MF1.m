%%% Function to run all mf functions on benchmark images with varying noise
%%% density.

clc; clear all;                                 % Clear all existing variables
Img= imread('standard_test_images/lena_gray_256.tif');               % Reading input image
d=0.5;                                          % Default value of Noise density

x= [1 2 3 4 5 6 7 8 9];

for d= 1:9   
    nImg= imnoise(Img,'salt & pepper',0.1*d);   % Introducing noise

    f = @() mf(nImg);
    tmp3(d,1)= timeit(f);
%     mf_OutImg = mf(nImg);                               % Call mf conventional median filter
%     tmp1(d,1)=psnr(Img,mf_OutImg);                      % Calculate PSNR of mf  
%     eval(['psnr_mf' num2str(d) '= tmp1(d,1)']);
%     tmp2(d,1)=ssim(Img,mf_OutImg);                      % Calculate SSIM
%     eval(['ssim_mf' num2str(d) '= tmp2(d,1)']);
%     filename = ['mf' num2str(d) '.jpg'];
%     imwrite(mf_OutImg,filename);
   
    f = @() dbamf(nImg);
    tmp3(d,2)= timeit(f);
%     dbamf_OutImg = dbamf(nImg);                         % Call dbamf median filter 2007 SPL
%     tmp1(d,2)=psnr(Img,dbamf_OutImg);                   % Calculate PSNR of dbamf  
%     eval(['psnr_dbamf' num2str(d) '= tmp1(d,2)']);
%     tmp2(d,2)=ssim(Img,dbamf_OutImg);                   % Calculate SSIM
%     eval(['ssim_dbamf' num2str(d) '= tmp2(d,2)']);
%     filename = ['dbamf' num2str(d) '.jpg'];
%     imwrite(dbamf_OutImg,filename);
    
    f = @() l2ITSAMFT(nImg);
    tmp3(d,3)= timeit(f);
%     l2ITSAMFT_OutImg = l2ITSAMFT(nImg);                 % Call l2ITSAMFT median filter 2010 ICIIS
%     tmp1(d,3)=psnr(Img,l2ITSAMFT_OutImg);               % Calculate PSNR of fsbmmf  
%     eval(['psnr_l2ITSAMFT' num2str(d) '= tmp1(d,3)']);
%     tmp2(d,3)=ssim(Img,l2ITSAMFT_OutImg);               % Calculate SSIM
%     eval(['ssim_l2ITSAMFT' num2str(d) '= tmp2(d,3)']);
%     filename = ['l2ITSAMFT' num2str(d) '.jpg'];
%     imwrite(l2ITSAMFT_OutImg,filename);
    
    f = @() mdbutm(nImg);
    tmp3(d,4)= timeit(f);
%     mdbutm_OutImg = mdbutm(nImg);                       % Call mdbutm median filter 2011 SPL 
%     tmp1(d,4)=psnr(Img,mdbutm_OutImg);                  % Calculate PSNR of mdbutm  
%     eval(['psnr_mdbutm' num2str(d) '= tmp1(d,4)']);
%     tmp2(d,4)=ssim(Img,mdbutm_OutImg);                  % Calculate SSIM
%     eval(['ssim_mdbutm' num2str(d) '= tmp2(d,4)']);
%     filename = ['mdbutm' num2str(d) '.jpg'];
%     imwrite(mdbutm_OutImg,filename);
    
    f = @() fsbmmf(nImg);
    tmp3(d,5)= timeit(f);
%     fsbmmf_OutImg = fsbmmf(nImg);                       % Call fsbmmf median filter 2014 AEU
%     tmp1(d,5)=psnr(Img,fsbmmf_OutImg);                  % Calculate PSNR of fsbmmf  
%     eval(['psnr_fsbmmf' num2str(d) '= tmp1(d,5)']);
%     tmp2(d,5)=ssim(Img,fsbmmf_OutImg);                  % Calculate SSIM
%     eval(['ssim_fsbmmf' num2str(d) '= tmp2(d,5)']);
%     filename = ['fsbmmf' num2str(d) '.jpg'];
%     imwrite(fsbmmf_OutImg,filename);
    
    f = @() RSIF(nImg);
    tmp3(d,6)= timeit(f);
%     RSIF_OutImg = RSIF(nImg);                           % Call RSIF median filter 2014 SIViP
%     tmp1(d,6)=psnr(Img,RSIF_OutImg);                    % Calculate PSNR of RSIF  
%     eval(['psnr_RSIF' num2str(d) '= tmp1(d,6)']);
%     tmp2(d,6)=ssim(Img,RSIF_OutImg);                    % Calculate SSIM
%     eval(['ssim_RSIF' num2str(d) '= tmp2(d,6)']);
%     filename = ['RSIF' num2str(d) '.jpg'];
%     imwrite(RSIF_OutImg,filename);
    
    f = @() pdbm(nImg);
    tmp3(d,7)= timeit(f);
%     pdbm_OutImg = pdbm(nImg);                           % Call pdbm median filter 2016 AEU
%     tmp1(d,7)=psnr(Img,pdbm_OutImg);                    % Calculate PSNR of pdbm  
%     eval(['psnr_pdbm' num2str(d) '= tmp1(d,7)']);
%     tmp2(d,7)=ssim(Img,pdbm_OutImg);                    % Calculate SSIM
%     eval(['ssim_pdbm' num2str(d) '= tmp2(d,7)']);
%     filename = ['pdbm' num2str(d) '.jpg'];
%     imwrite(pdbm_OutImg,filename);
    
    f = @() damf(nImg);
    tmp3(d,8)= timeit(f);
%     damf_OutImg = damf(nImg);                           % Call damf median filter 2018 AEU 
%     tmp1(d,8)=psnr(Img,damf_OutImg);                    % Calculate PSNR of damf  
%     eval(['psnr_damf' num2str(d) '= tmp1(d,8)']);
%     tmp2(d,8)=ssim(Img,damf_OutImg);                    % Calculate SSIM
%     eval(['ssim_damf' num2str(d) '= tmp2(d,8)']);
%     filename = ['damf' num2str(d) '.jpg'];
%     imwrite(damf_OutImg,filename);
    
    f = @() BPDM(nImg);
    tmp3(d,9)= timeit(f);
%     BPDM_OutImg = BPDM(nImg);                           % Call BPDM median filter 2018 Turkish 
%     tmp1(d,9)=psnr(Img,BPDM_OutImg);                    % Calculate PSNR of BPDM  
%     eval(['psnr_BPDM' num2str(d) '= tmp1(d,9)']);
%     tmp2(d,9)=ssim(Img,BPDM_OutImg);                    % Calculate SSIM
%     eval(['ssim_BPDM' num2str(d) '= tmp2(d,9)']);
%     filename = ['BPDM' num2str(d) '.jpg'];
%     imwrite(BPDM_OutImg,filename);
    
    f = @() fsbmmf5(nImg);
    tmp3(d,10)= timeit(f);
%     fsbmmf4_OutImg = fsbmmf4(nImg);                           % Call fsbmmf4 median filter Proposed-I
%     tmp1(d,10)=psnr(Img,fsbmmf4_OutImg);                    % Calculate PSNR of fsbmmf4  
%     eval(['psnr_fsbmmf4' num2str(d) '= tmp1(d,10)']);
%     tmp2(d,10)=ssim(Img,fsbmmf4_OutImg);                    % Calculate SSIM
%     eval(['ssim_fsbmmf4' num2str(d) '= tmp2(d,10)']);
%     filename = ['Prop' num2str(d) '.jpg'];
%     imwrite(fsbmmf4_OutImg,filename);
end

% % Code to print PSNR
% plot(x,tmp1(:,1),':b*'); hold on;   % dotted line
% plot(x,tmp1(:,2),'--ko'); hold on;  % dashed line
% plot(x,tmp1(:,3),'-.md'); hold on;  % solid line with diamond specifier
% plot(x,tmp1(:,4),'-.y<'); hold on;  % 
% plot(x,tmp1(:,5),'-.cx'); hold on;
% plot(x,tmp1(:,6),'-.gs'); hold on;
% plot(x,tmp1(:,7),'-.r^'); hold on;
% plot(x,tmp1(:,8),'-.b^'); hold on;
% plot(x,tmp1(:,9),'-.g*'); hold on;
% plot(x,tmp1(:,10),'-.k*');
% 
% legend('smf','dbamf','l2ITSAMFT', 'mdbutm', 'fsbmmf','RSIF', 'pdbm', 'damf','BPDM','Prop', 'Location', 'NorthEast');
% title('PSNR');
% xlabel('Noise Density (%)','FontSize',15,'FontName','Times New Roman');
% ylabel('PSNR (db)','FontSize',15,'FontName','Times New Roman');
% 
