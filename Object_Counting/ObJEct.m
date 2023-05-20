%object counting
clc;
clear all;
slot=16;
%%
im2=imread('img6.jpg');

im1=imread('white.jpg');
figure,imshow(im1);
figure,imshow(im2);
%%
im1g=rgb2gray(im1);
im2g=rgb2gray(im2);
figure,imshow(im1g),figure,imshow(im2g);
%%
threshold=11;
im1abs=abs(im1g);
im2abs=abs(im2g);
diff=abs(im1abs-im2abs);
figure,imshow(diff);
%%
img = imadjust(diff);
%figure,imshow(img);
thresh=graythresh(img);

%%
out = imnoise(diff,'gaussian',0,0.000005);
imshow(out);
%%
out2 = wiener2(out);
imshow(out2);
%%
out3 = imbinarize(out2);
%figure,imshow(out3);

%%
out4=imfill(out3,'holes');
figure,imshow(out4);

%%
area=1050;
blob=bwareaopen(out4,area);
blob1= bwconncomp(blob,8);
%disp(blob1);
display('Number of cars:');
display(blob1.NumObjects);
a=slot-blob1.NumObjects;
if a==0
    disp('No slots left');
else
    display('Slot left:');
    display(a);
end
%%
%if diff(:,:)>threshold
 %   im=im1;
%else
 %   im=0;
%end
%disp(im)
