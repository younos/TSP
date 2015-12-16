classdef Nodes
    % Class containing the list of nodes, the number of nodes and the 
    % distance matrix
    
    properties
        node_list
        n_total
        distance_matrix
    end
    
    methods
        % Constructor
        function obj = Nodes(nl)
            obj.node_list = nl;
            obj.n_total = length(nl);
            % Compute the distance matrix
            obj.distance_matrix = squareform(pdist(nl));
        end
    end
end

