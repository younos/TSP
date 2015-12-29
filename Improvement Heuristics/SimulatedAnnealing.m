classdef SimulatedAnnealing < Heuristic
    % Simulated Annealing subclass inheriting from class 'Heuristic'
    
    properties
        criterion
        move_type
        init_temp
        l_values
    end
    properties(Constant)
        % Number of moves in each temperature level
        n_moves_per_level = 1000
    end
    
    methods
        % Constructor
        function obj = SimulatedAnnealing(nodes, criterion, move_type)
            obj = obj@Heuristic(nodes);
            % Set the criterion and the move_type
            obj.criterion = criterion;
            obj.move_type = move_type;
            % Generate the initial temperature only once
            obj.generateInitTemp();
        end
        % Return the name of the method
        function name = getName(obj)
            name = strcat(class(obj), obj.criterion, obj.move_type);
        end
        % Generate the initial temperature 'init_temp'
        function obj = generateInitTemp( obj )
            % Initialize max_diff to zero and a random sigma permutation
            max_diff = 0;
            sigma = randperm(obj.nodes.n_total);
            % Compute length of sigma
            l_sigma = obj.sigmaLength(sigma);
            % Generate successive random sigmas and compute the length
            % difference. Keep the max one.
            for i=1:obj.n_moves_per_level
                % Generate a new sigma permutation
                sigma_new = randperm(obj.nodes.n_total);
                % Compute the length of sigma_new
                l_sigma_new = obj.sigmaLength(sigma_new);
                % Compute the difference of the lengths
                diff = abs(l_sigma_new - l_sigma);
                % If better than the actual one keeo it
                if diff > max_diff
                    max_diff = diff;
                end
                % Replace the length of sigma with the one of sigma_new
                l_sigma = l_sigma_new;
            end
            % Set the initial temperature as 10 times the max_diff (for
            % acceptance rate of moves of ~ 90%)
            obj.init_temp = 10 * max_diff;
        end
        % Simulated Annealing heuristic applied on a Distance Matrix
        function sigma = findShortestPath( obj, performance )
            % By default performance value is false
            if nargin == 1
                performance = false;
            end
            % Generate a random permutation sigma
            sigma = randperm(obj.nodes.n_total);
            % If we measure the performance, we initialize the vector
            % that will contains the values for one temperature
            if performance
                l_values_per_temp = zeros(1, obj.n_moves_per_level);
                % And we compute the L value of sigma
                l_sigma = obj.sigmaLength(sigma);
            end
            % Initialize new temperature to the initial one
            new_temp = obj.init_temp;
            % Initialze the number of successive runs during which sigma
            % didn't change, the number of moves for the actual temperature
            % and the limit number of times during which we search another
            % solution before stopping (here 10 successive temperature levels)
            n_moves_no_change = 0;
            n_moves_actual_temp = 0;
            n_moves_limit = 10*obj.n_moves_per_level;
            % While the actual solution didn't change during 10 successive
            % temperature levels, we continue to search for another solution
            while n_moves_no_change < 10*n_moves_limit
                % If we did 'n_moves_per_level' steps in the actual
                % temperature, decrease the temperature
                if obj.n_moves_per_level == n_moves_actual_temp
                    % If we measure the performance, we record the max,
                    % mean and min value for the actual temp
                    if performance
                        obj.l_values = [obj.l_values; ...
                                        new_temp, max(l_values_per_temp), mean(l_values_per_temp), min(l_values_per_temp)];
                    end
                    new_temp = 0.95 * new_temp;
                    n_moves_actual_temp = 0;
                end
                % Compute a new solution based on the move_type with the
                % difference of length
                [sigma_new, delta] = obj.smallMove(sigma, obj.move_type);
                % Set the new solution based on the criterion used
                if strcmp(obj.criterion,'Metropolis')
                    % If the difference is negative or null, or based on the
                    % acceptance probability, accept sigma_new
                    if delta <= 0 || rand(1) < exp(-delta/new_temp)
                        sigma = sigma_new;
                        % The solution changed, so n_moves_no_change must
                        % be 0 at the end of this tour
                        n_moves_no_change = -1;
                        % If measure performance, we record the new l value
                        % of sigma
                        if performance
                            l_sigma = l_sigma + delta;
                        end
                    end
                    % For Heat Bath condition, only based on acceptance probability
                else
                    if rand(1) < 1 / (1 + exp(delta/new_temp))
                        sigma = sigma_new;
                        % The solution changed, so n_moves_no_change must
                        % be 0 at the end of this tour
                        n_moves_no_change = -1;
                        % If measure performance, we record the new l value
                        % of sigma
                        if performance
                            l_sigma = l_sigma + delta;
                        end
                    end
                end
                % Increment n_moves_no_change and n_moves_actual_temp
                n_moves_no_change = n_moves_no_change + 1;
                n_moves_actual_temp = n_moves_actual_temp + 1;
                % Add the current L value of sigma to the vector of values
                % for the current temp (if measuring performance)
                if performance
                    l_values_per_temp(n_moves_actual_temp) = l_sigma;
                end
            end
        end
        % Get the plot of performance (l_values (min, max, mean) vs temperature)
        function performancePlot(obj)
            % Initialize l_values (1st column for temperature values, 2nd
            % column for min, 3rd for max and 4th for mean)
            obj.l_values = [];
            % Launch algorithm computing the performance
            obj.findShortestPath(true);
            % Display the performance plot
            figure('Position', [100, 100, 1049, 895]);
            plot(obj.l_values(:,1), obj.l_values(:,2), 'r', ...
                 obj.l_values(:,1), obj.l_values(:,3), 'g', ...
                 obj.l_values(:,1), obj.l_values(:,4), 'b');
            title(strcat(obj.getName(), 'Performance'));
            xlabel('temperature');
            ylabel('L(\theta)');
            legend('max', 'mean', 'min');
        end
    end
end

