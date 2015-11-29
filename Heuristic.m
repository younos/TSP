classdef (Abstract) Heuristic
   % Mother class Heuristic from which the subclasses will inherit the
   % 'runTests' method
    
    properties
        Solutions = struct('AM', {}, 'length', {})
        nb_it = 40
        DM
    end
    
    methods
        % Constructor
    	function obj = Heuristic( DM )
            obj.DM = DM;
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
            obj.Solutions(1:4).AM
        end
    end
    methods (Abstract)
        % Find the shortest path (returns an Adjacent Matrix)
    	findShortestPath(obj)
    end
end

