function ApplyTests( str_method, DM )
% Apply the tests using the 'str_method' and Distance Matrix 'DM'
	% Initialize the variables
    m = 40;
    Solutions = struct('AM', {}, 'length', {});
    % Run the method m times
    for i=1:m
        % Get the solution returned by the method and insert it in the
        % 'solutions' array. Each solution is a Adjacency Matrix.
        method = str2func(str_method);
        % Get the Adjacency Matrix 'AM'
        Solutions(i).AM = method(DM);
        % Get the length of the path based on the AM and the DM
        Solutions(i).length = 1/2 * sum(sum(DM .* Solutions(i).AM));
    end
end

