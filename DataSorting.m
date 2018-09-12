OS = 'Ubuntu';

subjs = {'S078', 'S117', 'S128', 'S132', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075', 'S135'}; 
% 'S117DD' is not included

%% EEG data in the order of subjects listed in subjs
EEG_20us =  [0.08, 0.15, 0.06, -0.03, 0.06, 0.17, 0.34, 0.05, -0.01, 0.37, 0.01, 0.38, 0.01, 0.02, 0.11];
EEG_60us =  [0.26, 1.03, 0.13,  0.38, 0.28, 0.33, 0.25, 0.12,  0.25, 0.15, 0.15, 0.28, 0.34, 0.03, 0.66];
EEG_180us = [1.10, 1.39, 0.47,  0.87, 1.11, 0.68, 0.62, 0.73,  1.51, 0.56, 0.87, 1.31, 0.92, 0.32, 0.62];
EEG_540us = [1.25, 1.27, 0.75,  1.04, 1.41, 1.22, 1.29, 0.73,  0.81, 1.22, 0.92, 1.16, 0.74, 0.41, 1.07];
EEG_avg   = [0.50, 0.87, 0.21,  0.48, 0.58, 0.51, 0.43, 0.30,  0.55, 0.27, 0.43, 0.64, 0.47, 0.12, 0.57];
%%
fid = fopen('dataSet.csv', 'w');
fprintf(fid, 'Subject, ITD, FMleft, FMright, 500Hzleft, 500Hzright, 4000Hzleft, 4000Hzright, block, EEG_20us, EEG_60us, EEG_180us, EEG_540us, EEG_avg\n');

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
        fprintf(fid, '%s, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f', subjs{s}, ITDs(b), FMleft, FMright, HLleft(freqs == 500), HLright(freqs == 500),...
            HLleft(freqs == 4000), HLright(freqs == 4000), b, EEG_20us(s), EEG_60us(s), EEG_180us(s), EEG_540us(s), EEG_avg(s));
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');
end