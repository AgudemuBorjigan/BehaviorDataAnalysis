OS = 'Mac'; 

subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S143', ...
    'S149', 'S051', 'S183', 'S185', 'S187', 'S189', 'S193', 'S195', 'S196', 'S043', 'S072', 'S075', 'S078', 'S135', ...
    'S192', 'S194', 'S197', 'S199', 'S173', 'S084', 'S191'};  

numSubj = numel(subjs);
% keeping track of index corresponding to different day testing
ddIndex = [];
for s = 1:numel(subjs)
    subjID = subjs{s};
    if strcmp(subjID(end-1:end), 'DD')
        ddIndex = [ddIndex, s-1, s]; %#ok<AGROW>
    end
end

%% Correlation between the ITD and FM
[threshMeanITD, threshMeanFMLeft, threshMeanFMRight] = meanITD_FM(subjs, OS);
%---------------------------------------
% Mean FM between 2 ears is the best predictor of the ITD, worse ear FM is
% the next, then both ears 
%---------------------------------------
% whichWorse = threshMeanFMLeft < threshMeanFMRight;
% threshMeanFM = zeros(size(whichWorse));
% threshMeanFM(whichWorse) = threshMeanFMLeft(whichWorse);
% threshMeanFM(~whichWorse) = threshMeanFMRight(~whichWorse);
threshMeanFM = (threshMeanFMLeft + threshMeanFMRight)/2;
[corr_ITD_FM, p_ITD_FM] = corrcoef(threshMeanITD, threshMeanFM);  

corrPlot(threshMeanFM, threshMeanITD, corr_ITD_FM, p_ITD_FM, numSubj, 'FM threshold [dB relative to Hz]', 'ITD threshold [dB relative to us]'...
    , 'ITD vs FM threshold')
% labeling the different day testing points with different colors
for s = 1: numel(ddIndex)/2 % ddIndex includes 2 indexes for the same subject
    scatter(threshMeanFM(ddIndex((s-1)*2 + 1))', threshMeanITD(ddIndex((s-1)*2 + 1))', 'sr');
    scatter(threshMeanFM(ddIndex((s-1)*2 + 2))', threshMeanITD(ddIndex((s-1)*2 + 2))', 'or');
    hold on;
end
%% Correlation between the ITD and 'normalized' asymmetry in FM thresholds
FMdiff_norm = abs(threshMeanFMLeft - threshMeanFMRight)./threshMeanFM;
[corr_ITD_FMdiff, p_ITD_FMdiff] = corrcoef(threshMeanITD, FMdiff_norm);

corrPlot(FMdiff_norm, threshMeanITD, corr_ITD_FMdiff, p_ITD_FMdiff, numSubj, 'Normalized asymmetry in FM thresholds [dB]',...
    'ITD threshold [dB relative to us]', 'ITD vs normalized FM asymmetry');

%% Correlation between the FM and HL (500 Hz and 4 KHz)
subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S143', ...
    'S149', 'S051', 'S183', 'S185', 'S187', 'S189', 'S193', 'S195', 'S196', 'S043', 'S072', 'S075', 'S078', 'S135', ...
    'S192', 'S194', 'S197', 'S199', 'S084', 'S191'}; %'S173'(doesn't have Audiometry or EEG)
numSubj = numel(subjs);
[threshMeanITD, threshMeanFMLeft, threshMeanFMRight] = meanITD_FM(subjs, OS);
%--------------------------------------------------------------------------------------------
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

% putting them all together in an array for the convenience of plotting
% correlation plot selectively by indexing
FMarray = {threshMeanFMLeft, threshMeanFMRight};
HLarray = {HLLeft_500Hz, HLLeft_4KHz, HLRight_500Hz, HLRight_4KHz};
corrArray = {corrFM_HLleft500, corrFM_HLleft4000, corrFM_HLRight500, corrFM_HLRight4000};
pArray = {pFM_HLleft500, pFM_HLleft4000, pFM_HLRight500, pFM_HLRight4000};


HL = HLarray{1}; FM = FMarray{1};
corr = corrArray{1}; p = pArray{1};

corrPlot(HL, FM, corr, p, numSubj, 'Hearing level [dbSPL]', 'FM threshold [Hz]', 'FM vs HL');

%% Correlation between the behavior ITD threshold and the EEG evoked response
%-----------------------------------------------------------------------------
evoked = [0.16, 0.53, 0.34, 0.9, 0.51, 0.74, 0.23, 0.5, 0.48, 0.46, 0.78, 0.32, 0.61, 0.38, 0.66, 0.54, 0.09, 0.47...
    ,0.49, 0.45, 0.56, 0.12, 0.53, 0.58, 0.7, 0.31, 0.99, 0.45, 0.34, 0.31]; % EEG evoked response (across conditions)
[corr_ITD_evoked, p_ITD_evoked] = corrcoef(threshMeanITD', evoked);

corrPlot(threshMeanITD, evoked, corr_ITD_evoked, p_ITD_evoked, numSubj, 'ITD threshold [dB relative to us]'...
    , 'Normalized ITD-evoked response', 'ITD behavior thresholds vs EEG ITD-evoked response');
%% correlation between FM and PLV
subjs = {'S031', 'S117', 'S123', 'S128', 'S132', 'S149', 'S185', 'S187', 'S191', 'S194', 'S196', 'S197'};%, 'S185', 'S187', 'S196', 'S197'};% 'S196', 'S197': really large values
[threshMeanITD, threshMeanFMLeft, threshMeanFMRight] = meanITD_FM(subjs, OS);
numSubj = numel(subjs);
%---------------------------------------------------------------------------------------------------
threshMeanFM = (threshMeanFMLeft + threshMeanFMRight)/2;
plvs = [4.5, 8.38, 4.99, 2.83, 2.62, 6.29, 5.75, 5.79, 11.94, 3.27, 12.37, 3.88];
[corr_FM_plv, p_FM_plv] = corrcoef(threshMeanFM, plvs);
corrPlot(threshMeanFM, plvs, corr_FM_plv, p_FM_plv, numSubj, 'FM threshold [dB relative to us]'...
    , 'Phase locking value', 'FM behavior thresholds vs EEG PLVs');