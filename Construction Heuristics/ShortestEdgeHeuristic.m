classdef ShortestEdgeHeuristic < Heuristic
    % Shortest Edge Heuristic subclass inheriting from class 'Heuristic'
    
    properties
    end
    
    methods
        % Constructor
        function obj = ShortestEdgeHeuristic( nodes )
            obj = obj@Heuristic(nodes);
        end
        % Shortest Edge heuristic applied on a Distance Matrix
        function adjacency_matrix = findShortestPath( obj )
            % Initialize DM prime, AM (Adjacency Matrix) and n_edges
            distance_matrix_prime = obj.nodes.distance_matrix;
            adjacency_matrix = zeros(obj.nodes.n_total);
            n_edges = 0;
            % Replace all diagonal elements in DM prime with Inf
            distance_matrix_prime(1:obj.nodes.n_total+1:end) = Inf;
            % While we don't have the total number of nodes
            while n_edges < obj.nodes.n_total
                % While we don't find an edge respecting the rules, we continue
                % select a new edge
                while 1
                    % Select shortest edge in the Distance Matrix (prime)
                    [~, index] = min(distance_matrix_prime(:));
                    % Transform index as row/column coordinates
                    [i,j] = ind2sub([obj.nodes.n_total,obj.nodes.n_total], index);
                    % Check if new edge respects the rules
                    if ShortestEdgeHeuristic.RespectRules(adjacency_matrix, i, j)
                        % If yes we can go out of the loop
                        break;
                    else
                        % Otherwise, we update the edge's length to Inf in
                        % distance_matrix_prime. This edge cannot be used anymore.
                        distance_matrix_prime(i,j) = Inf;
                        distance_matrix_prime(j,i) = Inf;
                    end
                end
                % We add edge i and j in AM
                adjacency_matrix(i,j) = 1;
                adjacency_matrix(j,i) = 1;
                % Remove edge(i,j) from distance_matrix_prime
                distance_matrix_prime(i,j) = Inf;
                distance_matrix_prime(j,i) = Inf;
                % If i/j have already 2 neighbours, set all possible edges
                % related to i/j as impossible (to Inf). Otherwise just
                % edge (i,j) as Inf
                if sum(adjacency_matrix(i,:)) == 2
                    distance_matrix_prime(i,:) = Inf;
                    distance_matrix_prime(:,i) = Inf;
                end
                if sum(adjacency_matrix(j,:)) == 2
                    distance_matrix_prime(j,:) = Inf;
                    distance_matrix_prime(:,j) = Inf;
                end
                % Increment n_edges
                n_edges = n_edges + 1;
            end
        end
    end
    methods (Static)
        % Check if when inserting edge between node i and j, we respect the
        % following rule/constraint:
        % 1. No cycle with less than n nodes
        function respects = RespectRules( adjacency_matrix, i, j )
            % Insert edge 'ij' in AM
            adjacency_matrix(i,j) = 1;
            adjacency_matrix(j,i) = 1;
            % Starts from i and go to 2nd neighbour of i (i.e. not j)
            % If once we reach j, that means we introduced a cycle
            current_node = i;
            last_node = j;
            % Initialize remaining number of nodes to visit before complete
            % cycle (minus 1, because i is already visited)
            n = length(adjacency_matrix) - 1;
            while 1
                % Decrease n
                n = n - 1;
                % Find all the neighbours of current_node
                neighbours = find(adjacency_matrix(current_node,:));
                % Choose as next current_node the 2nd neighbour (i.e. not
                % last_node)
                tmp = neighbours(neighbours~=last_node);
                % If the next current_node is empty that means we reached the
                % end of the sub graph without finding a new cycle. Or if the
                % remaining number of nodes to visit is 0, we complete the cycle
                if isempty(tmp) || n == 0
                    respects = 1;
                    return;
                    % Else if the next current_node is j, that means we did a cycle
                elseif tmp == j
                    respects = 0;
                    return;
                end
                % Otherwise continue to navigate
                last_node = current_node;
                current_node = tmp;
            end
        end
    end
end

