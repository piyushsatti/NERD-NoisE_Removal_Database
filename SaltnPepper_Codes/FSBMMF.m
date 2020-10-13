% Fast switching based median–mean filter for high density saltand pepper noise removal

function OutImg = FSBMMF(nImg)

[row, col] = size(nImg);
pad = 2;
imgZP = padarray(nImg,[pad, pad]);

window_size = 3; 
rng=(window_size-1)/2;

for i = 1+pad:row+pad
    for j= 1+pad:col+pad
        if (imgZP(i,j)==0)||(imgZP(i,j)==255)
            OutImg(i-pad,j-pad) = median(reshape(imgZP(i-rng:i+rng,j-rng:j+rng),1,[]));
            if (OutImg(i-pad,j-pad)==0)||(OutImg(i-pad,j-pad)==255) %write code to compute noisy pixel
                if (((i==1+pad)&&(j==1+pad))||((i==1+pad)&&(j==col+pad))||((i==row+pad)&&(j==1+pad))||((i==row+pad)&&(j==col+pad)))
                    temp= imgZP(i-2*rng:i+2*rng,j-2*rng:j+2*rng);
                    temp(temp==0)=[];temp(temp==255)=[];
                    OutImg(i-pad,j-pad) = median(temp);
                elseif((i==3)||(i==row+2))
                    OutImg(i-pad,j-pad) = OutImg(i-2,j-3); % previous processed signal 
                elseif((j==3)||(j==col+2))
                    OutImg(i-pad,j-pad) = OutImg(i-3,j-2); % previous processed signal
                else
                    OutImg(i-pad,j-pad) = (double(OutImg(i-2,j-3))+double(OutImg(i-3,j-2))+double(OutImg(i-3,j-3))+double(OutImg(i-3,j-1)))/4;
                end
            end
        else
            OutImg(i-pad,j-pad) = imgZP(i,j);
        end
    end
end

end