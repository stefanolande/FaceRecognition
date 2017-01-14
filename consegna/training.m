% Questa funzione riceve in ingresso la gallery (contenente le immagini) e
% ne esegue il training, restituendo al chiamante la faccia media, gli
% autovettori e le feautures della gallery

function [mean_face, evectors,  gallery_features] = training(gallery)

% Considerato che gallery è una matrice contenente le immagini per colonne
% (e quindi ogni colonna è una immagine), allora il numero di immagini
% presenti in gallery sono proprio il numero di colonne.
num_images = size(gallery, 2);

% step 1 and 2: trova la faccia media e la sottrae ad ogni immagine
mean_face = mean(gallery, 2);
shifted_images = gallery - repmat(mean_face, 1, num_images);
fprintf('step 1 2 done\n');
 
% step 3 and 4: calcola gli autovettori e gli autovalori ordinati
evectors = pca(gallery');
fprintf('step 3 4 done\n');
 
% step 5: teniamo solo i primi autovettori
num_eigenfaces = 20;
evectors = evectors(:, 1:num_eigenfaces);
fprintf('step 5 done\n');
 
% step 6: calcola le feature di ogni faccia proiettandole sugli autovettori
gallery_features = evectors' * shifted_images;
fprintf('step 6 done\n');

end