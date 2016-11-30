clear;
close all;

m = imread('yaleB39_P00A-130E+20.pgm');
%m = imread('yaleB39_P00A-020E-10.pgm');
imshow(m);

y = mat2gray(localnormalize(double(m), 20, 25));
figure,imshow(y);title('normalization');