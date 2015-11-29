classdef BestInsertionHeuristic < Heuristic
    % Best Insertion Heuristic subclass inheriting from class 'Heuristic'
    
    properties
    end
    
    methods
        % Constructor
    	function obj = BestInsertionHeuristic( DM )
            obj = obj@Heuristic(DM);
        end
        % Best Insertion heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
            % Extract the number of nodes
            n_total = length(obj.DM);
            % Initialize sigma, its length and not selected nodes list
            sigma = zeros(1, n_total);
            n_sigma = 0;
            not_selected = 1:n_total;
            % Select randomly the first three nodes and remove them from
            % not_selected
            for i=1:3
                random_index = randi(n_total - n_sigma);
                sigma(i) = not_selected(random_index);
                not_selected(random_index) = [];
                n_sigma = n_sigma + 1;
            end
            % While we don't have our full path
            while ~isempty(not_selected)
                % We select randomly one not already selected node and remove it
                % from not selected
                random_index = randi(n_total - n_sigma);
                node = not_selected(random_index);
                not_selected(random_index) = [];
                % Initalize the vector that will have the delta length of the
                % new path depending on where we inserted the selected node
                delta_length = zeros(1, n_sigma);
                % Begin to compute the length when inserting the new node after
                % node i
                for i=1:n_sigma
                    delta_length(i) = obj.DM(sigma(i), node) ...
                                    + obj.DM(node, sigma(mod(i,n_sigma)+1)) ...
                                    - obj.DM(sigma(i), mod(i,n_sigma)+1);
                end
                % Check at which postion we have the minimum
                [~, min_index] = min(delta_length);
                % Insert the randomly selected node at position after node
                % min_index in sigma
                sigma = [sigma(1:min_index) node sigma(min_index+1:n_sigma)];
                % Increment n_sigma
                n_sigma = n_sigma + 1;
            end
            AM = SigmaToAM(sigma);
        end
    end
end

