function [gallery, mean_face, evectors,  gallery_features] = training()
%TRAINING Summary of this function goes here
%   Detailed explanation goes here

input_dir = 'dataset1/training/processed/';
dim = [192, 168];

%salva le immagini nelle colonne della matrice gallery
gallery = zeros(dim(1), num_images);

for n = 1:num_images
    filename = fullfile(input_dir, filenames(n).name);
    img = imread(filename);
    gallery(:, n) = img(:);
end
fprintf('Lettura immagini completata\n');

% step 1 and 2: trova la faccia media e sottraila ad ogni immagine
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

