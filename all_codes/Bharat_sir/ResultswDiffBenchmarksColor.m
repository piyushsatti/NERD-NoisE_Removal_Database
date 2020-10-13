%%% Function to run all mf functions on benchmark color images with varying noise
%%% density.

clc; clear all;                                 % Clear all existing variables
Img= uint8(zeros(292,380,3,9));

Img(:,:,:,1)= imread('retinal.jpg');               % Reading input image
% Img(:,:,:,2)= imread('TestImagesColor\mandril_color_512.tif'); 
% Img(:,:,:,3)= imread('TestImagesColor\pepper_color_512.tif'); 

d=0.89;                                          % Default value of Noise density

for i= 1:9 
    nImg(:,:,:,i)= uint8(imnoise(Img(:,:,:,i),'salt & pepper',d+0.01*i));   % Introducing noise
    
    for j=1:3
        mf_OutImg(:,:,j,i) = mf(nImg(:,:,j,i),3); % Call mf conventional median filter                           
    end                               
    tmp1(i,1)=psnr(Img(:,:,:,i),mf_OutImg(:,:,:,i));                      % Calculate PSNR of mf  
    eval(['psnr_mf' num2str(i) '= tmp1(i,1)']);
    tmp2(i,1)=ssim(Img(:,:,:,i),mf_OutImg(:,:,:,i));                      % Calculate SSIM
    eval(['ssim_mf' num2str(i) '= tmp2(i,1)']);
    filename = ['mf' num2str(i) '.jpg'];
    imwrite(mf_OutImg(:,:,:,i),filename);
    
    for j=1:3
        dbamf_OutImg(:,:,j,i) = dbamf(nImg(:,:,j,i));                         % Call dbamf median filter 2007 SPL
    end
    tmp1(i,2)=psnr(Img(:,:,:,i),dbamf_OutImg(:,:,:,i));                   % Calculate PSNR of dbamf  
    eval(['psnr_dbamf' num2str(i) '= tmp1(i,2)']);
    tmp2(i,2)=ssim(Img(:,:,:,i),dbamf_OutImg(:,:,:,i));                   % Calculate SSIM
    eval(['ssim_dbamf' num2str(i) '= tmp2(i,2)']);
    filename = ['dbamf' num2str(i) '.jpg'];
    imwrite(dbamf_OutImg(:,:,:,i),filename);
    
    for j=1:3
        l2ITSAMFT_OutImg(:,:,j,i) = l2ITSAMFT(nImg(:,:,j,i));           % Call l2ITSAMFT median filter 2010 ICIIS
    end
    tmp1(i,3)=psnr(Img(:,:,:,i),l2ITSAMFT_OutImg(:,:,:,i));               % Calculate PSNR of fsbmmf  
    eval(['psnr_l2ITSAMFT' num2str(i) '= tmp1(i,3)']);
    tmp2(i,3)=ssim(Img(:,:,:,i),l2ITSAMFT_OutImg(:,:,:,i));               % Calculate SSIM
    eval(['ssim_l2ITSAMFT' num2str(i) '= tmp2(i,3)']);
    filename = ['l2ITSAMFT' num2str(i) '.jpg'];
    imwrite(l2ITSAMFT_OutImg(:,:,:,i),filename);
    
    for j=1:3
        mdbutm_OutImg(:,:,j,i) = mdbutm(nImg(:,:,j,i));                       % Call mdbutm median filter 2011 SPL 
    end
    tmp1(i,4)=psnr(Img(:,:,:,i),mdbutm_OutImg(:,:,:,i));                  % Calculate PSNR of mdbutm  
    eval(['psnr_mdbutm' num2str(i) '= tmp1(i,4)']);
    tmp2(i,4)=ssim(Img(:,:,:,i),mdbutm_OutImg(:,:,:,i));                  % Calculate SSIM
    eval(['ssim_mdbutm' num2str(i) '= tmp2(i,4)']);
    filename = ['mdbutm' num2str(i) '.jpg'];
    imwrite(mdbutm_OutImg(:,:,:,i),filename);
    
    for j=1:3
        fsbmmf_OutImg(:,:,j,i) = fsbmmf(nImg(:,:,j,i));                       % Call fsbmmf median filter 2014 AEU
    end
    tmp1(i,5)=psnr(Img(:,:,:,i),fsbmmf_OutImg(:,:,:,i));                  % Calculate PSNR of fsbmmf  
    eval(['psnr_fsbmmf' num2str(i) '= tmp1(i,5)']);
    tmp2(i,5)=ssim(Img(:,:,:,i),fsbmmf_OutImg(:,:,:,i));                  % Calculate SSIM
    eval(['ssim_fsbmmf' num2str(i) '= tmp2(i,5)']);
    filename = ['fsbmmf' num2str(i) '.jpg'];
    imwrite(fsbmmf_OutImg(:,:,:,i),filename);
    
    for j=1:3
        RSIF_OutImg(:,:,j,i) = RSIF(nImg(:,:,j,i));                           % Call RSIF median filter 2014 SIViP
    end
    tmp1(i,6)=psnr(Img(:,:,:,i),RSIF_OutImg(:,:,:,i));                    % Calculate PSNR of RSIF  
    eval(['psnr_RSIF' num2str(i) '= tmp1(i,6)']);
    tmp2(i,6)=ssim(Img(:,:,:,i),RSIF_OutImg(:,:,:,i));                    % Calculate SSIM
    eval(['ssim_RSIF' num2str(i) '= tmp2(i,6)']);
    filename = ['RSIF' num2str(i) '.jpg'];
    imwrite(RSIF_OutImg(:,:,:,i),filename);
    
    for j=1:3
        pdbm_OutImg(:,:,j,i) = pdbm(nImg(:,:,j,i));                           % Call pdbm median filter 2016 AEU
    end
    tmp1(i,7)=psnr(Img(:,:,:,i),pdbm_OutImg(:,:,:,i));                    % Calculate PSNR of pdbm  
    eval(['psnr_pdbm' num2str(i) '= tmp1(i,7)']);
    tmp2(i,7)=ssim(Img(:,:,:,i),pdbm_OutImg(:,:,:,i));                    % Calculate SSIM
    eval(['ssim_pdbm' num2str(i) '= tmp2(i,7)']);
    filename = ['pdbm' num2str(i) '.jpg'];
    imwrite(pdbm_OutImg(:,:,:,i),filename);
    
    for j=1:3
        damf_OutImg(:,:,j,i) = damf(nImg(:,:,j,i));                           % Call damf median filter 2018 AEU 
    end
    tmp1(i,8)=psnr(Img(:,:,:,i),damf_OutImg(:,:,:,i));                    % Calculate PSNR of damf  
    eval(['psnr_damf' num2str(i) '= tmp1(i,8)']);
    tmp2(i,8)=ssim(Img(:,:,:,i),damf_OutImg(:,:,:,i));                    % Calculate SSIM
    eval(['ssim_damf' num2str(i) '= tmp2(i,8)']);
    filename = ['damf' num2str(i) '.jpg'];
    imwrite(damf_OutImg(:,:,:,i),filename);
    
    for j=1:3
        BPDM_OutImg(:,:,j,i) = BPDM(nImg(:,:,j,i));                           % Call BPDM median filter 2018 Turkish 
    end
    tmp1(i,9)=psnr(Img(:,:,:,i),BPDM_OutImg(:,:,:,i));                    % Calculate PSNR of BPDM  
    eval(['psnr_BPDM' num2str(i) '= tmp1(i,9)']);
    tmp2(i,9)=ssim(Img(:,:,:,i),BPDM_OutImg(:,:,:,i));                    % Calculate SSIM
    eval(['ssim_BPDM' num2str(i) '= tmp2(i,9)']);
    filename = ['BPDM' num2str(i) '.jpg'];
    imwrite(BPDM_OutImg(:,:,:,i),filename);
  
    for j=1:3
       tvwa_OutImg(:,:,j,i) = tvwa(nImg(:,:,j,i));                           % Call fahpf median filter Proposed-I
    end
    tmp1(i,10)=psnr(Img(:,:,:,i),tvwa_OutImg(:,:,:,i));                    % Calculate PSNR of fahpf  
    eval(['psnr_tvwa' num2str(i) '= tmp1(i,10)']);
    tmp2(i,10)=ssim(Img(:,:,:,i),tvwa_OutImg(:,:,:,i));                    % Calculate SSIM
    eval(['ssim_tvwa' num2str(i) '= tmp2(i,10)']);
    filename = ['tvwa' num2str(i) '.jpg'];
    imwrite(tvwa_OutImg(:,:,:,i),filename);
    
    for j=1:3
       tvwa5_OutImg(:,:,j,i) = tvwa5(nImg(:,:,j,i));                        % Call fahpf median filter Proposed-I
    end
    tmp1(i,11)=psnr(Img(:,:,:,i),tvwa5_OutImg(:,:,:,i));                    % Calculate PSNR of fahpf  
    eval(['psnr_tvwa5' num2str(i) '= tmp1(i,11)']);
    tmp2(i,11)=ssim(Img(:,:,:,i),tvwa5_OutImg(:,:,:,i));        % Calculate SSIM
    eval(['ssim_tvwa5' num2str(i) '= tmp2(i,11)']);
    filename = ['tvwa5' num2str(i) '.jpg'];
    imwrite(tvwa5_OutImg(:,:,:,i),filename);
end

