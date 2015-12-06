function [l] = SigmaLength(sigma, DM)
% We just transform the vectors sigma and sigma_shift_1 into an index,
% with sigma being the row coordinates and sigma_shift_1 being the
% column coordinates
index = sub2ind(size(DM), sigma, circshift(sigma, [0, 1]));
% Then, we get the elements of D using the index, and sum them
l = sum(sum(DM(index)));
end

