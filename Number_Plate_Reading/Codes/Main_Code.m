%No_Plate_Reading
close all;
clear all;
%%
im = imread('img/Car.JPG');
im = imresize(im, [480 NaN]);
imshow(im);
imgray = rgb2gray(im);
imshow(imgray);
imbin = imbinarize(imgray);
imshow(imbin);
im = edge(imgray, 'sobel');
imshow(im);

%%
im = imdilate(im, strel('diamond', 2));
im = imfill(im, 'holes');
im = imerode(im, strel('diamond', 10));
%figure;
imshow(im);

%%
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
image=Iprops.Image;
for i=1:count
    if maxa<Iprops(i).Area
        maxa=Iprops(i).Area;
        boundingBox=Iprops(i).BoundingBox;
    end
end

%%
im = imcrop(imbin, boundingBox);
im = imresize(im, [240 NaN]);
imshow(im)
%%
im = imopen(im, strel('rectangle', [4 4]));
im = bwareaopen(~im, 500);
figure,imshow(im);
%%
[h, w] = size(im);
%read letter
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
count = numel(Iprops);

noPlate=[];

for i=1:count
    ow = length(Iprops(i).Image(1,:));
    oh = length(Iprops(i).Image(:,1));
    if ow<(h/2) & oh>(h/3)
        letter=readLetter(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
        %figure; 
        %imshow(Iprops(i).Image);
        noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
    end
end
display('The no plate reading of the entered vehicle:');
disp(noPlate);
%sheet=1;
%xlrange = 'A1';
headers='NUMBERPLATE';
xlswrite('Number Plate.xls',[headers;{noPlate}]);
A=xlsread('Database.xlsx');
% x=2;
% y=3;
% out=A(ismember(A(:,1),[{noPlate}],'rows'),2);