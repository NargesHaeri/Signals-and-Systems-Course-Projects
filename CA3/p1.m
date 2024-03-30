img=imread('hello.jpg');
img=rgb2gray(img);
subplot(1,2,1);
imshow(img)
title('original image')
Alphabet='abcdefghijklmnopqrstuvwxyz .,!";';

num_alphabet=length(Alphabet);
mapset=cell(2,num_alphabet);
for i=1:num_alphabet
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end

msg='signal;';

coded_img=coding(msg,img,mapset);
subplot(1,2,2);
imshow(coded_img);
title('coded image')

fprintf("decoded msg is: %s",decoding(coded_img,mapset))