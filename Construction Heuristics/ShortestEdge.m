function [ AM ] = ShortestEdge( DM )
% Shortest Edge method applied on a Distance Matrix
    % Extract the number of nodes, i.e. edges needed for a cycle
	n_total = length(DM);
    % Initialize DM prime, AM (Adjacency Matrix) and n_edges
    DM_prime = DM;
    AM = zeros(n_total);
    n_edges = 0;
    % Replace all diagonal elements in DM prime with Inf
    DM_prime(1:n_total+1:end) = Inf;
    % While we don't have the total number of nodes
    while n_edges < n_total
        % Initialize DM_prime_bis
        DM_prime_bis = DM_prime;
        % While we don't find an edge respecting the rules, we continue
        % select a new edge
        while 1
            % Select shortest edge in the Distance Matrix (prime)
            [~, index] = min(DM_prime_bis(:));
            % Transform index as row/column coordinates
            [i,j] = ind2sub([n_total,n_total], index);
            % Check if new edge respects the rules
            if RespectRules(AM, i, j)
                % If yes we can go out of the loop
                break;
            else
                % Otherwise, we update of edge to Inf in DM_prime_bis
                DM_prime_bis(i,j) = Inf;
                DM_prime_bis(j,i) = Inf;
            end
        end
        % We add edge i and j in AM
        AM(i,j) = 1;
        AM(j,i) = 1;
        % Update length of edge to Inf in DM_prime
        DM_prime(i,j) = Inf;
        DM_prime(j,i) = Inf;
        % Increment n_edges
        n_edges = n_edges + 1;
    end
end

function [ respects ] = RespectRules( AM, i, j )
% Check if when inserting edge between node i and j, we respect the
% following rules/constraints:
% 1. Node i and j have not degree more than 2
% 2. No cycle with less than n nodes

    % Insert edge 'ij' in AM
    AM(i,j) = 1;
    AM(j,i) = 1;
    % Compute number of neighbours for nodes i and j
    nb_i = sum(AM(i,:));
    nb_j = sum(AM(j,:));
    % Check if 1st constraint not respected
    if nb_i > 2 || nb_j > 2
        respects = 0;
        return;
    end
    % Check if number of neighbours for nodes i and j are equal to 2,
    % otherwise no possibility for introducing a new cycle
    if nb_i == 2 && nb_j == 2
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
                break;
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
    % Reach this area means the added edge respects the constraints
    respects = 1;
end


