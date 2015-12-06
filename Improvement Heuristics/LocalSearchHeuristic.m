classdef LocalSearchHeuristic < Heuristic
    % Greedy Local Search Heuristic subclass inheriting from class 'Heuristic'
    
    properties
        n_moves
    end
    
    methods
        % Constructor
        function obj = LocalSearchHeuristic( DM )
            obj = obj@Heuristic(DM);
            % Initialize n_moves
            obj.n_moves = 10 * obj.n_total^2;
        end
        % Local Search heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
            % Generate a random permutation sigma
            sigma = randperm(obj.n_total);
            % During n_moves tours generate a neighbour using a small move
            for i=1:obj.n_moves
                [sigma_new, delta] = obj.smallMove(sigma, obj.move_type);
                % If the difference is negative or null, replace sigma with
                % sigma_new
                if delta <= 0
                    sigma = sigma_new;
                end
            end
            % Generate an Adjacency Matrix with sigma
            AM = SigmaToAM(sigma);
        end
    end
end

