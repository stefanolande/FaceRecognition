% Questa funzione riceve in ingresso una immagine (probe), la media delle
% facce di gallery e gli autovettori di gallery. 
% Restituisce al chiamante le features dell'image probe.
function [ probe_features ] = get_features( evectors, mean_face, probe )
    probe_features = evectors' * (probe(:) - mean_face); %calcola òle features dell'immagine probe
end

