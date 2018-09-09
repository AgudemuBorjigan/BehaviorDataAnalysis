OS = 'Ubuntu';

subjs = {'S117', 'S117DD', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075'}; 
%-----------------------------------------------------------------------------
% subjects with EEG recording ...
% excluding S117 (extremely high evoked response), which corrected the corr
% between the EEG and behavior to negative, and increased the corr between
%-----------------------------------------------------------------------------
subjs_EEG = {'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075'}; 
% the ITD and FM
numSubj = numel(subjs);
numSubj_EEG = numel(subjs_EEG);

% Extracting mean ITD thresholds
dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
threshMeanITD = zeros(1, numSubj);
for s = 1:numSubj
    dataTmp = dataArrayITD{s};
    %---------------------------------------
    % Is taking the mean appropriate?
    %---------------------------------------
    threshMeanITD(s) = mean(dataTmp.thresh);
end

dataArrayITD_EEG = dataExtraction(subjs_EEG, OS, 'ITD3down1up', 'BothEar');
threshMeanITD_EEG = zeros(1, numSubj_EEG);
for s = 1:numSubj_EEG
    dataTmp = dataArrayITD_EEG{s};
    %---------------------------------------
    % Is taking the mean appropriate?
    %---------------------------------------
    threshMeanITD_EEG(s) = mean(dataTmp.thresh);
end

% Extracting mean FM thresholds
dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'LeftEar');

threshMeanFMLeft = zeros(1, numSubj);
threshMeanFMRight = zeros(1, numSubj);
for s = 1:numSubj
    dataTmpLeft = dataArrayFMLeft{s};
    dataTmpRight = dataArrayFMRight{s};
    %---------------------------------------
    % Is taking the mean appropriate?
    %---------------------------------------
    threshMeanFMLeft(s) = mean(dataTmpLeft.thresh);
    threshMeanFMRight(s) = mean(dataTmpRight.thresh);
end

%% Correlation between the ITD and FM
figure;
%---------------------------------------
% Is taking the mean appropriate?
%---------------------------------------
threshMeanFM = (threshMeanFMRight + threshMeanFMLeft)/2; 
[corr_ITD_FM, p_ITD_FM] = corrcoef(threshMeanITD, threshMeanFM); 

plot(threshMeanFM', threshMeanITD', '+', 'LineWidth', 2); 
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
ylabel('ITD threshold [us]');
xlabel('FM threshold [Hz]');
title('ITD vs FM threshold');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITD_FM(1,2); p = p_ITD_FM(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), 'N = ', num2str(numSubj)}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

%% Correlation between the behavior ITD threshold and the EEG evoked response
figure;
evoked = [0.21, 0.48, 0.50, 0.58, 0.51, 0.43, 0.30, 0.55, 0.27, 0.43, 0.64, 0.47, 0.12]; % EEG evoked response (across conditions)
[corr_ITD_evoked, p_ITD_evoked] = corrcoef(threshMeanITD_EEG, evoked);

plot(threshMeanITD_EEG', evoked, '+', 'LineWidth', 2); 
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
ylabel('Normalized evoked response');
xlabel('FM threshold [Hz]');
title('ITD EEG vs behavior');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITD_evoked(1,2); p = p_ITD_evoked(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), num2str(numSubj_EEG)}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');