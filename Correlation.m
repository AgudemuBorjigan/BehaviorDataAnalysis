OS = 'Ubuntu'; 

subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S135', 'S143', ...
    'S149', 'S173', 'S051', 'S183', 'S185', 'S187', 'S189', 'S192', 'S193', 'S194', 'S195', 'S196', 'S197', 'S199',...
    'S043', 'S072', 'S075', 'S078', 'S084', 'S191'};  % 'S190', 'S198' only completed ITD

% subjs = {'S046', 'S123', 'S127', 'S128', 'S132', 'S133', 'S143', 'S149', 'S183', 'S185', 'S196', 'S075', 'S084'}; % subjects with 0% 
% easy mistakes in both tasks

numSubj = numel(subjs);

%% Correlation between the ITD and FM
threshMeanFMs = meanITD_FM(subjs, OS, 'FM', 'median');
threshMeanITD = meanITD_FM(subjs, OS, 'ITD3down1up', 'median');
%---------------------------------------
% Mean FM between 2 ears is the best predictor of the ITD, worse ear FM is
% the next, then both ears 
%---------------------------------------
% whichWorse = threshMeanFMLeft < threshMeanFMRight;
% threshMeanFM = zeros(size(whichWorse));
% threshMeanFM(whichWorse) = threshMeanFMLeft(whichWorse);
% threshMeanFM(~whichWorse) = threshMeanFMRight(~whichWorse);
threshMeanFM = (threshMeanFMs{1} + threshMeanFMs{2})/2;
[corr_ITD_FM, p_ITD_FM] = corrcoef(threshMeanITD, threshMeanFM);  

corrPlot(threshMeanFM, threshMeanITD, corr_ITD_FM, p_ITD_FM, numSubj, 'FM [dB relative to 1 Hz]', 'ITD [dB relative to 1 us]'...
    , 'ITD vs FM threshold')
%% Correlation between ERP latencies and ITD thresholds
subjs_EEG = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', ...
    'S149', 'S051', 'S183', 'S187', 'S189', 'S193', 'S195', 'S196', 'S043', 'S072', 'S075', 'S078', ...
    'S135', 'S194', 'S197', 'S199', 'S191', 'S084'}; % didn't include S149, S185, S192

numSubj_EEG = numel(subjs_EEG);
threshMeanITDwithEEG = meanITD_FM(subjs_EEG, OS, 'ITD3down1up', 'median');
% ERP_N1Lat_540us, ERP_P2Lat_540us, ERP_N1Lat_avg, ERP_P2Lat_avg
load('ERP_N1Lat_180');
load('ERP_P2Lat_180');
load('ERP_N1Lat_540');
load('ERP_P2Lat_540');
load('ERP_N1Lat_AvgExd20');
load('ERP_P2Lat_AvgExd20');
lat180 = (n1lat180 + p2lat180)/2;
lat540 = (n1lat540 + p2lat540)/2;
latAvgExd20 = (n1latAvgExd20 + p2latAvgExd20)/2;
[corr_ITD_n1lat180, p_ITD_n1lat180] = corrcoef(threshMeanITDwithEEG, n1lat180);  
[corr_ITD_p2lat180, p_ITD_p2lat180] = corrcoef(threshMeanITDwithEEG, p2lat180);  
[corr_ITD_lat180, p_ITD_lat180] = corrcoef(threshMeanITDwithEEG, lat180);  
[corr_ITD_n1lat540, p_ITD_n1lat540] = corrcoef(threshMeanITDwithEEG, n1lat540);  
[corr_ITD_p2lat540, p_ITD_p2lat540] = corrcoef(threshMeanITDwithEEG, p2lat540);  
[corr_ITD_lat540, p_ITD_lat540] = corrcoef(threshMeanITDwithEEG, lat540);  
[corr_ITD_n1latAvgExd20, p_ITD_n1latAvgExd20] = corrcoef(threshMeanITDwithEEG, n1latAvgExd20);  
[corr_ITD_p2latAvgExd20, p_ITD_p2latAvgExd20] = corrcoef(threshMeanITDwithEEG, p2latAvgExd20);  
[corr_ITD_latAvgExd20, p_ITD_latAvgExd20] = corrcoef(threshMeanITDwithEEG, latAvgExd20);  


corrPlot(threshMeanITDwithEEG, n1lat180, corr_ITD_n1lat180, p_ITD_n1lat180, numSubj_EEG, 'ITD [dB relative to 1 us]', 'N1 Latency'...
    , 'ITD vs N1 Latency, 180 us')
