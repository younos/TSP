classdef LocalSearchHeuristic < Heuristic
    % Local Search Heuristic subclass inheriting from class 'Heuristic'

    properties
    end
    
    methods
        % Constructor
    	function obj = LocalSearchHeuristic( DM )
            obj = obj@Heuristic(DM);
        end
        % Local Search heuristic applied on a Distance Matrix
        function AM = findShortestPath( obj )
        end
    end
    
end

