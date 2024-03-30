clc;           
clear;        
close all;  


di=dir('Map Set');
st={di.name};
nam=st(3:end);
len=length(nam);


TRAIN=cell(2,len);
for i=1:len
   TRAIN(1,i)={imread(['Map Set','\',cell2mat(nam(i))])};
   temp=cell2mat(nam(i));
   TRAIN(2,i)={temp(1)};
end

save('TRAININGSET.mat','TRAIN');
clear;
