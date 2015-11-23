function [ sigma ] = BestInsertion( DM )
% Best Insertion method applied on a Distance Matrix
    % Extract the number of nodes
	n = length(DM);
    % Initialize sigma and not selected nodes
    sigma = zeros(1, n);
    not_selected = 1:n;
    % Select randomly the first three nodes
    sigma(1:3) = [randi(n), randi(n), randi(n)];


end

