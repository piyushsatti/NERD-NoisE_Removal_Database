function MAE = MAE(Img,nImg)
   tmp1= double(Img);
   tmp2= double(nImg);
   tmp= abs(tmp1-tmp2);
   [r c]= size(tmp);
   MAE= sum(sum(tmp))/(r*c);
end