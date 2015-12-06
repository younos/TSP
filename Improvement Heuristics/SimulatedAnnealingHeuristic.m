classdef SimulatedAnnealingHeuristic < Heuristic
    % Local Search Heuristic subclass inheriting from class 'Heuristic'
    
    properties
        criterion
        init_temp
    end
    properties(Constant)
        % Number of moves in each temperature level
        n_moves_per_level = 1000
    end
    
    methods
        % Constructor
        function obj = SimulatedAnnealingHeuristic( DM )
            obj = obj@Heuristic(DM);
            % Generate the initial temperature only once
            obj.generateInitTemp();
        end
        % Set the criterion to 'criterion'
        function obj = setCriterion( obj, criterion )
            obj.criterion = criterion;
        end
        % Generate the initial temperature 'init_temp'
        function obj = generateInitTemp( obj )
            % Initialize max_diff to zero and a random sigma permutation
            max_diff = 0;
            sigma = randperm(obj.n_total);
            % Compute length of sigma
            l_sigma = SigmaLength(sigma, obj.DM);
            % Generate successive random sigmas and compute the length
            % difference. Keep the max one.
            for i=1:obj.n_moves_per_level
                % Generate a new sigma permutation
                sigma_new = randperm(obj.n_total);
                % Compute the length of sigma_new
                l_sigma_new = SigmaLength(sigma_new, obj.DM);
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
        function AM = findShortestPath( obj )
            % Generate a random permutation sigma
            sigma = randperm(obj.n_total);
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
                    new_temp = 0.95 * new_temp;
                    n_moves_actual_temp = 0;
                end
                % Compute a new solution based on the move_type with the
                % difference of length
                [sigma_new, delta] = obj.smallMove(sigma, obj.move_type);
                % Set the new solution based on the criterion used
                if strcmp(obj.criterion,'metropolis')
                    % If the difference is negative or null, or based on the
                    % acceptance probability, accept sigma_new
                    if delta <= 0 || rand(1) < exp(-delta/new_temp)
                        sigma = sigma_new;
                        % The solution changed, so n_moves_no_change must
                        % be 0 at the end of this tour
                        n_moves_no_change = -1;
                    end
                    % For Heat Bath condition, only based on acceptance probability
                else
                    if rand(1) < 1 / (1 + exp(delta/new_temp))
                        sigma = sigma_new;
                        % The solution changed, so n_moves_no_change must
                        % be 0 at the end of this tour
                        n_moves_no_change = -1;
                    end
                end
                % Increment n_moves_no_change and n_moves_actual_temp
                n_moves_no_change = n_moves_no_change + 1;
                n_moves_actual_temp = n_moves_actual_temp + 1;
            end
            % Generate an Adjacency Matrix with sigma
            AM = SigmaToAM(sigma);
        end
    end
end

