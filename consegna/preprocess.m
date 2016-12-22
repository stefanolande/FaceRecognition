% Questa funzione si occupa di eseguire del preprocessing sull'immagine X,
% in modo tale da rendere uniformi tutte le immagini e cercando di
% eliminare i vari rumori.

function Y=preprocess(X)

img = DCT_normalization(X);
%Y = mat2gray(img);
Y = img;
end