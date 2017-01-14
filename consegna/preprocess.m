% Questa funzione si occupa di eseguire del preprocessing sull'immagine X,
% in modo tale da rendere uniformi tutte le immagini e cercando di
% eliminare i vari rumori, mediante l'utilizzo della funzione di normalizzazione per trasformata discreta del coseno.
% Questa funzione riceve in ingresso una immagine X e restituisce una
% immagine "img" processata come sopra descritto.
function img=preprocess(X)
    img = DCT_normalization(X); %richiamiamo la funzione DTC_normalization presente nella cartella "libs"
end