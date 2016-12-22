function [ gallery, classes, image_size ] = read_gallery( path )
%READ_GALLERY Summary of this function goes here
%   Detailed explanation goes here

filenames = dir(fullfile(path, '*.pgm'));
num_images = numel(filenames);

%leggi la prima immagine per ottenere le dimensioni
filename = fullfile(path, filenames(1).name);
img = imread(filename);
dim = size(img(:));

image_size = size(img);

gallery = zeros(dim(1), num_images);
classes = zeros(num_images, 1);

fprintf('Inizio caricamento immagini\n');

% Mettiamo ogni immagine in una riga della matrice
for n = 1:num_images
    filename = fullfile(path, filenames(n).name);
    img = imread(filename);
    gallery(:, n) = img(:);
    classes(n) = str2double(filenames(n).name(6:7));
end

fprintf('Caricamento immagini completata\n');

end

