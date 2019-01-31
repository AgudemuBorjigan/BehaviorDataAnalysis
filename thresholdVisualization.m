OS = 'Ubuntu';

%% ITD3down1up
% Note that different day testing needs to be added right after its previous
%---------------------------------------------------------------------------
%Paradigm was chaneged after them: 'Satya', 'SatyaDD', 'Kristen', 'Rav', 'S116', 'Anna', 'Bre'
%117DD was excluded
%---------------------------------------------------------------------------
 subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S135', 'S143', ...
    'S149', 'S173', 'S051', 'S183', 'S185', 'S187', 'S189', 'S192', 'S193', 'S194', 'S195', 'S196', 'S197', 'S198', 'S199',...
    'S043', 'S072', 'S075', 'S078', 'S084', 'S191', 'S190'}; % 'S190', 'S198' only completed ITD
numSubj = numel(subjs);

dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');

% Response track of one subject
figure;
responseTrack(dataArrayITD{end}, 'ITD', subjs{end});

% Box plot
index = indexFromSorting(subjs, dataArrayITD);

figure;
boxplot_thresh(dataArrayITD, 'ITD', 'BothEar', index);

%% FM 
subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S143', ...
    'S149', 'S051', 'S183', 'S185', 'S187', 'S189', 'S193', 'S195', 'S196', 'S043', 'S072', 'S075', 'S078', 'S135', ...
    'S192', 'S194', 'S197', 'S199', 'S173', 'S084', 'S191'};  
 
dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'RightEar');

% Response track of one subject
responseTrack(dataArrayFMLeft{end-2}, 'FM', subjs{end-2});
% Box plot
index = indexFromSorting(subjs, dataArrayFMLeft);
figure;
boxplot_thresh(dataArrayFMLeft, 'FM', 'LeftEar', index);
figure;
boxplot_thresh(dataArrayFMRight, 'FM', 'RightEar', index);
% 
% %% Hearing threshold
% subjs = {'S117', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046'}; 
% dataArrayHLLeft = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
% dataArrayHLRight = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');