clc
close all;
clear;
tic;
%% Selecting the test data

[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
figure
subplot(1,4,1)
imshow(picture)
picture=imresize(picture,[300 500]);
subplot(1,4,2)
imshow(picture)

%% RGB2GRAY

picture=mygrayfunc(picture);
subplot(1,4,3)
imshow(picture)

%% Thresholding and Conversion to a binary image

picture=mybinaryfunc(picture,80);
subplot(1,4,4)
imshow(picture)

%% Removing the small objects and background

figure
picture = myremovecom(picture,550);
subplot(1,3,1)
imshow(picture)
background=myremovecom(picture,3000);
subplot(1,3,2)
imshow(background)
picture2=picture-background;
subplot(1,3,3)
imshow(picture2)

%% Labeling connected components

figure
[L,Ne]=mysegmentation(picture2);
subplot(1,2,1)
imshow(picture2)

propied=regionprops(L,'BoundingBox');
hold on
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

%% Decision making

 
% Loading the mapset
load TRAININGSET;
totalLetters=size(TRAIN,2);

final_output=[];
t=[];
for n=1:Ne
    [r,c]=find(L==n);
    Y=picture2(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[42,24]);
    pause(0.2)
    
    
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAIN{1,k},Y);
    end

    [MAXRO,pos]=max(ro);
    if MAXRO>.30
        out=cell2mat(TRAIN(2,pos));       
        final_output=[final_output out];
    end
end

%% Printing the plate

file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',flip(final_output));
fclose(file);
winopen('number_Plate.txt')





