% Questa funzione si occupa di eseguire del preprocessing sull'immagine X,
% in modo tale da rendere uniformi tutte le immagini e cercando di
% eliminare i vari rumori.

function img=preprocess(X)
    img = DCT_normalization(X); %richiamiamo la funzione DTC_normalization presente nella cartella "libs"
end