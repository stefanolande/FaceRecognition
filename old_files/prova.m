clear;
close all;

%m = imread('training/yaleB39_P00A-130E+20.pgm');
%m = imread('yaleB39_P00A-020E-10.pgm');
m = imread('test/yaleB39_P00A-110E-20.pgm');
imshow(m);

y = localnormalize(m, 20, 25);
figure,imshow(y);title('normalization');