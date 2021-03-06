%% ITD3down1up
OS = 'Ubuntu';
rootDir = '/media/agudemu/Storage/Data/Behavior/';
% Note that different day testing needs to be added right after its previous
%---------------------------------------------------------------------------
%---------------------------------------------------------------------------
subjs = subjNames(strcat(rootDir, 'ITD'));
subjs_NH_ITD = {'S025','S031','S043','S046','S051','S072','S075','S078','S084','S117',...
    'S123','S127','S128','S132','S133','S135','S143','S149','S173','S174','S183',...
    'S185','S187','S188','S189','S191','S192','S193','S194','S195','S196','S197','S198','S199'};
subjs_OD_ITD = {'S216','S218'}; % they are normal-hearing
subjs_HI_ITD = {'S129', 'S141', 'S190'};
numSubj = numel(subjs);

dataArrayITD_NH = dataExtraction(subjs_NH_ITD, OS, 'ITD3down1up', 'BothEar');
dataArrayITD_OD = dataExtraction(subjs_OD_ITD, OS, 'ITD3down1up', 'BothEar');
dataArrayITD_HI = dataExtraction(subjs_HI_ITD, OS, 'ITD3down1up', 'BothEar');
ITD_mean_NH = meanITD_FM(subjs_NH_ITD, OS, 'ITD3down1up', 'mean');
ITD_mean_OD = meanITD_FM(subjs_OD_ITD, OS, 'ITD3down1up', 'mean');
ITD_mean_HI = meanITD_FM(subjs_HI_ITD, OS, 'ITD3down1up', 'mean');

% Response track of one subject
responseTrack(dataArrayITD_NH{35}, 'ITD', 'Both');
perct = obvsMistkCntr(dataArrayITD_NH{1}, 'ITD');
% Box plot
index = indexFromSorting(subjs_NH_ITD, dataArrayITD_NH);
boxplot_thresh(dataArrayITD_NH, 'ITD', 'BothEar', index);

% Box plot for NH and HI
for i = 1: numel(subjs_NH_ITD)
    subjs_ITD_name_NH{i} = 'NH';
end

for i = 1: numel(subjs_OD_ITD)
    subjs_ITD_name_OD{i} = 'NH-OD';
end

for i = 1: numel(subjs_HI_ITD)
    subjs_ITD_name_HI{i} = 'HI';
end

boxplot([ITD_mean_NH ITD_mean_OD ITD_mean_HI]', [subjs_ITD_name_NH subjs_ITD_name_OD subjs_ITD_name_HI]');
title('ITD thresholds for all subjects');
errorbar(1:3, [mean(ITD_mean_NH) mean(ITD_mean_OD) mean(ITD_mean_HI)], [std(ITD_mean_NH) std(ITD_mean_OD) std(ITD_mean_HI)]);
%% FM
OS = 'Ubuntu';
rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs = subjNames(strcat(rootDir, 'FM'));
subjs_NH_FM = {'S021','S024','S025','S028','S031','S043','S046','S051','S072',...
    'S075','S078','S083','S084','S117','S119','S123','S127','S128','S132',...
    'S133','S135','S139','S140','S142','S143','S144','S145','S149','S183',...
    'S185','S187','S188','S189','S191','S192','S193','S194','S195','S196',...
    'S197','S199'};
subjs_HI_FM = {'S129', 'S141', 'S190'};
subjs_OD_FM = {'S216', 'S218'};
dataArrayFMLeft_NH = dataExtraction(subjs_NH_FM, OS, 'FM', 'LeftEar');
dataArrayFMRight_NH = dataExtraction(subjs_NH_FM, OS, 'FM', 'RightEar');
FM_mean_NH = meanITD_FM(subjs_NH_FM, OS, 'FM', 'mean');
FM_mean_NH_left = FM_mean_NH{1};
FM_mean_NH_right = FM_mean_NH{2};
FM_mean_NH_avg = (FM_mean_NH_right + FM_mean_NH_left)/2;
FM_mean_HI = meanITD_FM(subjs_HI_FM, OS, 'FM', 'mean');
FM_mean_HI_left = FM_mean_HI{1};
FM_mean_HI_right = FM_mean_HI{2};
FM_mean_HI_avg = (FM_mean_HI_right + FM_mean_HI_left)/2;
FM_mean_OD = meanITD_FM(subjs_OD_FM, OS, 'FM', 'mean');
FM_mean_OD_left = FM_mean_OD{1};
FM_mean_OD_right = FM_mean_OD{2};
FM_mean_OD_avg = (FM_mean_OD_right + FM_mean_OD_left)/2;

% Response track of one subject
responseTrack(dataArrayFMLeft_NH{16}, 'FM', 'Left');
responseTrack(dataArrayFMRight_NH{1}, 'FM', 'Right');
perctFMl = obvsMistkCntr(dataArrayFMLeft_NH{1}, 'FM');
perctFMr = obvsMistkCntr(dataArrayFMRight_NH{1}, 'FM');

% Box plot for all NH
index = indexFromSorting(subjs_NH_FM, dataArrayFMLeft_NH);
boxplot_thresh(dataArrayFMLeft_NH, 'FM', 'LeftEar', index);
boxplot_thresh(dataArrayFMRight_NH, 'FM', 'RightEar', index);

% Box plot for NH and HI
for i = 1: numel(subjs_NH_FM)
    subjs_FM_name_NH{i} = 'NH';
end

for i = 1: numel(subjs_HI_FM)
    subjs_FM_name_HI{i} = 'HI';
end

for i = 1: numel(subjs_OD_FM)
    subjs_FM_name_OD{i} = 'NH-OD';
end
boxplot([FM_mean_NH_avg FM_mean_OD_avg FM_mean_HI_avg]', [subjs_FM_name_NH subjs_FM_name_OD subjs_FM_name_HI]');
title('FM thresholds for all subjects');
% %% Hearing threshold
% subjs = {'S117', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046'};
% dataArrayHLLeft = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
% dataArrayHLRight = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');