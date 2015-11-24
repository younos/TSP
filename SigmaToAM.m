function [ AM ] = SigmaToAM( sigma )
% Construct the adjacency matrix based on the sigma vector
    n = length(sigma);
    AM = zeros(n);
    for i = 1:n
        AM(sigma(i), sigma(mod(i+(n-2),n)+1)) = 1;
        AM(sigma(i), sigma(mod(i,n)+1)) = 1;
    end
end

