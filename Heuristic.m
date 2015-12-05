classdef (Abstract) Heuristic < handle
   % Mother class Heuristic from which the subclasses will inherit the
   % 'runTests' method
    
    properties
        % Structure where the Ajacency Matrices and the length are stored
        % for each iterations
        Solutions = struct('AM', {}, 'length', {})
        % Distance Matrix
        DM
        % Total number of nodes
        n_total
        % Type of move selected
        move_type
    end
    properties(Constant)
        % Number of iterations
        nb_it = 1
    end
    
    methods
        % Constructor
    	function obj = Heuristic( DM )
            obj.DM = DM;
            obj.n_total = length(DM);
        end
        % Apply the tests with the 'findShortestPath' method on the
        % Distance Matrix 'DM'
        function runTests( obj )
            % Run the method M times
            for i=1:obj.nb_it
                % Get the solution returned by the method 'findShortestPath'
                % and insert it in the 'Solutions' structure. Each solution
                % is an Adjacency Matrix.
                obj.Solutions(i).AM = obj.findShortestPath();
                % Get the length of the path based on the AM and the DM
                obj.Solutions(i).length = 1/2 * sum(sum(obj.DM .* obj.Solutions(i).AM));
            end
            obj.Solutions(1).length
        end
        % Set the move_type to 'type'
    	function obj = setMoveType( obj, type )
            obj.move_type = type;
        end
        % Find the next neighbour (with delta length) using a small move of type 'type'
        function [sigma_bis, delta] = smallMove(obj, sigma, type)
            % Choose randomly first node i and compute i_plus
            i = randi(obj.n_total);
            i_plus = mod(i, obj.n_total) + 1;
            % Depending on the small move the method will be different
            switch type
                case 'swap'
                    % Choose node j to swap with i, s.t. i != j
                    j = randi(obj.n_total);
                    while i == j
                        j = randi(obj.n_total);
                    end
                    % Swap i and j in sigma_bis
                    sigma_bis = sigma;
                    sigma_bis([i j]) = sigma_bis([j i]);
                    % Find i-, j+ and j-
                    i_minus = mod(i+(obj.n_total-2), obj.n_total) + 1;
                    j_plus = mod(j, obj.n_total) + 1;
                    j_minus = mod(j+(obj.n_total-2), obj.n_total) + 1;
                    % Compute the difference of length between sigma bis
                    % and sigma
                    if i_plus == j
                        delta = obj.DM(sigma(i_minus),sigma(j)) + obj.DM(sigma(i),sigma(j_plus)) ...
                              - obj.DM(sigma(i_minus),sigma(i)) - obj.DM(sigma(j),sigma(j_plus));
                    elseif j_plus == i
                        delta = obj.DM(sigma(j_minus),sigma(i)) + obj.DM(sigma(j),sigma(i_plus)) ...
                              - obj.DM(sigma(j_minus),sigma(j)) - obj.DM(sigma(i),sigma(i_plus));
                    else
                        delta = obj.DM(sigma(i_minus),sigma(j)) + obj.DM(sigma(j),sigma(i_plus)) ...
                              + obj.DM(sigma(j_minus),sigma(i)) + obj.DM(sigma(i),sigma(j_plus)) ...
                              - obj.DM(sigma(i_minus),sigma(i)) - obj.DM(sigma(i),sigma(i_plus)) ...
                              - obj.DM(sigma(j_minus),sigma(j)) - obj.DM(sigma(j),sigma(j_plus));
                    end
                case 'translation'
                    % Choose node j to translate with i, s.t. i != j and i_plus != j
                    j = randi(obj.n_total);
                    while i == j || i_plus == j
                        j = randi(obj.n_total);
                    end
                    % Move j right to i in sigma_bis
                    if i < j
                        sigma_bis = [sigma(1:i) sigma(j) sigma(i+1:j-1) sigma(j+1:obj.n_total)];
                    else
                        sigma_bis = [sigma(1:j-1) sigma(j+1:i) sigma(j) sigma(i+1:obj.n_total)];
                    end
                    % Find j+ and j-
                    j_plus = mod(j, obj.n_total) + 1;
                    j_minus = mod(j+(obj.n_total-2), obj.n_total) + 1;
                    % Compute the difference of length between sigma bis
                    % and sigma
                    if i_plus == j_minus
                        delta = obj.DM(sigma(i),sigma(j)) + obj.DM(sigma(i_plus),sigma(j_plus)) ...
                              - obj.DM(sigma(i),sigma(i_plus)) - obj.DM(sigma(j),sigma(j_plus));
                    elseif j_plus == i
                        delta = obj.DM(sigma(j_minus),sigma(i)) + obj.DM(sigma(j),sigma(i_plus)) ...
                              - obj.DM(sigma(j_minus),sigma(j)) - obj.DM(sigma(i),sigma(i_plus));
                    else
                        delta = obj.DM(sigma(i),sigma(j)) + obj.DM(sigma(j),sigma(i_plus)) ...
                              + obj.DM(sigma(j_minus),sigma(j_plus)) - obj.DM(sigma(i),sigma(i_plus)) ...
                              - obj.DM(sigma(j_minus),sigma(j)) - obj.DM(sigma(j),sigma(j_plus));
                    end
                case 'inversion'
                    % Choose node j to swap with i, s.t. i != j
                    j = randi(obj.n_total);
                    while i == j
                        j = randi(obj.n_total);
                    end
                    % Inverse subcycle i+1 to j in sigma_bis
                    if i < j
                        sigma_bis = sigma;
                        sigma_bis(i_plus:j) = fliplr(sigma_bis(i_plus:j));
                    else
                        % If j > i, firstshift sigma to have sigma(i) at
                        % position at sigma(1)
                        sigma_bis = circshift(sigma, [0,obj.n_total-i+1]);
                        sigma_bis(2:2+i-j) = fliplr(sigma_bis(2:2+i-j));
                    end
                    % Find j+
                    j_plus = mod(j, obj.n_total) + 1;
                    % Compute the difference of length between sigma bis
                    % and sigma
                    delta = obj.DM(sigma(i),sigma(j)) + obj.DM(sigma(i_plus),sigma(j_plus)) ...
                              - obj.DM(sigma(i),sigma(i_plus)) - obj.DM(sigma(j),sigma(j_plus));
                    % If i+ = j or j+ = i, restart
                    if i_plus == j || j_plus == i
                        [sigma_bis, delta] = obj.smallMove(sigma, 'inversion');
                    end 
                otherwise
                    % Select a random number between 1 and 3
                    move_nb = randi(3);
                    switch move_nb
                        case 1
                            [sigma_bis, delta] = obj.smallMove(sigma, 'swap');
                        case 2
                            [sigma_bis, delta] = obj.smallMove(sigma, 'translation');
                        otherwise
                            [sigma_bis, delta] = obj.smallMove(sigma, 'inversion');
                    end
            end
        end
    end
    methods (Abstract)
        % Find the shortest path (returns an Adjacent Matrix)
    	findShortestPath( obj )
    end
end

