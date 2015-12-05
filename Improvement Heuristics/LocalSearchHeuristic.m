classdef LocalSearchHeuristic < Heuristic
    % Greedy Local Search Heuristic subclass inheriting from class 'Heuristic'

    properties
    end
    
    methods
        % Constructor
    	function obj = LocalSearchHeuristic( DM )
            obj = obj@Heuristic(DM);
        end
        % Local Search heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
            % Initialize n_moves
            n_moves = 10 * obj.n_total;
            % Generate a random permutation sigma
            sigma = randperm(obj.n_total);
            % During n_moves tours generate a neighbour using a small move
            for i=1:n_moves
                [sigma_bis, delta] = obj.smallMove(sigma, obj.move_type);
                % If the difference is negative or null, replace sigma with
                % sigma_bis
                if delta <= 0
                   sigma = sigma_bis;
                end
            end
            % Generate an Adjacency Matrix with sigma
            AM = SigmaToAM(sigma);
        end
    end
    
end

