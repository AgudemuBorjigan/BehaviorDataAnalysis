OS = 'Ubuntu';

subjs = {'S078', 'S117', 'S128', 'S132', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075', 'S135'}; 
ddIndex = [];
for s = 1:numel(subjs)
    subjID = subjs{s};
    if strcmp(subjID(end-1:end), 'DD')
        ddIndex = [ddIndex, s-1, s]; %#ok<AGROW>
    end
end
%-----------------------------------------------------------------------------
% subjects with EEG recording ...
% excluding S117 (extremely high evoked response), which corrected the corr
% between the EEG and behavior to negative, and increased the corr between
%-----------------------------------------------------------------------------
subjs_EEG = {'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S075', 'S135'}; 
% the ITD and FM
numSubj = numel(subjs);
numSubj_EEG = numel(subjs_EEG);

% Extracting mean ITD thresholds
dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
threshMeanITD = zeros(1, numSubj);
for s = 1:numSubj
    dataTmp = dataArrayITD{s};
    %---------------------------------------
    % Taking the mean is appropriate, since there is no block effects from
    % linear regression analysis
    %---------------------------------------
    threshMeanITD(s) = mean(dataTmp.thresh);
end

dataArrayITD_EEG = dataExtraction(subjs_EEG, OS, 'ITD3down1up', 'BothEar');
threshMeanITD_EEG = zeros(1, numSubj_EEG);
for s = 1:numSubj_EEG
    dataTmp = dataArrayITD_EEG{s};
    %---------------------------------------
    % Taking the mean is appropriate, since there is no block effects from
    % linear regression analysis
    %---------------------------------------
    threshMeanITD_EEG(s) = mean(dataTmp.thresh);
end

% Extracting mean FM thresholds
dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'RightEar');

threshMeanFMLeft = zeros(1, numSubj);
threshMeanFMRight = zeros(1, numSubj);
for s = 1:numSubj
    dataTmpLeft = dataArrayFMLeft{s};
    dataTmpRight = dataArrayFMRight{s};
    %---------------------------------------
    % Taking the mean is appropriate since there are only 4 blocks
    %---------------------------------------
    threshMeanFMLeft(s) = mean(dataTmpLeft.thresh);
    threshMeanFMRight(s) = mean(dataTmpRight.thresh);
end

%% Correlation between the ITD and FM
figure;
%---------------------------------------
% Mean FM between 2 ears is the best predictor of the ITD, worse ear FM is
% the next, then both ears 
%---------------------------------------
% whichWorse = threshMeanFMLeft < threshMeanFMRight;
% threshMeanFM = zeros(size(whichWorse));
% threshMeanFM(whichWorse) = threshMeanFMLeft(whichWorse);
% threshMeanFM(~whichWorse) = threshMeanFMRight(~whichWorse);
threshMeanFM = (threshMeanFMLeft + threshMeanFMRight)/2;
[corr_ITD_FM, p_ITD_FM] = corrcoef(log10(threshMeanITD), log10(threshMeanFM)); 

plot(log10(threshMeanFM'), log10(threshMeanITD'), '+', 'LineWidth', 2); 
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
% labeling the different day testing points with different colors
for s = 1: numel(ddIndex)/2
    scatter(threshMeanFM(ddIndex((s-1)*2 + 1))', threshMeanITD(ddIndex((s-1)*2 + 1))', 'sr');
    scatter(threshMeanFM(ddIndex((s-1)*2 + 2))', threshMeanITD(ddIndex((s-1)*2 + 2))', 'or');
    hold on;
end

ylabel('ITD threshold [us]');
xlabel('FM threshold [Hz]');
title('ITD vs FM threshold');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITD_FM(1,2); p = p_ITD_FM(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), 'N = ', num2str(numSubj)}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

%% Correlation between the FM and HL (500 Hz and 4 KHz)
dataArrayHL_left = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
dataArrayHL_right = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');
HLLeft_500Hz = zeros(1, numSubj);
HLRight_500Hz = zeros(1, numSubj);
HLLeft_4KHz = zeros(1, numSubj);
HLRight_4KHz = zeros(1, numSubj);
for s = 1:numSubj
    HLTmp = dataArrayHL_left{s}.thresh;
    freqTmp = dataArrayHL_left{s}.freqs;
    HLLeft_500Hz(s) = HLTmp(freqTmp == 500);
    HLLeft_4KHz(s) = HLTmp(freqTmp == 4000);
    
    HLTmp = dataArrayHL_right{s}.thresh;
    freqTmp = dataArrayHL_right{s}.freqs;
    HLRight_500Hz(s) = HLTmp(freqTmp == 500);
    HLRight_4KHz(s) = HLTmp(freqTmp == 4000);
end

[corrFM_HLleft500, pFM_HLleft500] = corrcoef(threshMeanFMLeft, HLLeft_500Hz); 
[corrFM_HLleft4000, pFM_HLleft4000] = corrcoef(threshMeanFMLeft, HLLeft_4KHz); 
[corrFM_HLRight500, pFM_HLRight500] = corrcoef(threshMeanFMRight, HLRight_500Hz); 
[corrFM_HLRight4000, pFM_HLRight4000] = corrcoef(threshMeanFMRight, HLRight_4KHz); 

FMarray = {threshMeanFMLeft, threshMeanFMRight};
HLarray = {HLLeft_500Hz, HLLeft_4KHz, HLRight_500Hz, HLRight_4KHz};
corrArray = {corrFM_HLleft500(1,2), corrFM_HLleft4000(1,2), corrFM_HLRight500(1,2), corrFM_HLRight4000(1,2)};
pArray = {pFM_HLleft500(1,2), pFM_HLleft4000(1,2), pFM_HLRight500(1,2), pFM_HLRight4000(1,2)};


HL = HLarray{1}; FM = FMarray{1};
corr = corrArray{1}; p = pArray{1};

figure;
plot(HL, FM, '+', 'LineWidth', 2); 
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
ylabel('FM threshold [Hz]');
xlabel('Hearing level [dbSPL]');
title('FM vs HL');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), 'N = ', num2str(numSubj)}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');


%% Correlation between the behavior ITD threshold and the EEG evoked response
figure;
evoked = [0.21, 0.48, 0.50, 0.58, 0.51, 0.43, 0.30, 0.55, 0.27, 0.43, 0.64, 0.47, 0.12, 0.57]; % EEG evoked response (across conditions)
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
