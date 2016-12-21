function Y=preprocess(X)

img = DCT_normalization(X);
%Y = mat2gray(img);
Y = img;
end