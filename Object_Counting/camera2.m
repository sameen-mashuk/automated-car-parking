function y=camera2()

slot=8;
%%
im2=imread('cam2.jpg');
im2=imcrop(im2,[953 97 4091 2272]);
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
fprintf('Number of cars in block B: %d \n',blob1.NumObjects);
a=slot-blob1.NumObjects;
if a==0
    disp('No slots left in block B ');
else
    fprintf('Slots left in block B (9-16): %d \n',a);
end
y=slot-a;
end
