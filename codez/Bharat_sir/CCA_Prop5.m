% 2017 EURASIP
% An adaptive decision based interpolation scheme for the removal of high density salt and pepper noise in images

function [CC_total,NP] = CCA_Prop5(nImg)

pad = 5; mfw = 3;
[row, col] = size(nImg); % Size calculation
imgZP = zeros(row+2*pad, col+2*pad); % Zero padding
OutImg = nImg;
imgZP(pad+1:row+pad, pad+1:col+pad) = nImg; %Zero padded image
rng = (mfw - 1) / 2;
flg = zeros(row, col);
CC_total=0;NP=0;
for i = pad + 1: row + pad
    for j = pad + 1: col + pad
        if ((imgZP(i, j) == 0) || (imgZP(i, j) == 255))
            flg(i - pad, j - pad) = 1;
            NP=NP+1;
        else
            flg(i - pad, j - pad) = 0;
        end
    end
end
Pw=zeros(13,12);count=0;count2=0;
pixel= 128;
% CmpVect=[4,4,4,8,4,4,8,8,4,8,4,8,10,8,8,4,8,8,4];
% comp=0;
% Nop=0;
% tic

for i = 1 + pad: row + pad
    for j = 1 + pad:col + pad
        if (flg(i-pad, j-pad) == 0)
            pixel = imgZP(i, j);
            CC=0;
        else
            Nw= imgZP(i-5:i+5, j-5:j+5);
            Dw(1:19,1)= [1, 2, 4, 5, 8, 9, 10, 13, 16, 17, 18, 20, 25, 26, 29, 32, 34, 41, 50];
            Pw(1,1:4)= [Nw(5,6),Nw(6,5),Nw(6,7),Nw(7,6)];
            Pw(2,1:4)= [Nw(5,5),Nw(5,7),Nw(7,5),Nw(7,7)];
            Pw(3,1:4)= [Nw(4,6),Nw(6,4),Nw(6,8),Nw(8,6)];
            Pw(4,1:8)= [Nw(4,5),Nw(4,7),Nw(5,4),Nw(5,8),Nw(7,4),Nw(7,8),Nw(8,5),Nw(8,7)];
            Pw(5,1:4)= [Nw(4,4),Nw(4,8),Nw(8,4),Nw(8,8)];          
            Pw(6,1:4)= [Nw(3,6),Nw(6,3),Nw(6,9),Nw(9,6)];
            Pw(7,1:8)= [Nw(3,5),Nw(3,7),Nw(5,3),Nw(5,9),Nw(7,3),Nw(7,9),Nw(9,5),Nw(9,7)];
            Pw(8,1:8)= [Nw(3,4),Nw(3,8),Nw(4,3),Nw(4,9),Nw(8,3),Nw(8,9),Nw(9,4),Nw(9,8)];
            Pw(9,1:4)= [Nw(2,6),Nw(6,2),Nw(6,10),Nw(10,6)];
            Pw(10,1:8)= [Nw(2,5),Nw(2,7),Nw(5,2),Nw(5,10),Nw(7,2),Nw(7,10),Nw(10,5),Nw(10,7)];
            Pw(11,1:4)= [Nw(3,3),Nw(3,9),Nw(9,3),Nw(9,9)];
            Pw(12,1:8)= [Nw(2,4),Nw(2,8),Nw(4,2),Nw(4,10),Nw(8,2),Nw(8,10),Nw(10,4),Nw(10,8)];
            Pw(13,1:12)= [Nw(1,6),Nw(2,3),Nw(2,9),Nw(3,2),Nw(3,10),Nw(6,1),Nw(6,11),Nw(9,2),Nw(9,10),Nw(10,3),Nw(10,9),Nw(11,6)];            
            Pw(14,1:8)= [Nw(1,5),Nw(1,7),Nw(5,1),Nw(5,11),Nw(7,1),Nw(7,11),Nw(11,5),Nw(11,7)];
            Pw(15,1:8)= [Nw(1,4),Nw(1,8),Nw(4,1),Nw(4,11),Nw(8,1),Nw(8,11),Nw(11,4),Nw(11,8)];
            Pw(16,1:4)= [Nw(2,2),Nw(2,10),Nw(10,2),Nw(10,10)];
            Pw(17,1:8)= [Nw(1,3),Nw(1,9),Nw(3,1),Nw(3,11),Nw(9,1),Nw(9,11),Nw(11,3),Nw(11,9)];
            Pw(18,1:8)= [Nw(1,2),Nw(1,10),Nw(2,1),Nw(2,11),Nw(10,1),Nw(10,11),Nw(11,2),Nw(11,10)];
            Pw(19,1:4)= [Nw(1,1),Nw(1,11),Nw(11,1),Nw(11,11)];
            
            NE=0; Wf=0; g=0;CC=0;
            for c=1: 19
                tmp1 = Pw(c,:);
                tmp = tmp1;
                tmp(tmp==0)=[];  tmp(tmp==255)=[];
                if(length(tmp) ~= 0)
%                     comp=comp+CmpVect(c);
                    sp = sum(tmp)/length(tmp);
                    Wf = Wf+(1/Dw(c));
                    NE = NE+length(tmp);
%                     Nop= Nop+length(tmp);
                    CC=CC+length(tmp);
                else
                    sp = 0;
                end
                g= g+sp*(1/Dw(c));
                if(NE>1)% apply different variation in number of pixel
                    % at ND>95 very less number must be taken otherwise
                    % perfromance will reduce.
                    pixel= g/Wf;
                    break;
                end
            end
        end
        CC_total=CC_total+CC;
    OutImg(i - pad, j - pad) = uint8(pixel);    
    end
end
% toc

end
