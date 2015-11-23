function ApplyTests( str_method, DM )
% Apply the tests using the 'str_method' and Distance Matrix 'DM'
	% Initialize the variables
    m = 40;
    solutions = zeros(40, length(DM));
    % Run the method m times
    for i=1:m
        % Get the solution returned by the method and insert it in the
        % 'solutions' array. Each solution is a sigma representation
        method = str2func(str_method);
        solutions(i, :) = method(DM);
    end
end

