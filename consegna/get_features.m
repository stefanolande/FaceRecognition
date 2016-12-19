function [ probe_features ] = get_features( evectors, mean_face, probe )
%GET_FEATURES Summary of this function goes here
%   Detailed explanation goes here

probe_features = evectors' * (probe(:) - mean_face);

end

