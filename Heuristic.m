classdef (Abstract) Heuristic < handle
    % Mother class Heuristic from which the subclasses will inherit the
    % 'runTests' method
    
    % Normal variables
    properties
        % Structure where the sigma permutation and the length are stored
        % for each iterations
        solutions = struct('sigma', {}, 'length', {})
        % Instance of the Nodes class
        nodes
    end
    % Constant variables (common to all instances)
    properties(Constant)
        % Number of iterations
        nb_it = 2
        % Confidence interval of 95 %
        alpha = 0.95
    end
    
    % Methods of the instances
    methods
        % Constructor
        function obj = Heuristic( nodes )
            obj.nodes = nodes;
        end
        % Apply the tests with the 'findShortestPath' method on the
        % Distance Matrix
        function runTests( obj )
            % Run the method 'nb_it' times
            for i=1:obj.nb_it
                % Get the solution returned by the method 'findShortestPath'
                % and insert it in the 'solutions' structure. Each solution
                % is a sigma permutation.
                obj.solutions(i).sigma = obj.findShortestPath();
                % Get the length of the path based on sigma and the DM.
                obj.solutions(i).length = obj.sigmaLength(obj.solutions(i).sigma);
            end
            %disp([class(obj), ': ', num2str(obj.solutions(1).length)])
        end
        % Get the statistics of the tests launched
        function stable = statisticsTable(obj)
            % Compute the mean, min and max of the solutions computed
            % and put them in a table
            average = mean([obj.solutions.length]);
            minimum = min([obj.solutions.length]);
            maximum = max([obj.solutions.length]);
            % To compute the confidence interval
            % First, compute the two t values given alpha and n
            t_values = tinv([(1-obj.alpha)/2 (1+obj.alpha)/2], obj.nb_it-1);
            % Then, the confidence interval
            confidence_interval = average ...
                + t_values * std([obj.solutions.length])/sqrt(obj.nb_it-1);
            % Add the statistics to the table
            stable = table(average, minimum, maximum, confidence_interval);
        end
        % Get the plot of the best solution
        function bestSolutionPlot(obj, plot_title)
            % Compute the index of the solution having the minimum length
            [~, i] = min([obj.solutions.length]);
            % Generate the sorted node list using sigma
            sorted_node_list = obj.nodes.node_list(obj.solutions(i).sigma, :);
            % Plot the graph using the coordinate of the node list and sigma
            figure('Position', [100, 100, 1049, 895]);
            plot(sorted_node_list(:, 2), sorted_node_list(:, 3), '-o');
            text(sorted_node_list(:, 2)+0.4, sorted_node_list(:, 3), num2str(sorted_node_list(:, 1)));
            title(strcat(plot_title, 'BestSolution'));
            xlabel('x coordinate');
            ylabel('y coordinate');
        end
        % Compute the length of the path using sigma and the distance matrix
        function l = sigmaLength(obj, sigma)
            % We just transform the vectors sigma and sigma_shift_1 into an index,
            % with sigma being the row coordinates and sigma_shift_1 being the
            % column coordinates
            index = sub2ind(size(obj.nodes.distance_matrix), sigma, circshift(sigma, [0, 1]));
            % Then, we get the elements of D using the index, and sum them
            l = sum(sum(obj.nodes.distance_matrix(index)));
        end
        % Construct the sigma permutation based on the Adjacency Matrix
        function sigma = AMToSigma( obj, AM )
            % Initialize the actual node to the first node and its previous
            % neighbour to null
            actual_node = 1;
            previous_node = 0;
            % Initialize sigma with as first node the actual_node
            sigma = zeros(1, obj.nodes.n_total);
            sigma(1) = actual_node;
            % While we don't reach the last position in sigma
            for i = 2:obj.nodes.n_total
                % Check the neighbours of the actual node in AM
                neighbours = find(AM(actual_node,:) == 1);
                % If the first neighbour is not before actual node in sigma,
                % add it next to the actual node
                if neighbours(1) ~= previous_node
                    sigma(i) = neighbours(1);
                else
                    % Otherwise, add the second neighbour
                    sigma(i) = neighbours(2);
                end
                % Replace actual_node and previous_node
                previous_node = actual_node;
                actual_node = sigma(i);
            end
        end
        % Find the next neighbour (with delta length) using a small move of type 'type'
        function [sigma_new, delta] = smallMove(obj, sigma, type)
            % Choose randomly first node i and compute i_plus
            i = randi(obj.nodes.n_total);
            i_plus = mod(i, obj.nodes.n_total) + 1;
            % Depending on the small move the method will be different
            switch type
                case 'swap'
                    % Choose node j to swap with i, s.t. i != j
                    j = randi(obj.nodes.n_total);
                    while i == j
                        j = randi(obj.nodes.n_total);
                    end
                    % Swap i and j in sigma_new
                    sigma_new = sigma;
                    sigma_new([i j]) = sigma_new([j i]);
                    % Find i-, j+ and j-
                    i_minus = mod(i+(obj.nodes.n_total-2), obj.nodes.n_total) + 1;
                    j_plus = mod(j, obj.nodes.n_total) + 1;
                    j_minus = mod(j+(obj.nodes.n_total-2), obj.nodes.n_total) + 1;
                    % Compute the difference of length between sigma new
                    % and sigma
                    if i_plus == j
                        delta = obj.nodes.distance_matrix(sigma(i_minus),sigma(j)) + obj.nodes.distance_matrix(sigma(i),sigma(j_plus)) ...
                            - obj.nodes.distance_matrix(sigma(i_minus),sigma(i)) - obj.nodes.distance_matrix(sigma(j),sigma(j_plus));
                    elseif j_plus == i
                        delta = obj.nodes.distance_matrix(sigma(j_minus),sigma(i)) + obj.nodes.distance_matrix(sigma(j),sigma(i_plus)) ...
                            - obj.nodes.distance_matrix(sigma(j_minus),sigma(j)) - obj.nodes.distance_matrix(sigma(i),sigma(i_plus));
                    else
                        delta = obj.nodes.distance_matrix(sigma(i_minus),sigma(j)) + obj.nodes.distance_matrix(sigma(j),sigma(i_plus)) ...
                            + obj.nodes.distance_matrix(sigma(j_minus),sigma(i)) + obj.nodes.distance_matrix(sigma(i),sigma(j_plus)) ...
                            - obj.nodes.distance_matrix(sigma(i_minus),sigma(i)) - obj.nodes.distance_matrix(sigma(i),sigma(i_plus)) ...
                            - obj.nodes.distance_matrix(sigma(j_minus),sigma(j)) - obj.nodes.distance_matrix(sigma(j),sigma(j_plus));
                    end
                case 'translation'
                    % Choose node j to translate with i, s.t. i != j and i_plus != j
                    j = randi(obj.nodes.n_total);
                    while i == j || i_plus == j
                        j = randi(obj.nodes.n_total);
                    end
                    % Move j right to i in sigma_new
                    if i < j
                        sigma_new = [sigma(1:i) sigma(j) sigma(i+1:j-1) sigma(j+1:obj.nodes.n_total)];
                    else
                        sigma_new = [sigma(1:j-1) sigma(j+1:i) sigma(j) sigma(i+1:obj.nodes.n_total)];
                    end
                    % Find j+ and j-
                    j_plus = mod(j, obj.nodes.n_total) + 1;
                    j_minus = mod(j+(obj.nodes.n_total-2), obj.nodes.n_total) + 1;
                    % Compute the difference of length between sigma new
                    % and sigma
                    if i_plus == j_minus
                        delta = obj.nodes.distance_matrix(sigma(i),sigma(j)) + obj.nodes.distance_matrix(sigma(i_plus),sigma(j_plus)) ...
                            - obj.nodes.distance_matrix(sigma(i),sigma(i_plus)) - obj.nodes.distance_matrix(sigma(j),sigma(j_plus));
                    elseif j_plus == i
                        delta = obj.nodes.distance_matrix(sigma(j_minus),sigma(i)) + obj.nodes.distance_matrix(sigma(j),sigma(i_plus)) ...
                            - obj.nodes.distance_matrix(sigma(j_minus),sigma(j)) - obj.nodes.distance_matrix(sigma(i),sigma(i_plus));
                    else
                        delta = obj.nodes.distance_matrix(sigma(i),sigma(j)) + obj.nodes.distance_matrix(sigma(j),sigma(i_plus)) ...
                            + obj.nodes.distance_matrix(sigma(j_minus),sigma(j_plus)) - obj.nodes.distance_matrix(sigma(i),sigma(i_plus)) ...
                            - obj.nodes.distance_matrix(sigma(j_minus),sigma(j)) - obj.nodes.distance_matrix(sigma(j),sigma(j_plus));
                    end
                case 'inversion'
                    % Choose node j to swap with i, s.t. i != j
                    j = randi(obj.nodes.n_total);
                    while i == j
                        j = randi(obj.nodes.n_total);
                    end
                    % Find j+
                    j_plus = mod(j, obj.nodes.n_total) + 1;
                    % If i > j, first shift sigma to have sigma(i) at position 1
                    if i > j
                        shift = obj.nodes.n_total-i+1;
                        sigma = circshift(sigma, [0,shift]);
                        % Recompute i, i+, j and j+
                        i = 1;
                        i_plus = 2;
                        j = j + shift;
                        j_plus = mod(j, obj.nodes.n_total) + 1;
                    end
                    % If i+ = j or j+ = i, restart
                    if i_plus == j || j_plus == i
                        [sigma_new, delta] = obj.smallMove(sigma, 'inversion');
                        return;
                    end
                    % Inverse subcycle i+1 to j in sigma_new
                    sigma_new = sigma;
                    sigma_new(i_plus:j) = fliplr(sigma_new(i_plus:j));
                    % Compute the difference of length between sigma new
                    % and sigma
                    delta = obj.nodes.distance_matrix(sigma(i),sigma(j)) + obj.nodes.distance_matrix(sigma(i_plus),sigma(j_plus)) ...
                        - obj.nodes.distance_matrix(sigma(i),sigma(i_plus)) - obj.nodes.distance_matrix(sigma(j),sigma(j_plus));
                otherwise
                    % Select a random number between 1 and 3
                    move_nb = randi(3);
                    switch move_nb
                        case 1
                            [sigma_new, delta] = obj.smallMove(sigma, 'swap');
                        case 2
                            [sigma_new, delta] = obj.smallMove(sigma, 'translation');
                        otherwise
                            [sigma_new, delta] = obj.smallMove(sigma, 'inversion');
                    end
            end
        end
    end
end

