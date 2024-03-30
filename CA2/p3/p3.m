clc
close all;
clear;

%% Selecting the test data

[file, path] = uigetfile('*.jpg;*.png;*.jpeg;*.bmp');
s=[path,file];
picture=imread(s);
figure
subplot(1,3,1)
imshow(picture)
width = 600;
length = 800;
picture = imresize(picture, [width, length]);

%% RGB2GRAY

picture = rgb2gray(picture);
subplot(1,3,2)
imshow(picture)

%% Thresholding and Conversion to a binary image

threshold =  graythresh(picture);
picture = ~imbinarize(picture, threshold-0.1);
subplot(1,3,3)
imshow(picture)

%% Removing the small objects and background

figure
picture = bwareaopen(picture,80); 
subplot(1,3,1)
imshow(picture)
background=bwareaopen(picture,1670);
subplot(1,3,2)
imshow(background)
picture=picture-background;
subplot(1,3,3)
imshow(picture)

%% Extract the license plate region

y_down = width - 100;
y_top = 100;

x_right = length - 100;
x_left = 100;

colChangeLimit = 0;
colMaxChanges = 1;
colsChangesCount = zeros(1, length);

for j=1: length
    ChangesCount = 0;
    for i=1: width - 1
        if picture(i + 1, j) ~= picture(i, j)
            ChangesCount = ChangesCount + 1;
        end
    end
    colsChangesCount(i) = ChangesCount;
    if ChangesCount > colChangeLimit && j > 300 && j < 400
        colChangeLimit = ChangesCount;
        colMaxChanges = j;
    end
end

for j=220: colMaxChanges
    if abs(colChangeLimit - colsChangesCount(j)) < 30 && colMaxChanges - j < 230
        x_left = j;
        break;
    end
end

for j=length - 200:-1: colMaxChanges
    if abs(colChangeLimit - colsChangesCount(j)) < 30 && j - colMaxChanges < 300
        x_right = j;
        break;
    end
end

RowChangeLimit = 0;
rowMaxChanges = 1;
rowsChangesCount = zeros(1, width);

for i=1: width
    ChangesCount = 0;
    for j=1: length - 1
        if picture(i, j + 1) ~= picture(i, j)
            ChangesCount = ChangesCount + 1;
        end
    end
    rowsChangesCount(i) = ChangesCount;
    if ChangesCount > RowChangeLimit && i > 340 && i < 500
        RowChangeLimit = ChangesCount;
        rowMaxChanges = i;
    end
end

for i=100: rowMaxChanges
    if abs(RowChangeLimit - rowsChangesCount(i)) < 20 && rowMaxChanges - i < 50
        y_top = i;
        break;
    end
end    

for i=width - 100:-1: rowMaxChanges
    if abs(RowChangeLimit - rowsChangesCount(i)) < 20 && i - rowMaxChanges < 50
        y_down = i;
        break;
    end
end

yChange = y_down - y_top;

if yChange < 60
    y_down = y_down + 80 - yChange;
end

plate = picture(y_top:y_down,x_left:x_right);



%% Labeling connected components

imshow(plate);

[L,Ne] = bwlabel(plate);
propied = regionprops(L,'BoundingBox');
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
figure
plate = bwareaopen(plate, 110);
imshow(plate);

%% Decision Making

 
% Loading the mapset
load TRAININGSET;
totalLetters=size(TRAIN,2);


final_output=[];
t=[];
for n=1:Ne
    [r,c]=find(L==n);
    Y=plate(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[100,80]);
    pause(0.2)
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAIN{1,k},Y);
    end

    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=cell2mat(TRAIN(2,pos));       
        final_output=[final_output out];
    end
end

%% Printing the plate

file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('number_Plate.txt')

