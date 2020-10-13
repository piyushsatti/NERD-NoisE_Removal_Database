%%% Function to run all mf functions on Lena benchmark images with varying noise density.
clc; clear all;                                % Clear all existing variables

Img= imread('standard_test_images/lena_gray_512.tif');               % Reading input image
d=0.5;                                          % Default value of Noise density

x= [1 2 3 4 5 6 7 8 9];

for d= 1:9   
    nImg= imnoise(Img,'salt & pepper',0.1*d);   % Introducing noise
    
    mf_OutImg = mf(nImg,3);                               % Call mf conventional median filter
    tmp1(d,1)=psnr(Img,mf_OutImg);                      % Calculate PSNR of mf  
%     eval(['psnr_mf' num2str(d) '= tmp1(d,1)']);
    tmp2(d,1)=ssim(Img,mf_OutImg);                      % Calculate SSIM
%     imwrite(mf_OutImg,sprintf('mf%.d.jpg', d));
    tmp3(d,1)=MAE(Img,mf_OutImg);
    tmp4(d,1)=IEF(Img,nImg,mf_OutImg);
    
    dbamf_OutImg = dbamf(nImg);                         % Call dbamf median filter 2007 SPL
    tmp1(d,2)=psnr(Img,dbamf_OutImg);                   % Calculate PSNR of dbamf  
%     eval(['psnr_dbamf' num2str(d) '= tmp1(d,2)']);
    tmp2(d,2)=ssim(Img,dbamf_OutImg);                   % Calculate SSIM
%     eval(['ssim_dbamf' num2str(d) '= tmp2(d,2)']);
%     imwrite(dbamf_OutImg,sprintf('dbamf%.d.jpg', d));
    tmp3(d,2)=MAE(Img,dbamf_OutImg);
    tmp4(d,2)=IEF(Img,nImg,dbamf_OutImg);
    
    ITSAMFT_OutImg = l2ITSAMFT(nImg);                 % Call l2ITSAMFT median filter 2010 ICIIS
    tmp1(d,3)=psnr(Img,ITSAMFT_OutImg);               % Calculate PSNR of   
%     eval(['psnr_ITSAMFT' num2str(d) '= tmp1(d,3)']);
    tmp2(d,3)=ssim(Img,ITSAMFT_OutImg);               % Calculate SSIM
%     eval(['ssim_ITSAMFT' num2str(d) '= tmp2(d,3)']);
%     imwrite(ITSAMFT_OutImg,sprintf('ITSAMFT%.d.jpg', d));
    tmp3(d,3)=MAE(Img,ITSAMFT_OutImg);
    tmp4(d,3)=IEF(Img,nImg,ITSAMFT_OutImg);
    
    mdbutm_OutImg = mdbutm(nImg);                       % Call mdbutm median filter 2011 SPL 
    tmp1(d,4)=psnr(Img,mdbutm_OutImg);                  % Calculate PSNR of mdbutm  
%     eval(['psnr_mdbutm' num2str(d) '= tmp1(d,4)']);
    tmp2(d,4)=ssim(Img,mdbutm_OutImg);                  % Calculate SSIM
%     eval(['ssim_mdbutm' num2str(d) '= tmp2(d,4)']);
%     imwrite(mdbutm_OutImg,sprintf('mdbutm%.d.jpg', d));
    tmp3(d,4)=MAE(Img,mdbutm_OutImg);
    tmp4(d,4)=IEF(Img,nImg,mdbutm_OutImg);

    fsbmmf_OutImg = fsbmmf(nImg);                       % Call fsbmmf median filter 2014 AEU
    tmp1(d,5)=psnr(Img,fsbmmf_OutImg);                  % Calculate PSNR of fsbmmf  
%     eval(['psnr_fsbmmf' num2str(d) '= tmp1(d,5)']);
    tmp2(d,5)=ssim(Img,fsbmmf_OutImg);                  % Calculate SSIM
