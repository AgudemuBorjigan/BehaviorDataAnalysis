OS = 'Ubuntu';

subjs = {'S078', 'S117', 'S117DD', 'S128', 'S132', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075'}; 

fid = fopen('dataSet.csv', 'w');
fprintf(fid, 'Subject, ITD, FMleft, FMright, 500Hzleft, 500Hzright, 4000Hzleft, 4000Hzright, block\n');

numSubj = numel(subjs);
dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
dataArrayFMleft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMright = dataExtraction(subjs, OS, 'FM', 'RightEar');
dataArrayHL_left = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
dataArrayHL_right = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');


for s = 1:numSubj
    ITDs = dataArrayITD{s}.thresh;
    FMleft = mean(dataArrayFMleft{s}.thresh);
    FMright = mean(dataArrayFMright{s}.thresh);
    HLleft = dataArrayHL_left{s}.thresh;
    HLright = dataArrayHL_right{s}.thresh;
    freqs = dataArrayHL_left{s}.freqs;
    for b = 1:numel(ITDs)
        fprintf(fid, '%s, %f, %f, %f, %f, %f, %f, %f, %f', subjs{s}, ITDs(b), FMleft, FMright, HLleft(freqs == 500), HLright(freqs == 500),...
            HLleft(freqs == 4000), HLright(freqs == 4000), b);
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');
end