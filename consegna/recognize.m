%Questa funzione riceve in ingresso la gallery (che contiene le immagini),
%le classi, che contiene il soggetto che rappresenta ogni immagine, le
%features di ogni immagine della gallery ed infine le features
%dell'immagine probe.
%Questa funzione restituisce l'immagine più simile trovata, la classe
%dell'immagine (e quindi il soggetto che è rappresentato nell'immagine
%trovata) ed infine lo score ottenuto
function [match_score, match_image, class] = recognize(gallery, classes, gallery_features, probe_features)

gallery_size = size(gallery,2); %recuperiamo il numero delle immagini presenti in gallery
similarity_scores = zeros(1, gallery_size); %inizializziamo il vettore delle similarità a 0

%calcoliamo lo score di similarità tra ogni immagine presente in gallery e l'immagine di
%probe (rappresentata mediante le sue caratteristiche)
for i = 1:gallery_size
    similarity_scores(i) = 1 / (1 + norm(gallery_features(:,i) - probe_features));
end


%trova l'indice dell'immagine con la similarita' piu' alta
[match_score, match_id] = max(similarity_scores);

%salva l'immagine con la similarità piu alta (che restituirà al chiamante)
match_image = gallery(:,match_id);

%trova la classe del soggetto presente nell'immagine più simile che abbiamo
%trovato
class = classes(match_id);

end

