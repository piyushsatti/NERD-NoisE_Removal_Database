% takes input as noisy image
function OutImg = PDBF(nImg);
    [row , col] = size(nImg);
    % Variable to Count number of Noisy Pixels
    noisy_pixel_count = 0;
    for i=1:row
        for j=1:col
            if (nImg(i,j) == 0) || (nImg(i,j) == 255)
                noisy_pixel_count = noisy_pixel_count + 1;
                b_f(i,j) = 0;
            else
                b_f(i,j) = 1;
            end
        end
    end
    
    % Noise Density as ratio of suspected corrupted pixels by total pixels
    noise_density = noisy_pixel_count ./ (row * col);
    
    % Initial Noise Density-Dependent Fcuntion for Noise Removal below a
    % certain threshold
    imgZP= zeros(row+4,col+4);  % Zero padding
    %     pix= zeros(9,1);    % Pixels without noise
    %     pixN= zeros(9,1);   % Noisy pixel
    imgZP(3:row+2,3:col+2)= nImg; %Zero padded image
    lpp = 254/2;
    %rng = 1;% for this case
    if (noise_density < 0.5)
        for i = 3 : row+2
            for j = 3 : col+2
                if(imgZP(i,j)==0||imgZP(i,j)==255)
                    tmp = imgZP(i-1:i+1,j-1:j+1);
                    tmp(tmp==0) = [];tmp(tmp==255) = [];
                    pixel= median(tmp,"all");
                    if(pixel~=0&&pixel~=255)
                        imgZP(i,j)= uint8(pixel);
                    else
                        imgZP(i,j)= lpp;
                    end
                end
                lpp = imgZP(i,j);
            end
        end
    else
        wm = 2; %maximum half window size
        for i = 3 : row+2
            for j = 3 : col+2
                w = 1;
                while(w<=wm)
                    if(imgZP(i,j)==0||imgZP(i,j)==255) % if pixel is noisy calculating the possible value of pixel
                        tmp = imgZP(i-w:i+w,j-w:j+w);
                        tmp_sort = sort(tmp,2); %sorting row wise
                        tmp_sort = sort(tmp_sort); % sorting column wise
                        if(tmp_sort(w,w)~=255&&tmp_sort(w,w)~=0) % if PM is noisefree we replace the value of pixel
                            imgZP(i,j) = tmp_sort(w,w); break;
                        else
                            tmp(tmp==0) = []; tmp(tmp==255) = [];
                            
                            if (size(tmp)~=0)
                                imgZP(i,j) = median(tmp,"all"); break; %else we go TM
                            else
                                w = w+1;
                                if(w>wm)
                                    imgZP(i,j) = lpp;
                                    break;
                                end
                            end
                        end
                    else
                        break;
                    end
                    
                end
                lpp = imgZP(i,j);
            end
        end
        imgZP = MF3x3(imgZP);
    end
    OutImg = imgZP(3:row+2,3:col+2);
end


% 3x3 mean filter 

function img = MF3x3(nImg)
    [row , col] = size(nImg);
    for i = 2 : row-2
        for j = 2 : col-2
            tmp2 = nImg(i-1:i+1 , j-1:j+1);
            nImg(i,j) = mean(tmp2,"all");
        end
    end
    img = nImg;
end