classdef LocalSearchHeuristic < Heuristic
    % Greedy Local Search Heuristic subclass inheriting from class 'Heuristic'
    
    properties
        n_moves
        l_values
    end
    
    methods
        % Constructor
        function obj = LocalSearchHeuristic( nodes )
            obj = obj@Heuristic(nodes);
            obj.n_moves = 10 * nodes.n_total^2;
        end
        % Rewrite the runTests method to initialize because of 'l_values'
        % computation
        function runTests( obj )
            % Initialize l_values
            obj.l_values = zeros(obj.n_moves, obj.nb_it);
            % Run the method 'nb_it' times
            for i=1:obj.nb_it
                % Get the solution returned by the method 'findShortestPath'
                % and insert it in the 'solutions' structure. Each solution
                % is a sigma permutation.
                obj.solutions(i).sigma = obj.findShortestPath(i);
                % Get the length of the path based on sigma and the DM.
                obj.solutions(i).length = obj.sigmaLength(obj.solutions(i).sigma);
            end
            %disp([class(obj), ': ', num2str(obj.solutions(1).length)])
        end
        % Local Search heuristic applied on a Distance Matrix
        function sigma = findShortestPath( obj, iteration )
            % Generate a random permutation sigma and compute the length
            sigma = randperm(obj.nodes.n_total);
            l_sigma = obj.sigmaLength(sigma);
            % During n_moves tours generate a neighbour using a small move
            for i=1:obj.n_moves
                [sigma_new, delta] = obj.smallMove(sigma, obj.move_type);
                % If the difference is negative or null, replace sigma with
                % sigma_new, compute the length
                if delta <= 0
                    sigma = sigma_new;
                    l_sigma = l_sigma + delta;
                end
                % Add the length of sigma to l_values
                obj.l_values(i, iteration) = l_sigma;
            end
        end
        % Get the plot of the l_values (min, max, mean) vs curr_moves
        function currMovesPlot(obj, plot_title)
            % Compute the min value for each line of l_values
            l_min = min(obj.l_values, [], 2);
            % Compute the max value for each line of l_values
            l_max = max(obj.l_values, [], 2);
            % Compute the mean for each line of l_values
            l_mean = mean(obj.l_values, 2);
            % Plot the graph with logarithmic scale
            figure('Position', [100, 100, 1049, 895]);
            loglog(1:obj.n_moves, l_min, 'r', ...
                 1:obj.n_moves, l_max, 'g', ...
                 1:obj.n_moves, l_mean, 'b');
            title(strcat(plot_title, 'CurrMoves'));
            xlabel('number of moves');
            ylabel('L(\theta)');
            legend('min', 'max', 'mean');
        end
    end
end

