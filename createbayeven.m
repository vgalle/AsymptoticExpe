function [B]=createbayeven(S,T,h)
% This function creates a bay of size T tiers and S stacks where you have
% equally filled with h containers in each column.
%% WARNING T should be more or equal to h
Sigma = randperm(S*h);
B = zeros(T,S);
for i=1:h;
    B(i+1,1:S)=Sigma((i-1)*S+1:i*S);
end;