corrPlot(threshMeanITDwithEEG, p2lat180, corr_ITD_p2lat180, p_ITD_p2lat180, numSubj_EEG, 'ITD [dB relative to 1 us]', 'P2 Latency'...
    , 'ITD vs P2 Latency, 180 us')
corrPlot(threshMeanITDwithEEG, lat180, corr_ITD_lat180, p_ITD_lat180, numSubj_EEG, 'ITD [dB relative to 1 us]', 'Average latency'...
    , 'ITD vs Average latency, 180 us')
corrPlot(threshMeanITDwithEEG, n1lat540, corr_ITD_n1lat540, p_ITD_n1lat540, numSubj_EEG, 'ITD [dB relative to 1 us]', 'N1 Latency'...
    , 'ITD vs N1 Latency, 540 us')
corrPlot(threshMeanITDwithEEG, p2lat540, corr_ITD_p2lat540, p_ITD_p2lat540, numSubj_EEG, 'ITD [dB relative to 1 us]', 'P2 Latency'...
    , 'ITD vs P2 Latency, 540 us')
corrPlot(threshMeanITDwithEEG, lat540, corr_ITD_lat540, p_ITD_lat540, numSubj_EEG, 'ITD [dB relative to 1 us]', 'Average latency'...
    , 'ITD vs Average latency, 540 us')
corrPlot(threshMeanITDwithEEG, n1latAvgExd20, corr_ITD_n1latAvgExd20, p_ITD_n1latAvgExd20, numSubj_EEG, 'ITD [dB relative to 1 us]', 'N1 Latency'...
    , 'ITD vs N1 Latency, Avg with no 20 us')
corrPlot(threshMeanITDwithEEG, p2latAvgExd20, corr_ITD_p2latAvgExd20, p_ITD_p2latAvgExd20, numSubj_EEG, 'ITD [dB relative to 1 us]', 'P2 Latency'...
    , 'ITD vs P2 Latency, Avg with no 20 us')
corrPlot(threshMeanITDwithEEG, lat540, corr_ITD_lat540, p_ITD_lat540, numSubj_EEG, 'ITD [dB relative to 1 us]', 'Average latency'...
    , 'ITD vs Average latency, Avg with no 20 us')

%% Correlation between the behavior ITD threshold and the EEG evoked response
load('ERP180');
load('ERP540');
load('ERPavgExd20');
[corr_ITD_erp180, p_ITD_erp180] = corrcoef(threshMeanITDwithEEG, erp180);
[corr_ITD_erp540, p_ITD_erp540] = corrcoef(threshMeanITDwithEEG, erp540);
[corr_ITD_erpAvgExd20, p_ITD_erpAvgExd20] = corrcoef(threshMeanITDwithEEG, erpAvgExd20);

corrPlot(threshMeanITDwithEEG, erp180, corr_ITD_erp180, p_ITD_erp180, numSubj_EEG, 'ITD threshold [dB relative to us]'...
    , 'Normalized ITD-evoked response', 'ITD behavior thresholds vs EEG ITD-evoked response, 180 us');
corrPlot(threshMeanITDwithEEG, erp540, corr_ITD_erp540, p_ITD_erp540, numSubj_EEG, 'ITD threshold [dB relative to us]'...
    , 'Normalized ITD-evoked response', 'ITD behavior thresholds vs EEG ITD-evoked response, 540 us');
corrPlot(threshMeanITDwithEEG, erpAvgExd20, corr_ITD_erpAvgExd20, p_ITD_erpAvgExd20, numSubj_EEG, 'ITD threshold [dB relative to us]'...
    , 'Normalized ITD-evoked response', 'ITD behavior thresholds vs EEG ITD-evoked response, ERP avg with no 20 us');

%% Correlation between the ITD and 'normalized' asymmetry in FM thresholds
% FMdiff_norm = abs(threshMeanFMs{1} - threshMeanFMs{2})./threshMeanFM;
% [corr_ITD_FMdiff, p_ITD_FMdiff] = corrcoef(threshMeanITD, FMdiff_norm);
% 
% corrPlot(FMdiff_norm, threshMeanITD, corr_ITD_FMdiff, p_ITD_FMdiff, numSubj, 'Normalized asymmetry in FM thresholds [dB]',...
%     'ITD threshold [dB relative to us]', 'ITD vs normalized FM asymmetry');

