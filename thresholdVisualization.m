OS = 'Ubuntu';

%% ITD3down1up
% Note that different day testing needs to be added right after its previous
%---------------------------------------------------------------------------
%Paradigm was chaneged after them: 'Satya', 'SatyaDD', 'Kristen', 'Rav', 'S116', 'Anna', 'Bre'
%117DD was excluded
%---------------------------------------------------------------------------
% subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S135', 'S143', ...
%     'S149', 'S173', 'S051', 'S183', 'S185', 'S187', 'S189', 'S192', 'S193', 'S194', 'S195', 'S196', 'S197', 'S199',...
%     'S043', 'S072', 'S075', 'S078', 'S084', 'S191', 'S190', 'S198'}; % 'S190', 'S198' only completed ITD
% numSubj = numel(subjs);
% 
% dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
% 
% % Response track of one subject
% responseTrack(dataArrayITD{1}, 'ITD', subjs{1}, 'Both');
% [perct, percTl] = obvsMistkCntr(dataArrayITD{1}, 'ITD');
% Box plot
% index = indexFromSorting(subjs, dataArrayITD);
% 
% boxplot_thresh(dataArrayITD, 'ITD', 'BothEar', index);

%% FM
% subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S135', 'S143', ...
%     'S149', 'S173', 'S051', 'S183', 'S185', 'S187', 'S189', 'S192', 'S193', 'S194', 'S195', 'S196', 'S197', 'S199',...
%     'S043', 'S072', 'S075', 'S078', 'S084', 'S191'};  % 'S190', 'S198' only completed ITD
subjs = {'S084'};
dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'RightEar');

% Response track of one subject
responseTrack(dataArrayFMLeft{1}, 'FM', subjs{1}, 'Left');
responseTrack(dataArrayFMRight{1}, 'FM', subjs{1}, 'Right');
[perctFMl, percTlFMl] = obvsMistkCntr(dataArrayFMLeft{1}, 'FM');
[perctFMr, percTlFMr] = obvsMistkCntr(dataArrayFMRight{1}, 'FM');

% % Box plot
% index = indexFromSorting(subjs, dataArrayFMLeft);
% figure;
% boxplot_thresh(dataArrayFMLeft, 'FM', 'LeftEar', index);
% figure;
% boxplot_thresh(dataArrayFMRight, 'FM', 'RightEar', index);

% %% Hearing threshold
% subjs = {'S117', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046'};
% dataArrayHLLeft = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
% dataArrayHLRight = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');