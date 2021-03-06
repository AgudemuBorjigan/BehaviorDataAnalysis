OS = 'Ubuntu'; 
rootDir = '/media/agudemu/Storage/Data/Behavior/';
%% Correlation between the ITD and FM
subjs_NH_ITD = {'S025','S031','S043','S046','S051','S072','S075','S078','S084','S117',...
    'S123','S127','S128','S132','S133','S135','S143','S149','S173','S174','S183',...
    'S185','S187','S188','S189','S191','S192','S193','S194','S195','S196','S197','S198','S199','S216','S218'};
subjs_NH_FM = {'S021','S024','S025','S028','S031','S043','S046','S051','S072',...
    'S075','S078','S083','S084','S117','S119','S123','S127','S128','S132',...
    'S133','S135','S139','S140','S142','S143','S144','S145','S149','S183',...
    'S185','S187','S188','S189','S191','S192','S193','S194','S195','S196',...
    'S197','S199','S216','S218'};
subjs_NH_Behavior = intersect(subjs_NH_ITD, subjs_NH_FM);
numSubj = numel(subjs_NH_Behavior);
threshMeanFMs = meanITD_FM(subjs_NH_Behavior, OS, 'FM', 'median');
threshMeanITD = meanITD_FM(subjs_NH_Behavior, OS, 'ITD3down1up', 'max'); % max: worst block
%---------------------------------------
% Mean FM between 2 ears is the best predictor of the ITD, worse ear FM is
% the next, then both ears 
%---------------------------------------
% whichWorse = threshMeanFMLeft < threshMeanFMRight;
% threshMeanFM = zeros(size(whichWorse));
% threshMeanFM(whichWorse) = threshMeanFMLeft(whichWorse);
% threshMeanFM(~whichWorse) = threshMeanFMRight(~whichWorse);
threshMeanFM = (threshMeanFMs{1} + threshMeanFMs{2})/2;
% threshMeanFM = max(threshMeanFMs{1}, threshMeanFMs{2});
[corr_ITD_FM, p_ITD_FM] = corrcoef(threshMeanITD, threshMeanFM);  

corrPlot(threshMeanFM, threshMeanITD, corr_ITD_FM, p_ITD_FM, numSubj, 'FM [dB relative to 1 Hz]', 'ITD [dB relative to 1 us]'...
    , 'ITD vs FM threshold')
%% Correlation between ERP latencies and ITD thresholds
subjsEEG_complete = subjNames('/media/agudemu/Storage/Data/EEG/ITD/');
subjs_EEG_ITD = intersect(subjs_NH_ITD, subjsEEG_complete);
subjs_EEG = {'S025', 'S031', 'S046', 'S117', 'S123', 'S127', 'S128', 'S132', 'S133', ...
    'S149', 'S051', 'S183', 'S187', 'S189', 'S193', 'S195', 'S196', 'S043', 'S072', 'S075', 'S078', ...
    'S135', 'S194', 'S197', 'S199', 'S191', 'S084', 'S129', 'S141', 'S190', 'S216', 'S218'}; % didn't include S143, S185, S192 from subjs_EEG_ITD
numSubj_EEG = numel(subjs_EEG);

threshITDwithEEG = meanITD_FM(subjs_EEG, OS, 'ITD3down1up', 'median');
% threshITDwithEEG = 10.^(threshITDwithEEG/20);
load('ERP_N1Lat_180');
load('ERP_P2Lat_180');
lat180 = (n1lat180 + p2lat180)/2;
lat180 = 20*log10(lat180*10e3);
[corr_ITD_n1lat180, p_ITD_n1lat180] = corrcoef(threshITDwithEEG, n1lat180);  
[corr_ITD_p2lat180, p_ITD_p2lat180] = corrcoef(threshITDwithEEG, p2lat180);  
[corr_ITD_lat180, p_ITD_lat180] = corrcoef(threshITDwithEEG, lat180);  

corrPlot(threshITDwithEEG, n1lat180, corr_ITD_n1lat180, p_ITD_n1lat180, numSubj_EEG, 'ITD [dB relative to 1 us]', 'N1 Latency'...
    , 'ITD vs N1 Latency, 180 us')
corrPlot(threshITDwithEEG, p2lat180, corr_ITD_p2lat180, p_ITD_p2lat180, numSubj_EEG, 'ITD [dB relative to 1 us]', 'P2 Latency'...
    , 'ITD vs P2 Latency, 180 us')
corrPlot(threshITDwithEEG, lat180, corr_ITD_lat180, p_ITD_lat180, numSubj_EEG, 'ITD [dB relative to 1 us]', 'Latency [dB relative to 1 ms]'...
    , 'ITD vs Average of N1 and P2 Latencies, ITD = 180 us')