%% Correlation between the FM and HL (500 Hz and 4 KHz)
% subjs = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', 'S143', ...
%     'S149', 'S051', 'S183', 'S185', 'S187', 'S189', 'S193', 'S195', 'S196', 'S043', 'S072', 'S075', 'S078', 'S135', ...
%     'S192', 'S194', 'S197', 'S199', 'S084', 'S191'}; %'S173'(doesn't have Audiometry or EEG)
% numSubj = numel(subjs);
% threshMeanFMs = meanITD_FM(subjs, OS, 'FM');
% %--------------------------------------------------------------------------------------------
% dataArrayHL_left = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
% dataArrayHL_right = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');
% HLLeft_500Hz = zeros(1, numSubj);
% HLRight_500Hz = zeros(1, numSubj);
% HLLeft_4KHz = zeros(1, numSubj);
% HLRight_4KHz = zeros(1, numSubj);
% for s = 1:numSubj
%     HLTmp = dataArrayHL_left{s}.thresh;
%     freqTmp = dataArrayHL_left{s}.freqs;
%     HLLeft_500Hz(s) = HLTmp(freqTmp == 500);
%     HLLeft_4KHz(s) = HLTmp(freqTmp == 4000);
%     
%     HLTmp = dataArrayHL_right{s}.thresh;
%     freqTmp = dataArrayHL_right{s}.freqs;
%     HLRight_500Hz(s) = HLTmp(freqTmp == 500);
%     HLRight_4KHz(s) = HLTmp(freqTmp == 4000);
% end
% threshMeanFMLeft = threshMeanFMs{1};
% threshMeanFMRight = threshMeanFMs{2};
% [corrFM_HLleft500, pFM_HLleft500] = corrcoef(threshMeanFMLeft, HLLeft_500Hz); 
% [corrFM_HLleft4000, pFM_HLleft4000] = corrcoef(threshMeanFMLeft, HLLeft_4KHz); 
% [corrFM_HLRight500, pFM_HLRight500] = corrcoef(threshMeanFMRight, HLRight_500Hz); 
% [corrFM_HLRight4000, pFM_HLRight4000] = corrcoef(threshMeanFMRight, HLRight_4KHz); 
% 
% % putting them all together in an array for the convenience of plotting
% % correlation plot selectively by indexing
% FMarray = {threshMeanFMLeft, threshMeanFMRight};
% HLarray = {HLLeft_500Hz, HLLeft_4KHz, HLRight_500Hz, HLRight_4KHz};
% corrArray = {corrFM_HLleft500, corrFM_HLleft4000, corrFM_HLRight500, corrFM_HLRight4000};
% pArray = {pFM_HLleft500, pFM_HLleft4000, pFM_HLRight500, pFM_HLRight4000};
% 
% 
% HL = HLarray{1}; FM = FMarray{1};
% corr = corrArray{1}; p = pArray{1};
% 
% corrPlot(HL, FM, corr, p, numSubj, 'Hearing level [dbSPL]', 'FM threshold [Hz]', 'FM vs HL');
% 
%% correlation between FM and PLV
% subjs = {'S031', 'S117', 'S123', 'S128', 'S132', 'S149', 'S185', 'S187', 'S191', 'S194', 'S196', 'S197'};%, 'S185', 'S187', 'S196', 'S197'};% 'S196', 'S197': really large values
% threshMeanFMs = meanITD_FM(subjs, OS, 'FM');
% numSubj = numel(subjs);
% %---------------------------------------------------------------------------------------------------
% threshMeanFM = (threshMeanFMs{1} + threshMeanFMs{2})/2;
% plvs = [0.0055, 0.0078, 0.054, 0.0055, 0.0017, 0.0046, 0.0216, 0.0320, 0.0084, 0.0036, 0.0177, 0.0132];
% % evoked = [0.53, 0.9, 0.51, 0.23, 0.5, 0.78, 0.38, 0.66, 0.34, 0.31, 0.49, 0.99];
% evoked = [0.78, 1.17, 0.73, 0.5, 0.88, 1.75, 0.79, 1.43, 0.71, 0.62, 0.93, 2.13];
% [corr_FM_plv, p_FM_plv] = corrcoef(threshMeanFM, plvs);
% [corr_evoked_plv, p_evoked_plv] = corrcoef(evoked, plvs);
% corrPlot(threshMeanFM, plvs, corr_FM_plv, p_FM_plv, numSubj, 'FM threshold [dB relative to us]'...
%     , 'Phase locking value', 'FM behavior thresholds vs EEG PLVs');
% corrPlot(evoked, plvs, corr_evoked_plv, p_evoked_plv, numSubj, 'Normalized ITD-evoked response'...
%     , 'Phase locking value', 'ITD-evoked response vs PLVs');