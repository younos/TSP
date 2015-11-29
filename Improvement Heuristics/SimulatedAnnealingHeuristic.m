classdef SimulatedAnnealingHeuristic < Heuristic
    % Local Search Heuristic subclass inheriting from class 'Heuristic'

    properties
    end
    
    methods
        % Constructor
    	function obj = SimulatedAnnealingHeuristic( DM )
            obj = obj@Heuristic(DM);
        end
        % Simulated Annealing heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
        end
    end
    
end

