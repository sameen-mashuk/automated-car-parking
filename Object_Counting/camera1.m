function y=camera1()

slot=8;
%%
im2=imread('cam1.jpg');
im2=imcrop(im2,[185 103 3278 1633]);
im2=imresize(im2,[280 339]);
im1=imread('white.jpg');
%figure,imshow(im1);
%figure,imshow(im2);
%%
im1g=rgb2gray(im1);
im2g=rgb2gray(im2);
figure,imshow(im1g),figure,imshow(im2g);
%%
im1abs=abs(im1g);
im2abs=abs(im2g);
diff=abs(im1abs-im2abs);
%figure,imshow(diff);
%%
img = imadjust(diff);
%figure,imshow(img);
thresh=graythresh(img);

%%
out = imnoise(diff,'gaussian',0,0.000005);
%imshow(out);
%%
out2 = wiener2(out);
%imshow(out2);
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
fprintf('Number of cars in block A: %d \n',blob1.NumObjects);
a=slot-blob1.NumObjects;
if a==0
    disp('No slots left in block A ');
else
    fprintf('Slots left in Block A (1-8): %d \n',a);
end
y=slot-a;
end