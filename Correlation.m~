% subjs = {'Rav', 'S116', 'Anna', 'S117', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084'}; 
subjs = {'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084'}; % subjects with EEG recording ...
% excluding S117 (extremely high evoked response), which corrected the corr
% between the EEG and behavior to negative, and increased the corr between
% the ITD and FM
numSubj = numel(subjs);

% Extracting mean ITD thresholds
dataArrayITD = dataExtraction(subjs, 'Ubuntu', 'ITD3down1up', 'BothEar');

threshMeanITD = zeros(1, numSubj);
for s = 1:numSubj
    dataTmp = dataArrayITD{s};
    threshMeanITD(s) = mean(dataTmp.thresh);% Is taking the mean appropriate?
end

% Extracting mean FM thresholds
dataArrayFMLeft = dataExtraction(subjs, 'Ubuntu', 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, 'Ubuntu', 'FM', 'LeftEar');

threshMeanFMLeft = zeros(1, numSubj);
threshMeanFMRight = zeros(1, numSubj);
for s = 1:numSubj
    dataTmpLeft = dataArrayFMLeft{s};
    dataTmpRight = dataArrayFMRight{s};
    threshMeanFMLeft(s) = mean(dataTmpLeft.thresh);% Is taking the mean appropriate?
    threshMeanFMRight(s) = mean(dataTmpRight.thresh);% Is taking the mean appropriate?
end

%% Correlation between the ITD and FM
figure;
threshMeanFM = (threshMeanFMRight + threshMeanFMLeft)/2; % Is taking the mean of two ears appropriate?
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
evoked = [0.19, 0.47, 0.49, 0.57, 0.5, 0.42, 0.29]; % EEG evoked response (across conditions)
[corr_ITD_evoked, p_ITD_evoked] = corrcoef(threshMeanITD, evoked);

plot(threshMeanITD', evoked, '+', 'LineWidth', 2); 
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
ylabel('Normalized evoked response');
xlabel('FM threshold [Hz]');
title('ITD EEG vs behavior');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITD_evoked(1,2); p = p_ITD_evoked(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), num2str(numSubj)}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');