%     eval(['ssim_fsbmmf' num2str(d) '= tmp2(d,5)']);
%     imwrite(fsbmmf_OutImg,sprintf('fsbmmf%.d.jpg', d));
    tmp3(d,5)=MAE(Img,fsbmmf_OutImg);
    tmp4(d,5)=IEF(Img,nImg,fsbmmf_OutImg);
    
    RSIF_OutImg = RSIF(nImg);                           % Call RSIF median filter 2014 SIViP
    tmp1(d,6)=psnr(Img,RSIF_OutImg);                    % Calculate PSNR of RSIF  
%     eval(['psnr_RSIF' num2str(d) '= tmp1(d,6)']);
    tmp2(d,6)=ssim(Img,RSIF_OutImg);                    % Calculate SSIM
%     eval(['ssim_RSIF' num2str(d) '= tmp2(d,6)']);
%     imwrite(RSIF_OutImg,sprintf('RSIF%.d.jpg', d));
    tmp3(d,6)=MAE(Img,RSIF_OutImg);
    tmp4(d,6)=IEF(Img,nImg,RSIF_OutImg);

    pdbm_OutImg = pdbm(nImg);                           % Call pdbm median filter 2016 AEU
    tmp1(d,7)=psnr(Img,pdbm_OutImg);                    % Calculate PSNR of pdbm  
%     eval(['psnr_pdbm' num2str(d) '= tmp1(d,7)']);
    tmp2(d,7)=ssim(Img,pdbm_OutImg);                    % Calculate SSIM
%     eval(['ssim_pdbm' num2str(d) '= tmp2(d,7)']);
%     imwrite(pdbm_OutImg,sprintf('pdbm%.d.jpg', d));
    tmp3(d,7)=MAE(Img,pdbm_OutImg);
    tmp4(d,7)=IEF(Img,nImg,pdbm_OutImg);
    
    damf_OutImg = damf(nImg);                           % Call damf median filter 2018 AEU 
    tmp1(d,8)=psnr(Img,damf_OutImg);                    % Calculate PSNR of damf  
%     eval(['psnr_damf' num2str(d) '= tmp1(d,8)']);
    tmp2(d,8)=ssim(Img,damf_OutImg);                    % Calculate SSIM
%     eval(['ssim_damf' num2str(d) '= tmp2(d,8)']);
%     imwrite(damf_OutImg,sprintf('damf%.d.jpg', d));
    tmp3(d,8)=MAE(Img,damf_OutImg);
    tmp4(d,8)=IEF(Img,nImg,damf_OutImg);

    BPDM_OutImg = BPDM(nImg);                           % Call BPDM median filter 2018 Turkish 
    tmp1(d,9)=psnr(Img,BPDM_OutImg);                    % Calculate PSNR of BPDM  
%     eval(['psnr_BPDM' num2str(d) '= tmp1(d,9)']);
    tmp2(d,9)=ssim(Img,BPDM_OutImg);                    % Calculate SSIM
%     eval(['ssim_BPDM' num2str(d) '= tmp2(d,9)']);
%     imwrite(BPDM_OutImg,sprintf('BPDM%.d.jpg', d));
    tmp3(d,9)=MAE(Img,BPDM_OutImg);
    tmp4(d,9)=IEF(Img,nImg,BPDM_OutImg);
    
    tvwa_OutImg = tvwa(nImg);                           % Call tvwa median filter 2016 PRL 
    tmp1(d,10)=psnr(Img,tvwa_OutImg);                   % Calculate PSNR of BPDM  
%     eval(['psnr_tvwa' num2str(d) '= tmp1(d,10)']);
    tmp2(d,10)=ssim(Img,tvwa_OutImg);                   % Calculate SSIM
%     eval(['ssim_tvwa' num2str(d) '= tmp2(d,10)']);
%     imwrite(tvwa_OutImg,sprintf('tvwa%.d.jpg', d));
    tmp3(d,10)=MAE(Img,tvwa_OutImg);
    tmp4(d,10)=IEF(Img,nImg,tvwa_OutImg);
    
