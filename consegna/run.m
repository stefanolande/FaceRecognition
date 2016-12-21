clear;

addpath libs;

path = '../dataset1/training/processed/';

soglia = 0.00049; 

[gallery, classes, image_size] = read_gallery(path);

[mean_face, evectors,  gallery_features] = training(gallery);


name = '';
while(strcmp(name, 'esci')==0)    
   
    [filename] = imgetfile(); %Scelta dell'immagine da gui
    
    %calcola la similarita' dell'immagine in input con ogni immagine nel
    %training set
    probe = imread(filename);
    probe = preprocess(probe);
    [pathstr_notUsed,current_name] = fileparts(filename);
    fprintf('Immagine scelta: %s \n',current_name);
    
    true_class = str2double(current_name(6:7));
    
    probe_features = get_features(evectors, mean_face, probe);
    [match_score, match_image, recognized_class] = recognize(gallery, classes, gallery_features, probe_features);    
        
    %mostra il risultato
    figure;
    subplot(1,2,1); imshow(mat2gray(probe));
    title(sprintf('Probe: subject %d', true_class));
    
    subplot(1,2,2); imshow(mat2gray(reshape(match_image, image_size)));
    title(sprintf('Closest: subject %d', recognized_class));
    
    if(match_score>soglia)
        %se la similarita' e' piu' alta della soglia accettiamo il riconoscimento
        suptitle(sprintf('Accepted, score %f', match_score));
    else
        suptitle(sprintf('Rejected, score %f', match_score));
    end
    
    name = input('Se vuoi uscire inserisci esci, altrimenti premi invio: ', 's');

end
fprintf('\nRiconoscimento facciale terminato!\n\n');