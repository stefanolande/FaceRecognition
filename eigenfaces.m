clear;
input_dir = 'dataset2/training/processed/';
image_dims = [192, 168];

%Questa � la sogllia migliore ricavata mediante compromesso tra da FP e FN
soglia = 0.00172; 

filenames = dir(fullfile(input_dir, '*.pgm'));
num_images = numel(filenames);

%leggi la prima immagine per ottenere le dimensioni
filename = fullfile(input_dir, filenames(1).name);
img = imread(filename);
dim = size(img(:));

images = zeros(dim(1), num_images);

% Mettiamo ogni immagine in una riga della matrice
for n = 1:num_images
    filename = fullfile(input_dir, filenames(n).name);
    img = imread(filename);
    images(:, n) = img(:);
end
fprintf('Lettura immagini completata\n');


% step 1 and 2: trova la faccia media e sottraila ad ogni immagine
mean_face = mean(images, 2);
shifted_images = images - repmat(mean_face, 1, num_images);
fprintf('step 1 2 done\n');
 
% step 3 and 4: calcola gli autovettori e gli autovalori ordinati
[evectors, score, evalues] = pca(images');
fprintf('step 3 4 done\n');
 
% step 5: teniamo solo i primi autovettori
num_eigenfaces = 20;
evectors = evectors(:, 1:num_eigenfaces);
fprintf('step 5 done\n');
 
% step 6: calcola le feature di ogni faccia proiettandole sugli autovettori
features = evectors' * shifted_images;
fprintf('step 6 done\n');

name = 'E la, il primo ciclo lo fai per forza';
while(strcmp(name, 'esci')==0)    
   
    [filename] = imgetfile(); %Scelta dell'immagine da gui
    
    %calcola la similarit� dell'immagine in input con ogni immagine nel
    %training set
    input_image = double(imread(filename));
    [pathstr_notUsed,current_name] = fileparts(filename);
    fprintf('Immagine scelta: %s \n',current_name);
    feature_vec = evectors' * (input_image(:) - mean_face);
    similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);

    %trova l'immagine con la similarit� pi� alta
    [match_score, match_ix] = max(similarity_score);

    %mostra il risultato
    figure, imshow([mat2gray(input_image) mat2gray(reshape(images(:,match_ix), image_dims))]);
    if(match_score>soglia)
        %se la similarit� � pi� alta della soglia accettiamo il riconoscimento
        title(sprintf('matches %s, score %f', filenames(match_ix).name, match_score));
        xlabel('Accepted');
    else
        title(sprintf('closest %s, score %f', filenames(match_ix).name, match_score));
        xlabel('Rejected');
    end
    
    name = input('Se vuoi uscire inserisci esci, altrimenti premi invio: ', 's');

end
fprintf('\nRiconoscimento facciale terminato!\n\n');