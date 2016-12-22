clear;

% Aggiungiamo il path relativo alle librerie che utilizzaziamo
addpath libs;

% Path realtivo della cartella in cui sono presenti le immagini dei
% soggetti gia processati
path = '../dataset1/training/processed/';

% Valore soglia scelto, al di sotto della quale il soggetto viene rifiutato 
soglia = 0.00049; 

% Richiamiamo il metodo esterno read_gallery() che si occupa di leggere
% tutte le immagini presenti nel path passato in ingresso alla funzione.
% La funzione read_gallery restituisce una matrice gallery contenente tutte
% le immagine poste in colonna, una matrice classes che contiene gli
% identificatori dei soggetti (permette di sapere che soggetto si tratta nella gallery)
% ed infine la dimensione delle immagini
[gallery, classes, image_size] = read_gallery(path);

% Richiamiamo il metodo esterno training passando come parametro la gallery
% contenente tutte le immagini, questa ci restituisce la faccia media, gli
% autovettori ed infine le feature della gallery
[mean_face, evectors,  gallery_features] = training(gallery);

% La stringa flag verrà usata per ver verificare se l'utente vuole
% continuare ad utilizzare il programma o meno
flag = '';
while(strcmp(flag, 'esci')==0)    
   
    [filename] = imgetfile(); %Scelta dell'immagine da GUI
    
    %calcola la similarita' dell'immagine in input con ogni immagine nel
    %training set
    probe = imread(filename);
    probe = preprocess(probe); %viene eseguito il preprocessing sull'immagine scelta dall'utente
    [pathstr_notUsed,current_name] = fileparts(filename); %viene estratto il node del soggetto scelto dall'untete
    fprintf('Immagine scelta: %s \n',current_name);% e viene stampato a video
    
    true_class = str2double(current_name(6:7)); % questa variabile conterrà il nome del soggetto scelto dall'utente
    
    probe_features = get_features(evectors, mean_face, probe);
    [match_score, match_image, recognized_class] = recognize(gallery, classes, gallery_features, probe_features);    
        
    %mostra il risultato
    figure;
    subplot(1,2,1); imshow(mat2gray(probe)); %Mostra l'iimagine scelta dall'utente
    title(sprintf('Probe: subject %d', true_class));
    
    subplot(1,2,2); imshow(mat2gray(reshape(match_image, image_size))); % Mostra l'immagine più simile
    title(sprintf('Closest: subject %d', recognized_class));
    
    % Se l'immagine più simile trovata ha un valore (match_score) maggiore
    % della soglia scelta, allora il soggetto viene accettato. Altrimenti
    % no
    if(match_score>soglia) 
        %se la similarita' e' piu' alta della soglia accettiamo il riconoscimento
        suptitle(sprintf('Accepted, score %f', match_score));
    else
        suptitle(sprintf('Rejected, score %f', match_score));
    end
    
    flag = input('Se vuoi uscire inserisci esci, altrimenti premi invio: ', 's');

end
fprintf('\nRiconoscimento facciale terminato!\n\n');