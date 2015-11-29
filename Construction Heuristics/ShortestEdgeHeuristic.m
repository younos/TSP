classdef ShortestEdgeHeuristic < Heuristic
    % Shortest Edge Heuristic subclass inheriting from class 'Heuristic'
    
    properties
    end
    
    methods
        % Constructor
    	function obj = ShortestEdgeHeuristic( DM )
            obj = obj@Heuristic(DM);
        end
        % Shortest Edge heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
            % Extract the number of nodes, i.e. edges needed for a cycle
            n_total = length(obj.DM);
            % Initialize DM prime, AM (Adjacency Matrix) and n_edges
            DM_prime = obj.DM;
            AM = zeros(n_total);
            n_edges = 0;
            % Replace all diagonal elements in DM prime with Inf
            DM_prime(1:n_total+1:end) = Inf;
            % While we don't have the total number of nodes
            while n_edges < n_total
                % While we don't find an edge respecting the rules, we continue
                % select a new edge
                while 1
                    % Select shortest edge in the Distance Matrix (prime)
                    [~, index] = min(DM_prime(:));
                    % Transform index as row/column coordinates
                    [i,j] = ind2sub([n_total,n_total], index);
                    % Check if new edge respects the rules
                    if ShortestEdgeHeuristic.RespectRules(AM, i, j)
                        % If yes we can go out of the loop
                        break;
                    else
                        % Otherwise, we update the edge's length to Inf in DM_prime.
                        % This edge cannot be used anymore.
                        DM_prime(i,j) = Inf;
                        DM_prime(j,i) = Inf;
                    end
                end
                % We add edge i and j in AM
                AM(i,j) = 1;
                AM(j,i) = 1;
                % Remove edge(i,j) from DM_prime
                DM_prime(i,j) = Inf;
                DM_prime(j,i) = Inf;
                % If i/j have already 2 neighbours, set all possible edges
                % related to i/j as impossible (to Inf). Otherwise just
                % edge (i,j) as Inf
                if sum(AM(i,:)) == 2
                    DM_prime(i,:) = Inf;
                    DM_prime(:,i) = Inf;
                end
                if sum(AM(j,:)) == 2
                    DM_prime(j,:) = Inf;
                    DM_prime(:,j) = Inf;
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
        function respects = RespectRules( AM, i, j )
            % Insert edge 'ij' in AM
            AM(i,j) = 1;
            AM(j,i) = 1;
            % Starts from i and go to 2nd neighbour of i (i.e. not j)
            % If once we reach j, that means we introduced a cycle
            current_node = i;
            last_node = j;
            % Initialize remaining number of nodes to visit before complete
            % cycle (minus 1, because i is already visited)
            n = length(AM) - 1;
            while 1
                % Decrease n
                n = n - 1;
                % Find all the neighbours of current_node
                neighbours = find(AM(current_node,:));
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

