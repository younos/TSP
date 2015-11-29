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
        end
    end
    
end

