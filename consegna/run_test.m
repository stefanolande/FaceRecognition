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

ROCv = zeros(num_testimages,2); %inizializziamo il vettore ROCv con 0.

for n = 1:num_testimages   %Scorro ogni immagine dell'insieme di immagini di test (creato in modo random)

    filename = fullfile(test_path, test_filenames(n).name); 
    probe = double(imread(filename)); % probe conterrà l'immagine test corrente 
    
    probe_features = get_features(evectors, mean_face, probe); %data l'immagine test corrente, ricaviamo le features dell'immagine stessa
    %e richiamiamo la funzione recognize, che ci restituisce l'immagine più
    %simile trovata, la classe(soggetto) che viene riconosciuta ed infine
    %lo score ottenuto
    [match_score, match_image, recognized_class] = recognize(gallery, classes, gallery_features, probe_features); 

    true_class = str2double(test_filenames(n).name(6:7)); %recuperiamo il numero che identifica il soggetto presente nell'immagine 

    recognized = true_class == recognized_class;%se il soggetto è riconosciuto in modo giusto, allora recognized per questa immagine del test varrà true
    
    ROCv(n,1) = match_score; %salviamo lo score ottenuto nel riconoscere o meno il soggetto
    ROCv(n,2) = recognized; %salviamo se il soggetto è stato riconosciuto o meno mediante valore booleano (utile per calcolare la curva ROC)
    
end
% Richiamiamo la funzione roc passando come input il vettore contenente per
% la posizione che rappresenta una immagine del test set, lo score ottenuto
% ed un valore booleano indicante se il soggetto è stato riconosciuto o
% meno
roc(ROCv);
