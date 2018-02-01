function [reloc]=heuristicH(B)


%% We intialize the objective function at 0, the number of containers C and the minLevel to compute the
% number of relocations more efficiently
reloc=0;
nContainerLeft = sum(sum((B~=0)));
% While the configuration is not empty
while nContainerLeft > 0
% First find (if it is given) or give a target container
    currentMin = min(B(B~=0));
    [tRetrieve,sRetrieve] = find(B==currentMin);
% Depending on the heuristic make the appropriate relocations
    [B,nReloc] = retrieveCont(B,tRetrieve,sRetrieve);
% Count the number of relocaitons
    reloc = reloc + nReloc;
% update the number of containers
    nContainerLeft = nContainerLeft - 1;
end