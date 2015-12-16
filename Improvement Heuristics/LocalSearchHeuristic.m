classdef LocalSearchHeuristic < Heuristic
    % Greedy Local Search Heuristic subclass inheriting from class 'Heuristic'
    
    properties
        n_moves
    end
    
    methods
        % Constructor
        function obj = LocalSearchHeuristic( nodes )
            obj = obj@Heuristic(nodes);
            obj.n_moves = 10 * nodes.n_total^2;
        end
        % Local Search heuristic applied on a Distance Matrix
        function sigma = findShortestPath( obj )
            % Generate a random permutation sigma
            sigma = randperm(obj.nodes.n_total);
            % During n_moves tours generate a neighbour using a small move
            for i=1:obj.n_moves
                [sigma_new, delta] = obj.smallMove(sigma, obj.move_type);
                % If the difference is negative or null, replace sigma with
                % sigma_new
                if delta <= 0
                    sigma = sigma_new;
                end
            end
        end
    end
end