%% Correlation between the behavior ITD threshold and the EEG evoked response
load('ERP60');
load('ERP180');
load('ERP540');
load('ERPavgExd20');
[corr_ITD_erp180, p_ITD_erp180] = corrcoef(threshITDwithEEG, erp180);
[corr_ITD_erp540, p_ITD_erp540] = corrcoef(threshITDwithEEG, erp540);
[corr_ITD_erpAvgExd20, p_ITD_erpAvgExd20] = corrcoef(threshITDwithEEG, erpAvgExd20);

corrPlot(threshITDwithEEG, erp180, corr_ITD_erp180, p_ITD_erp180, numSubj_EEG, 'ITD threshold [dB relative to us]'...
    , 'Normalized ITD-evoked response', 'ITD behavior thresholds vs EEG ITD-evoked response, 180 us');
corrPlot(threshITDwithEEG, erp540, corr_ITD_erp540, p_ITD_erp540, numSubj_EEG, 'ITD threshold [dB relative to us]'...
    , 'Normalized ITD-evoked response', 'ITD behavior thresholds vs EEG ITD-evoked response, 540 us');
corrPlot(threshITDwithEEG, erpAvgExd20, corr_ITD_erpAvgExd20, p_ITD_erpAvgExd20, numSubj_EEG, 'ITD threshold [dB relative to us]'...
    , 'Normalized ITD-evoked response', 'ITD behavior thresholds vs EEG ITD-evoked response, ERP avg with no 20 us');

%% Correlation between the behavior ITD sensitivity (slope) and slope of EEG vs ITD plot
sensitivityEEG = abs(erp180 - erp60);
sensitivityEEG = sensitivityEEG(~isnan(sensitivityEEG));
subjs_EEG = subjs_EEG(~isnan(sensitivityEEG));
[threshEst, sensitivityBehavior] = psychFctn(OS, subjs_EEG, 'ITD3down1up', 'Both');
[corr_ITDsen, p_ITDsen] = corrcoef(sensitivityBehavior, sensitivityEEG);
corrPlot(sensitivityBehavior, sensitivityEEG, corr_ITDsen, p_ITDsen, numel(subjs_EEG), 'ITD sensitivity (behavior)', 'ITD sensitivity (EEG)'...
    , 'Slope of ITD behavior thresholds vs EEG magnitudes');
%% Correlation between FFR and behavior ITD thresholds
subjs_EEG_FFR_complete = subjNames('/media/agudemu/Storage/Data/EEG/FFR/');
subjs_EEG_FFR = {'S025','S031','S043','S051','S072','S075','S084','S117', 'S123', 'S127','S128','S132','S133',...
    'S149','S183','S185','S187','S190','S191','S194','S195','S196','S197','S216'}; % S123[A16, A24 bad chann]
% S199 (memory problem), S218, S129[A23 chann], S078[A24 bad chann] (not sure if these can be used)
numSubj_FFR = numel(subjs_EEG_FFR);
load('FFR_mag1K_sum');
% FFR_mag500 = p5m_win';
threshMeanITD_FFR = meanITD_FM(subjs_EEG_FFR, OS, 'ITD3down1up', 'mean');
threshMeanFMs_FFR = meanITD_FM(subjs_EEG_FFR, OS, 'FM', 'mean');
threshMeanFM_FFR = (threshMeanFMs_FFR{1} + threshMeanFMs_FFR{2})/2;

[corr_ITD_FFR1K, p_ITD_FFR1K] = corrcoef(threshMeanITD_FFR, 20*log10(FFR_mag1K_sum));
[corr_FM_FFR1K, p_FM_FFR1K] = corrcoef(threshMeanFM_FFR, 20*log10(FFR_mag1K_sum));
% [corr_ITD_FFR500, p_ITD_FFR500] = corrcoef(threshMeanITD_FFR, FFR_mag500);

corrPlot(threshMeanITD_FFR, 20*log10(FFR_mag1K_sum), corr_ITD_FFR1K, p_ITD_FFR1K, numSubj_FFR, 'ITD [dB relative to 1 us]', 'FFR FFT magnitude @ 1KHz'...
    , 'ITD Threshold vs FFR FFT mag (1KHz)');
corrPlot(threshMeanFM_FFR, 20*log10(FFR_mag1K_sum), corr_FM_FFR1K, p_FM_FFR1K, numSubj_FFR, 'FM [dB relative to 1 Hz]', 'FFR FFT magnitude @ 1KHz'...
    , 'FM Threshold vs FFR FFT mag (1KHz)');
% corrPlot(threshMeanITD_FFR, FFR_mag500, corr_ITD_FFR500, p_ITD_FFR500, numSubj_FFR, 'ITD [dB relative to 1 us]', 'FFR FFT magnitude @ 1KHz'...
%     , 'ITD vs FFR mag (500 Hz)');

