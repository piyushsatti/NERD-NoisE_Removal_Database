function IEF = IEF(Img,nImg,rImg)
   tmp1= double(Img);
   tmp2= double(nImg);
   tmp3= double(rImg);
   tmp4= (tmp2-tmp1);
   tmp5= (tmp3-tmp1);
   IEF= sum(sum(tmp4.^2))/sum(sum(tmp5.^2));
end