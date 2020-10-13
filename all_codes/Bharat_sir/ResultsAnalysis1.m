%%% Function to run all mf functions on Lena benchmark images with varying noise density.
clc; clear all;                                % Clear all existing variables

Img= imread('tm/chest_256.jpg');               % Reading input image
d=0.5;                                          % Default value of Noise density

x= [10 20 30 40 50 60 70 80 90];

for d= 1:9   
    nImg= imnoise(Img,'salt & pepper', 0.9 + 0.01*d);   % Introducing noise
    SEDNI= sum(sum((double(Img)-double(nImg)).^2));
    
    mf_OutImg = mf(nImg,3);                               % Call mf conventional median filter
    tmp1(d,1)=psnr(Img,mf_OutImg);                      % Calculate PSNR of mf  
    eval(['psnr_mf' num2str(d) '= tmp1(d,1)']);
    tmp2(d,1)=ssim(Img,mf_OutImg);                      % Calculate SSIM
    imwrite(mf_OutImg,sprintf('mf%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(mf_OutImg)).^2));
    tmp3(d,1)= SEDNI/SEDRI;
    
    mdbutm_OutImg = mdbutm(nImg);                       % Call mdbutm median filter 2011 SPL 
    tmp1(d,2)=psnr(Img,mdbutm_OutImg);                  % Calculate PSNR of mdbutm  
    eval(['psnr_mdbutm' num2str(d) '= tmp1(d,2)']);
    tmp2(d,2)=ssim(Img,mdbutm_OutImg);                  % Calculate SSIM
    eval(['ssim_mdbutm' num2str(d) '= tmp2(d,2)']);
    imwrite(mdbutm_OutImg,sprintf('mdbutm%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(mdbutm_OutImg)).^2));
    tmp3(d,2)= SEDNI/SEDRI;
    
    fsbmmf_OutImg = fsbmmf(nImg);                       % Call fsbmmf median filter 2014 AEU
    tmp1(d,3)=psnr(Img,fsbmmf_OutImg);                  % Calculate PSNR of fsbmmf  
    eval(['psnr_fsbmmf' num2str(d) '= tmp1(d,3)']);
    tmp2(d,3)=ssim(Img,fsbmmf_OutImg);                  % Calculate SSIM
    eval(['ssim_fsbmmf' num2str(d) '= tmp2(d,3)']);
    imwrite(fsbmmf_OutImg,sprintf('fsbmmf%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(fsbmmf_OutImg)).^2));
    tmp3(d,3)= SEDNI/SEDRI;
    
    RSIF_OutImg = RSIF(nImg);                           % Call RSIF median filter 2014 SIViP
    tmp1(d,4)=psnr(Img,RSIF_OutImg);                    % Calculate PSNR of RSIF  
    eval(['psnr_RSIF' num2str(d) '= tmp1(d,4)']);
    tmp2(d,4)=ssim(Img,RSIF_OutImg);                    % Calculate SSIM
    eval(['ssim_RSIF' num2str(d) '= tmp2(d,4)']);
    imwrite(RSIF_OutImg,sprintf('RSIF%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(RSIF_OutImg)).^2));
    tmp3(d,4)= SEDNI/SEDRI;
    
    pdbm_OutImg = pdbm(nImg);                           % Call pdbm median filter 2016 AEU
    tmp1(d,5)=psnr(Img,pdbm_OutImg);                    % Calculate PSNR of pdbm  
    eval(['psnr_pdbm' num2str(d) '= tmp1(d,5)']);
    tmp2(d,5)=ssim(Img,pdbm_OutImg);                    % Calculate SSIM
    eval(['ssim_pdbm' num2str(d) '= tmp2(d,5)']);
    imwrite(pdbm_OutImg,sprintf('pdbm%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(pdbm_OutImg)).^2));
    tmp3(d,5)= SEDNI/SEDRI;
    
    damf_OutImg = damf(nImg);                           % Call damf median filter 2018 AEU 
    tmp1(d,6)=psnr(Img,damf_OutImg);                    % Calculate PSNR of damf  
    eval(['psnr_damf' num2str(d) '= tmp1(d,6)']);
    tmp2(d,6)=ssim(Img,damf_OutImg);                    % Calculate SSIM
    eval(['ssim_damf' num2str(d) '= tmp2(d,6)']);
    imwrite(damf_OutImg,sprintf('damf%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(damf_OutImg)).^2));
    tmp3(d,5)= SEDNI/SEDRI;
    
    BPDM_OutImg = BPDM(nImg);                           % Call BPDM median filter 2018 Turkish 
    tmp1(d,7)=psnr(Img,BPDM_OutImg);                    % Calculate PSNR of BPDM  
    eval(['psnr_BPDM' num2str(d) '= tmp1(d,7)']);
    tmp2(d,7)=ssim(Img,BPDM_OutImg);                    % Calculate SSIM
    eval(['ssim_BPDM' num2str(d) '= tmp2(d,7)']);
    imwrite(BPDM_OutImg,sprintf('BPDM%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(BPDM_OutImg)).^2));
    tmp3(d,7)= SEDNI/SEDRI;
    
    tvwa_OutImg = tvwa(nImg);                     % Call tvwa median filter 
    tmp1(d,8)=psnr(Img,tvwa_OutImg);                % Calculate PSNR of fahpf  
    eval(['psnr_tvwa' num2str(d) '= tmp1(d,8)']);
    tmp2(d,8)=ssim(Img,tvwa_OutImg);                % Calculate SSIM
    eval(['ssim_tvwa' num2str(d) '= tmp2(d,8)']);
    imwrite(tvwa_OutImg,sprintf('tvwa%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(tvwa_OutImg)).^2));
    tmp3(d,8)= SEDNI/SEDRI;
    
    Prop5_OutImg = tvwa5(nImg);                 	% Call tvwa5 median filter Proposed-I
    tmp1(d,9)=psnr(Img,Prop5_OutImg);               	% Calculate PSNR of tvwa2  
    eval(['psnr_Prop5' num2str(d) '= tmp1(d,9)']);
    tmp2(d,9)=ssim(Img,Prop5_OutImg);               	% Calculate SSIM
    eval(['ssim_Prop5' num2str(d) '= tmp2(d,9)']);
    imwrite(Prop5_OutImg,sprintf('Prop5%.d.jpg', d));
    SEDRI= sum(sum((double(Img)-double(Prop5_OutImg)).^2));
    tmp3(d,9)= SEDNI/SEDRI;
end


figure(1);  % Code to print PSNR
plot(x,tmp1(1:9,1),':b*'); hold on;   % dotted line
plot(x,tmp1(1:9,2),'--ko'); hold on;  % dashed line
plot(x,tmp1(1:9,3),'-.md'); hold on;  % solid line with diamond specifier
plot(x,tmp1(1:9,4),'-.y<'); hold on;  % 
plot(x,tmp1(1:9,5),'-.cx'); hold on;
plot(x,tmp1(1:9,6),'-.gs'); hold on;
plot(x,tmp1(1:9,7),'-.r^'); hold on;
plot(x,tmp1(1:9,8),'-.b^'); hold on;
plot(x,tmp1(1:9,9),'-.g*');


legend('smf', 'mdbutm', 'fsbmmf','RSIF', 'pdbm', 'damf','BPDM','twva','Prop',  'Location', 'NorthEast');
% title('PSNR');
xlabel('Noise Density (%)','FontSize',15,'FontName','Times New Roman');
ylabel('PSNR (db)','FontSize',15,'FontName','Times New Roman');

x= [10 20 30 40 50 60 70 80 90];
figure(2); % Code to print SSIM
plot(x,tmp2(:,1),':b*'); hold on;   % dotted line
plot(x,tmp2(:,2),'--ko'); hold on;  % dashed line
plot(x,tmp2(:,3),'-.md'); hold on;  % solid line with diamond specifier
plot(x,tmp2(:,4),'-.y<'); hold on;  % 
plot(x,tmp2(:,5),'-.cx'); hold on;
plot(x,tmp2(:,6),'-.gs'); hold on;
plot(x,tmp2(:,7),'-.r^'); hold on;
plot(x,tmp2(:,8),'-.b^'); hold on;
plot(x,tmp2(:,9),'-.g*'); 

legend('smf', 'mdbutm', 'fsbmmf','RSIF', 'pdbm', 'damf','BPDM','twva','Prop',  'Location', 'NorthEast');
xlabel('Noise Density (%)','FontSize',15,'FontName','Times New Roman');
ylabel('SSIM','FontSize',15,'FontName','Times New Roman');
