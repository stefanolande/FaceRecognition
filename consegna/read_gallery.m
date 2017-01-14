%Questa funzione riceve in ingresso il path in cui sono presenti le
%immagini, e restituisce una matrice contenente ogni immagine presente
%posta una per colonna. Restituisce in'oltre la dimensione delle immagini
%(192*168) ed infine l'identificativo (classe) del soggetto di ogni immagine
function [ gallery, classes, image_size ] = read_gallery( path )


filenames = dir(fullfile(path, '*.pgm'));%prendiamo il percorso completo
num_images = numel(filenames);%calcoliamo il numero di immagini presenti

%leggi la prima immagine per ottenere le dimensioni
filename = fullfile(path, filenames(1).name);
img = imread(filename);%leggiamo l'immagine (la prima)
dim = size(img(:));

image_size = size(img);%img size contiene la dimensione dell'immagine (tutte a 192*168)

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

