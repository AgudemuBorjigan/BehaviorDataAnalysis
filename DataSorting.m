OS = 'Ubuntu';

subjs = {'S078', 'S117', 'S128', 'S132', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075', 'S135', 'S031'}; 
% 'S117DD' is not included

%% EEG data in the order of subjects listed in subjs
% ITC, average of auditory channels
EEG_20us =  [0.08, 0.15, 0.06, -0.03, 0.06, 0.17, 0.34, 0.05, -0.01, 0.37, 0.01, 0.38, 0.01, 0.02, 0.11, -0.01];
EEG_60us =  [0.26, 1.03, 0.13,  0.38, 0.28, 0.33, 0.25, 0.12,  0.25, 0.15, 0.15, 0.28, 0.34, 0.03, 0.66,  1.15];
EEG_180us = [1.10, 1.39, 0.47,  0.87, 1.11, 0.68, 0.62, 0.73,  1.51, 0.56, 0.87, 1.31, 0.92, 0.32, 0.62,  0.88];
EEG_540us = [1.25, 1.27, 0.75,  1.04, 1.41, 1.22, 1.29, 0.73,  0.81, 1.22, 0.92, 1.16, 0.74, 0.41, 1.07,  0.91];
EEG_avg   = [0.50, 0.87, 0.21,  0.48, 0.58, 0.51, 0.43, 0.30,  0.55, 0.27, 0.43, 0.64, 0.47, 0.12, 0.57,  0.52];
% normalized magnitude, average of auditory channels
EEG_mag20us  = [0.41, 0.52, 0.50, 0.58, 0.63, 0.46, 1.02, 0.31, 0.38, 0.56, 0.40, 0.45, 0.46, 0.19, 0.56, 0.68];
EEG_mag60us  = [0.50, 0.97, 0.59, 0.88, 0.51, 0.57, 1.10, 0.31, 0.66, 0.78, 0.51, 0.57, 0.82, 0.28, 0.98, 1.02];
EEG_mag180us = [1.15, 1.57, 0.74, 1.29, 1.60, 0.87, 1.30, 1.03, 1.66, 0.98, 1.17, 1.21, 1.06, 0.58, 1.10, 1.05];
EEG_mag540us = [1.35, 1.32, 0.80, 1.39, 1.47, 1.29, 1.77, 1.14, 1.05, 1.52, 1.20, 1.65, 0.90, 0.70, 1.14, 1.16];
EEG_mag_avg =  [0.68, 1.21, 0.54, 0.84, 0.99, 0.68, 1.19, 0.47, 0.82, 0.81, 0.66, 0.88, 0.71, 0.38, 0.87, 0.84];
%%
fid = fopen('dataSet.csv', 'w');
fprintf(fid, 'Subject, ITD, FMleft, FMright, 500Hzleft, 500Hzright, 4000Hzleft, 4000Hzright, block, EEG_20us, EEG_60us, EEG_180us, EEG_540us, EEG_avg, EEG_mag20us, EEG_mag60us, EEG_mag180us, EEG_mag540us, EEG_mag_avg\n');

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
        fprintf(fid, '%s, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f', subjs{s}, ITDs(b), FMleft, FMright, HLleft(freqs == 500), HLright(freqs == 500),...
            HLleft(freqs == 4000), HLright(freqs == 4000), b, EEG_20us(s), EEG_60us(s), EEG_180us(s), EEG_540us(s), EEG_avg(s),...
            EEG_mag20us(s), EEG_mag60us(s), EEG_mag180us(s), EEG_mag540us(s), EEG_mag_avg(s));
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');
end