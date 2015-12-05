classdef SimulatedAnnealingHeuristic < Heuristic
    % Local Search Heuristic subclass inheriting from class 'Heuristic'

    properties
        criterion
    end
    
    methods
        % Constructor
    	function obj = SimulatedAnnealingHeuristic( DM )
            obj = obj@Heuristic(DM);
        end
        % Set the criterion to 'criterion'
    	function obj = setMoveType( obj, criterion )
            obj.criterion = criterion;
        end
        % Simulated Annealing heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
        end
    end
    
end

