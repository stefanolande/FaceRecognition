function [match_score, match_image, class] = recognize(gallery, classes, gallery_features, probe_features)
%RECOGNIZE Summary of this function goes here
%   Detailed explanation goes here


gallery_size = size(gallery,2);
similarity_scores = zeros(1, gallery_size);

for i = 1:gallery_size
    similarity_scores(i) = 1 / (1 + norm(gallery_features(:,i) - probe_features));
end


%trova l'indice dell'immagine con la similarita' piu' alta
[match_score, match_id] = max(similarity_scores);

match_image = gallery(:,match_id);

class = classes(match_id);

end

