OS = 'Ubuntu';

subjs = {'S117', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075'}; 
dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'LeftEar');

dataTmpITD = dataArrayITD{1};
dataTmpFM = dataArrayFMLeft{1};
repsITD = numel(dataTmpITD.thresh);
repsFM = numel(dataTmpFM.thresh);

ITD_FM_matrix = zeros(repsFM, repsITD); 

%simple linear regression: modeling the relationship between a scaler
%response and one or more explanatory variables,before doing this, it's
%good to perform correlation analysis to establish if a linear relationship
%exits, be aware that variables can have non-linear relationships which
%correlation analysis couldn't detect

