% Aggiungi descrizione_ ToDo
function [ probe_features ] = get_features( evectors, mean_face, probe )
    probe_features = evectors' * (probe(:) - mean_face);
end

