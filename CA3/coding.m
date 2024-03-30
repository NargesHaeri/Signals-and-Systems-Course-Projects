function coded_img=coding(msg,img,mapset)
index=[];
for i=1:length(msg)
    ch=msg(i);
    index=[index, find(strcmp(ch,mapset(1,:))==1)];
end
binary_msg=cell2mat(mapset(2,index));
coded_img=img;
for i=1:length(binary_msg)
    num=dec2bin(img(i),8);
    num(8)=binary_msg(i);
    coded_img(i)=bin2dec(num);
end
end