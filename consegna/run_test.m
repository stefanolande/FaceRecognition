clear;

% Aggiungiamo il path relativo alle librerie che utilizzaziamo
addpath libs;

% Path realtivo della cartella in cui sono presenti le immagini dei
% soggetti gia processati
train_path = '../dataset1/training/processed/';
test_path = '../dataset1/test/processed';

% Richiamiamo il metodo esterno read_gallery() che si occupa di leggere
% tutte le immagini presenti nel path passato in ingresso alla funzione.
% La funzione read_gallery restituisce una matrice gallery contenente tutte
% le immagine poste in colonna, una matrice classes che contiene gli
% identificatori dei soggetti (permette di sapere che soggetto si tratta nella gallery)
% ed infine la dimensione delle immagini
[gallery, classes, image_size] = read_gallery(train_path);

% Richiamiamo il metodo esterno training passando come parametro la gallery
% contenente tutte le immagini, questa ci restituisce la faccia media, gli
% autovettori ed infine le feature della gallery
[mean_face, evectors,  gallery_features] = training(gallery);


%genera la curva roc
test_filenames = dir(fullfile(test_path, '*.pgm'));
num_testimages = numel(test_filenames);

ROCv = zeros(num_testimages,2);

for n = 1:num_testimages   

    filename = fullfile(test_path, test_filenames(n).name);
    probe = double(imread(filename));
    
    probe_features = get_features(evectors, mean_face, probe);
    [match_score, match_image, recognized_class] = recognize(gallery, classes, gallery_features, probe_features);

    true_class = str2double(test_filenames(n).name(6:7));

    recognized = true_class == recognized_class;
    
    ROCv(n,1) = match_score;
    ROCv(n,2) = recognized;
    
end

roc(ROCv);
