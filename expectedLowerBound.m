function [lb] = expectedLowerBound(h,C)
%% This function computes the expected number of blocking containers in a bay
% with h containers in each of its C columns.
    lb = h;
    for iter_h = 1:h
        lb = lb - 1/iter_h;
    end
    lb = lb * C;
end
