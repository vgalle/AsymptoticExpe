%% This file helps to perform the experiments shown in Fig 4 of Galle et al (2016)

%% Maximum height
T = 5;
h = T - 1;

%% Number of stacks
listS = [5 50 100 250 500 1000];

%% The number of samples for evaluating the expected value of the heuristic H
nSamples = 1000000;

results = zeros(4,length(listS));
for iter_S = 1:length(listS)
    S = listS(iter_S);
    disp(S);
    results(1,iter_S) = S;
    results(2,iter_S) = expectedLowerBound(h,S);
    for iter_samples = 1:nSamples
        B = createbayeven(S,T,h);
        results(3,iter_S) = results(3,iter_S) + heuristicH(B)/nSamples;
    end
    results(4,iter_S) = results(3,iter_S) - results(2,iter_S);
end

plot(results(1,:),results(4,:));

outputFileName = strcat(num2str(nSamples), '_ExpeFig5.csv');
fid = fopen(outputFileName,'W');
fprintf(fid,'%s,%s,%s,%s,\n','S','S0','H','H - S0');
for r=1:length(listS)
    fprintf(fid,'%g,%g,%g,%g\n',results(1,r),results(2,r),results(3,r),results(4,r));
end
fclose(fid);