classdef SavingHeuristic < Heuristic
    % Saving Heuristic subclass inheriting from class 'Heuristic'

    properties
    end
    
    methods
        % Constructor
    	function obj = SavingHeuristic( DM )
            obj = obj@Heuristic(DM);
        end
        % Saving heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
            % Extract the total number of nodes
            n_total = length(obj.DM);
            % Select randomly the warehouse
            w = randi(n_total);
            % Initialize SM (Savings Matrix: diw + dwj − dij)
            SM = repmat(obj.DM(1:n_total, w), 1, n_total) ...
              + repmat(obj.DM(w, 1:n_total), n_total, 1) ...
              - obj.DM;
            % Initialize AM (Adjacency Matrix) with connections to node w
            AM = zeros(n_total);
            AM([1:w-1 w+1:n_total],w) = 2;
            AM(w,[1:w-1 w+1:n_total]) = 2;
            % Replace all diagonal elements, on line w or on column w in S with -1
            SM(1:n_total+1:end) = -1;
            SM(w,:) = -1;
            SM(:,w) = -1;
            % Initialize n_edges_to_w
            n_edges_to_w = 2 * (n_total - 1);
            % While w is connected to more than 2 nodes
            while 2 < n_edges_to_w
                % While we don't find two nodes of different sub cycles
                while 1
                    % Select the two nodes having the greatest saving when merged
                    [~, index] = max(SM(:));
                    % Transform index as row/column coordinates
                    [i,j] = ind2sub([n_total,n_total], index);
                    % Check if nodes choosen are not in the same cycle
                    if SavingHeuristic.RespectRules(AM, i, j, w)
                        % If no we can go out of the loop
                        break;
                    else
                        % Otherwise, we remove edge between nodes i and j
                        % as possible merge
                        SM(i,j) = -1;
                        SM(j,i) = -1;
                    end
                end
                % Insert new edge between i and j in Adjacent Matrix
                AM(i,j) = 1;
                AM(j,i) = 1;
                % Remove one edge of (i,w) and (j,w) in AM
                AM(i,w) = AM(i,w) - 1;
                AM(w,i) = AM(w,i) - 1;
                AM(j,w) = AM(j,w) - 1;
                AM(w,j) = AM(w,j) - 1;
                % Mark savings between i and j as done
                SM(i,j) = -1;
                SM(j,i) = -1;
                % If node i or j are not linked with w anymore, we can
                % remove them as possible nodes to merge
                if AM(i,w) == 0
                    SM(i,:) = -1;
                    SM(:,i) = -1;
                end
                if AM(j,w) == 0
                    SM(j,:) = -1;
                    SM(:,j) = -1;
                end
                % Decrease n_edges_to_w
                n_edges_to_w = n_edges_to_w - 2;
            end
        end
    end
    methods (Static)
        % Check if node i and j are not already in same sub cycle
        function respects = RespectRules( AM, i, j, w)
            % Starts from i and go to 2nd neighbour of i (i.e. not w)
            % If once we reach j, that means we create a cycle with less
            % than n nodes
            current_node = i;
            last_node = w;
            while 1
                % Find all the neighbours of current_node
                neighbours = find(AM(current_node,:));
                % Choose as next current_node the 2nd neighbour (i.e. not
                % last_node)
                tmp = neighbours(neighbours~=last_node);
                % If the next current_node is empty that means w is the
                % only neighbour, or if the next current_node is w that means
                % i and j are not in the same sub cycle
                if isempty(tmp) || tmp == w
                    respects = 1;
                    return;
                % Else if the next current_node is j, that means i and j
                % are in the same cycle
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

