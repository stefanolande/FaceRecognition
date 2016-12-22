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

% Gallery e Classes vengono inizializzati a zero
gallery = zeros(dim(1), num_images); 
classes = zeros(num_images, 1);

fprintf('Inizio caricamento immagini\n');

% Mettiamo le immagini per colonna, ogni colonna rappresenta una immagine
for n = 1:num_images
    filename = fullfile(path, filenames(n).name);
    img = imread(filename);
    gallery(:, n) = img(:); %poniamo l'immagine corrente lungo la colonna "n" corrente della gallery
    classes(n) = str2double(filenames(n).name(6:7)); %poniamo in classes(n) l'identificativo del soggetto corrente
end

fprintf('Caricamento immagini completata\n');

end