%     fahpf_OutImg = fahpf(nImg);                     % Call fahpf median filter 
%     tmp1(d,11)=psnr(Img,fahpf_OutImg);                % Calculate PSNR of fahpf  
% %     eval(['psnr_fahpf' num2str(d) '= tmp1(d,11)']);
%     tmp2(d,11)=ssim(Img,fahpf_OutImg);                % Calculate SSIM
% %     eval(['ssim_fahpf' num2str(d) '= tmp2(d,11)']);
% %     imwrite(fahpf_OutImg,sprintf('fahpf%.d.jpg', d));
%     tmp3(d,11)=MAE(Img,fahpf_OutImg);
%     tmp4(d,11)=IEF(Img,nImg,fahpf_OutImg);
    
    fahpf3_OutImg = fahpf3(nImg);                 	% Call fahpf3 median filter Proposed-I
    tmp1(d,12)=psnr(Img,fahpf3_OutImg);               	% Calculate PSNR of fahpf1  
%     eval(['psnr_fahpf3' num2str(d) '= tmp1(d,12)']);
    tmp2(d,12)=ssim(Img,fahpf3_OutImg);               	% Calculate SSIM
%     eval(['ssim_fahpf3' num2str(d) '= tmp2(d,12)']);
%     imwrite(fahpf3_OutImg,sprintf('fahpf3%.d.jpg', d));
    tmp3(d,12)=MAE(Img,fahpf3_OutImg);
    tmp4(d,12)=IEF(Img,nImg,fahpf3_OutImg);
end

% 
% figure(1);  % Code to print PSNR
% plot(x,tmp1(:,1),':b*'); hold on;   % dotted line
% plot(x,tmp1(:,2),'--ko'); hold on;  % dashed line
% plot(x,tmp1(:,3),'-.md'); hold on;  % solid line with diamond specifier
% plot(x,tmp1(:,4),'-.y<'); hold on;  % 
% plot(x,tmp1(:,5),'-.cx'); hold on;
% plot(x,tmp1(:,6),'-.gs'); hold on;
% plot(x,tmp1(:,7),'-.r^'); hold on;
% plot(x,tmp1(:,8),'-.b^'); hold on;
% plot(x,tmp1(:,9),'-.g*'); hold on;
% % plot(x,tmp1(:,10),'-.k*');hold on;
% plot(x,tmp1(:,11),'-.m*');hold on;
% plot(x,tmp1(:,12),'-.ro');
% 
% legend('smf','dbamf','ITSAMFT', 'mdbutm', 'fsbmmf','RSIF', 'pdbm', 'damf','BPDM','tvwa','fahpf','Prop',  'Location', 'NorthEast');
% % title('PSNR');
% xlabel('Noise Density (%)','FontSize',15,'FontName','Times New Roman');
% ylabel('PSNR (db)','FontSize',15,'FontName','Times New Roman');
% 
% 
% figure(2); % Code to print SSIM
% plot(x,tmp2(:,1),':b*'); hold on;   % dotted line
% plot(x,tmp2(:,2),'--ko'); hold on;  % dashed line
% plot(x,tmp2(:,3),'-.md'); hold on;  % solid line with diamond specifier
% plot(x,tmp2(:,4),'-.y<'); hold on;  % 
% plot(x,tmp2(:,5),'-.cx'); hold on;
% plot(x,tmp2(:,6),'-.gs'); hold on;
% plot(x,tmp2(:,7),'-.r^'); hold on;
% plot(x,tmp2(:,8),'-.b^'); hold on;
% plot(x,tmp2(:,9),'-.g*'); hold on;
% % plot(x,tmp2(:,10),'-.k*');hold on;
% plot(x,tmp2(:,11),'-.m*');hold on;
% plot(x,tmp2(:,12),'-.ro');
% 
% legend('smf','dbamf','ITSAMFT', 'mdbutm', 'fsbmmf','RSIF', 'pdbm', 'damf','BPDM','tvwa','fahpf','Prop',  'Location', 'NorthEast');
% xlabel('Noise Density (%)','FontSize',15,'FontName','Times New Roman');
% ylabel('SSIM','FontSize',15,'FontName','Times New Roman');
