% Questa funzione si occupa di eseguire del preprocessing sulle immagini presenti nel percorso input_dir,
% in modo tale da rendere uniformi tutte le immagini e cercando di
% eliminare i vari rumori, mediante l'utilizzo della funzione di normalizzazione per trasformata discreta del coseno.
% Questa funzione salva ogni immagine preprocessata nel percorso output_dir
clear;

addpath consegna/libs; %aggiungiamo la cartella dove sono presenti le librerie che utilizziamo

input_dir = 'dataset2/test/';
output_dir = 'dataset2/test/processed/';
image_dims = [192, 168];

filenames = dir(fullfile(input_dir, '*.pgm'));
num_images = numel(filenames);

for n = 1:num_images % eseguiamo il preprocessing su ogni immagine presente nella cartella input_dir
    fprintf('%d/%d \n', n, num_images);
    filename = fullfile(input_dir, filenames(n).name);
    img = DCT_normalization(imread(filename));%richiamiamo la funzione DTC_normalization presente nella cartella "libs"
    imwrite(mat2gray(img), fullfile(output_dir, filenames(n).name));%scriviamo l'immagine nella cartella di output
end
