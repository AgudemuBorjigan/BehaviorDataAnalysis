OS = 'Ubuntu';
rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_ITD = subjNames(strcat(rootDir, 'ITD'));
rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_FM = subjNames(strcat(rootDir, 'FM'));
rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_Audiogram = subjNames(strcat(rootDir, 'Audiogram'));
rootDir = '/media/agudemu/Storage/Data/EEG/';
subjs_ITD_EEG = subjNames(strcat(rootDir, 'ITD'));
rootDir = '/media/agudemu/Storage/Data/EEG/';
subjs_FFR = subjNames(strcat(rootDir, 'FFR'));
rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_HI = audiogramPop(rootDir, OS);
subjs_OD = {'S216', 'S218'};

subjs_Audiogram_FM = intersect(subjs_Audiogram, subjs_FM);
subjs_behavior = intersect(subjs_Audiogram_FM, subjs_ITD);
subjs_EEG_ITD_behavior = intersect(subjs_behavior, subjs_ITD_EEG); 
subjs_EEG_ITD_behavior_HI = intersect(subjs_EEG_ITD_behavior, subjs_HI);
subjs_EEG_ITD_behavior_NH = setdiff(subjs_EEG_ITD_behavior, subjs_EEG_ITD_behavior_HI);
subjs_All = intersect(subjs_EEG_ITD_behavior_NH, subjs_FFR);   

%% Behavior & EEG (ITD&FFR) dataset
fid = fopen('dataSetBehaviorEEG_All.csv', 'w');
fprintf(fid, 'Subject, ITDmean, ITDmedian, ITDmin, ITDmax, FMleft, FMright, 500Hzleft, 500Hzright, block, mistakeITD, mistakeFMLeft, mistakeFMRight, FFRmag1K, ERPn1lat180, ERPp2lat180, ERPn1lat60, ERPp2lat60, ERPn1lat540, ERPp2lat540, ERPn1latAvgNo20, ERPp2latAvgNo20\n');
%mistakeITD, mistakeFMleft, mistakeFMright
%mag20us, mag60us, mag180us, mag540us, magAvg, magAvgExcld20us, n1lat20us, n1lat60us, n1lat180us, n1lat540us, n1latAvg, n1latAvgExcld20, p2lat20us, p2lat60us, p2lat180us, p2lat540us, p2latAvg, p2latAvgExcld20, itc20, itc60, itc180, itc540, itcAvg, itcAvgExd20, itclat20, itclat60, itclat180, itclat540, itclatAvg, itclatAvgExd20, itc20left, itc60left, itc180left, itc540left, itcAvgleft, itcAvgExd20left, itclat20left, itclat60left, itclat180left, itclat540left, itclatAvgleft, itclatAvgExd20left, itc20right, itc60right, itc180right, itc540right, itcAvgright, itcAvgExd20right, itclat20right, itclat60right, itclat180right, itclat540right, itclatAvgright, itclatAvgExd20right
numSubj = numel(subjs_All);
dataArrayHL_left = dataExtraction(subjs_All, OS, 'Audiogram', 'LeftEar');
dataArrayHL_right = dataExtraction(subjs_All, OS, 'Audiogram', 'RightEar');
subj = cell(1, 1);
load('FFR_mag1K_NH'); % variable: FFR_mag1K_NH
load('ERP_n1lat180_NH');% variable: erp_n1lat180
load('ERP_p2lat180_NH');% variable: erp_p2lat180
load('ERP_p2lat60_NH');% variable: erp_p2lat60
load('ERP_n1lat60_NH');% variable: erp_n1lat60
load('ERP_p2lat540_NH');% variable: erp_p2lat540
load('ERP_n1lat540_NH');% variable: erp_n1lat540
load('ERP_p2latAvgNo20_NH');% variable: erp_p2latAvgNo20
load('ERP_n1latAvgNo20_NH');% variable: erp_n1latAvgNo20
for s = 1:numSubj
    subj{1} = subjs_All{s};
    % ITD
    ITDs_tmp = dataExtraction(subj, OS, 'ITD3down1up', 'BothEar');
    ITDs = ITDs_tmp{1}.thresh;
    ITD_mean = mean(ITDs, 2);
    ITD_median = median(ITDs);
    ITD_max = max(ITDs);
    ITD_min = min(ITDs);
    percentITD = obvsMistkCntr(ITDs_tmp{1}, 'ITD');
    % FM left
    FMs_Left_tmp = dataExtraction(subj, OS, 'FM', 'LeftEar');
    FMleft_tmp = FMs_Left_tmp{1}.thresh;
    FMleft = median(FMleft_tmp);
    percentFM_left = obvsMistkCntr(FMs_Left_tmp{1}, 'FM');
    % FM right
    FMs_Right_tmp = dataExtraction(subj, OS, 'FM', 'RightEar');
    FMright_tmp = FMs_Right_tmp{1}.thresh;
    FMright = median(FMright_tmp);
    percentFM_right = obvsMistkCntr(FMs_Right_tmp{1}, 'FM');
    % Audiogram
    HLleft = dataArrayHL_left{s}.thresh;
    HLright = dataArrayHL_right{s}.thresh;
    freqs = dataArrayHL_left{s}.freqs;
    for b = 1
        fprintf(fid, '%s, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f', ...
            subjs_All{s}, ITD_mean, ITD_median, ITD_min, ITD_max, FMleft, FMright, HLleft(freqs == 500), HLright(freqs == 500), b, percentITD, percentFM_left, percentFM_right, ...
            FFR_mag1K_NH(s), ...
            erp_n1lat180(s), erp_p2lat180(s), erp_n1lat60(s), erp_p2lat60(s), erp_n1lat540(s), erp_p2lat540(s), erp_n1latAvgNo20(s), erp_p2latAvgNo20(s));
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');
end

% %% Behavior FM and ITD
% fid = fopen('dataSetBehavior.csv', 'w');
% fprintf(fid, 'Subject, ITDmean, ITDmedian, ITDmin, ITDmax, FMleftMean, FMleftMedian, FMleftMin, FMleftMax, FMrightMean, FMrightMedian, FMrightMin, FMrightMax, mistakeITD, mistakeFMLeft, mistakeFMRight\n');
% numSubj = numel(subjs_behavior);
% 
% for s = 1:numSubj
%     subj{1} = subjs_behavior{s};
%     % ITD
%     ITDs_tmp = dataExtraction(subj, OS, 'ITD3down1up', 'BothEar');
%     ITDs = ITDs_tmp{1}.thresh;
%     ITD_mean = mean(ITDs, 2);
%     ITD_median = median(ITDs);
%     ITD_max = max(ITDs);
%     ITD_min = min(ITDs);
%     percentITD = obvsMistkCntr(ITDs_tmp{1}, 'ITD');
%     % FM left
%     FMs_Left_tmp = dataExtraction(subj, OS, 'FM', 'LeftEar');
%     FMleft_tmp = FMs_Left_tmp{1}.thresh;
%     FMleftMedian = median(FMleft_tmp);
%     FMleftMean = mean(FMleft_tmp);
%     FMleftMin = min(FMleft_tmp);
%     FMleftMax = max(FMleft_tmp);
%     percentFM_left = obvsMistkCntr(FMs_Left_tmp{1}, 'FM');
%     % FM right
%     FMs_Right_tmp = dataExtraction(subj, OS, 'FM', 'RightEar');
%     FMright_tmp = FMs_Right_tmp{1}.thresh;
%     FMrightMedian = median(FMright_tmp);
%     FMrightMean = mean(FMright_tmp);
%     FMrightMin = min(FMright_tmp);
%     FMrightMax = max(FMright_tmp);
%     percentFM_right = obvsMistkCntr(FMs_Right_tmp{1}, 'FM');
%     for b = 1
%         fprintf(fid, '%s, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f', ...
%             subjs_behavior{s}, ITD_mean, ITD_median, ITD_min, ITD_max, FMleftMean, FMleftMedian, FMleftMin, FMleftMax, FMrightMean, FMrightMedian, FMrightMin, FMrightMax,...
%             percentITD, percentFM_left, percentFM_right);
%         fprintf(fid, '\n');
%     end
%     fprintf(fid, '\n');
% end

%% EEG data in the order of subjects listed in subjs_EEG
% ITC, average of auditory channels
load('ITC20'); load('ITC60'); load('ITC180'); load('ITC540'); load('ITCavg'); load('ITCavgExd20');
load('ITClat20'); load('ITClat60'); load('ITClat180'); load('ITClat540'); load('ITClatAvg'); load('ITClatAvgExd20');
load('ITC20left'); load('ITC60left'); load('ITC180left'); load('ITC540left'); load('ITCavgleft'); load('ITCavgExd20left');
load('ITClat20left'); load('ITClat60left'); load('ITClat180left'); load('ITClat540left'); load('ITClatAvgleft'); load('ITClatAvgExd20left');
load('ITC20right'); load('ITC60right'); load('ITC180right'); load('ITC540right'); load('ITCavgright'); load('ITCavgExd20right');
load('ITClat20right'); load('ITClat60right'); load('ITClat180right'); load('ITClat540right'); load('ITClatAvgright'); load('ITClatAvgExd20right');
% normalized magnitude relative to the onset erp (N1-P2), Cz channel
load('ERP20'); load('ERP60'); load('ERP180'); load('ERP540'); load('ERPavg'); load('ERPavgExd20');
% n100 latency
load('ERP_N1Lat_20'); load('ERP_N1Lat_60'); load('ERP_N1Lat_180'); load('ERP_N1Lat_540'); load('ERP_N1Lat_Avg'); load('ERP_N1Lat_AvgExd20');
% p200 latency
load('ERP_P2Lat_20'); load('ERP_P2Lat_60'); load('ERP_P2Lat_180'); load('ERP_P2Lat_540'); load('ERP_P2Lat_Avg'); load('ERP_P2Lat_AvgExd20');
% percent of easy mistakes
load('PercentMistakesFMleft'); load('PercentMistakesFMright'); load('PercentMistakesITD');

%% FFR_ITD_FM
subjs_EEG_FFR = {'S031', 'S043', 'S051', 'S075', 'S117', 'S128', 'S133', 'S149', 'S187', 'S191', 'S195', 'S196', 'S197', 'S072', 'S127', 'S132', 'S194'};% S185 % exlcuded S078, S123 (empty arrays were returned), S199 (memory problem)
fid = fopen('dataSetFFR_ITD_FM.csv', 'w');
fprintf(fid, 'subject, FFR_1KHz, ITD, FM, n1lat180, p2lat180, ERP180\n');
numSubj = numel(subjs_EEG_FFR);
threshMeanITD_FFR = meanITD_FM(subjs_EEG_FFR, OS, 'ITD3down1up', 'mean');
threshMeanFMs_FFR = meanITD_FM(subjs_EEG_FFR, OS, 'FM', 'mean');
threshMeanFM_FFR = (threshMeanFMs_FFR{1} + threshMeanFMs_FFR{2})/2;
FFR_mag1000 = [3.13e-05, 9.9e-6, 2.66e-5, 1.51e-5, 3.55e-5, 1.16e-5, 2.79e-5, 6.7e-6, 3.7e-5, 9.8e-6, 2.02e-5, 1.1e-5, 5.17e-5, 1.11e-5, 1.57e-5, 1.12e-5, 1.66e-5];% 7.71e-5
ERP_n1lat180 = [0.1277, 0.1292, 0.1216, 0.1309, 0.1509, 0.1228, 0.1304, 0.1262, 0.1472, 0.1238, 0.1262, 0.1267, 0.1262, 0.1536, 0.1438, 0.1279, 0.1267];% 0.1499
ERP_p2lat180 = [0.2131, 0.2178, 0.2092, 0.1929, 0.2136, 0.2339, 0.2087, 0.2126, 0.2102, 0.2124, 0.2104, 0.1919, 0.2129, 0.2153, 0.2146, 0.2112, 0.1824];% 0.2129
ERP180 = [1.022, 1.046, 0.927, 0.533, 1.423, 0.679, 1.084, 1.336, 1.085, 0.891, 1.419, 1.07, 1.35, 2.18, 0.998, 0.941, 1.038];%, 0.465];
for i = 1:numSubj
    fprintf(fid, '%s, %f, %f, %f, %f, %f, %f', subjs_EEG_FFR{i}, FFR_mag1000(i), threshMeanITD_FFR(i), threshMeanFM_FFR(i), ...
        ERP_n1lat180(i), ERP_p2lat180(i), ERP180(i));
    fprintf(fid, '\n');
end
fprintf(fid, '\n');
%% ploting individual EEG response (itc) across conditions
% plot([20, 60, 180, 540], [mean(itc_20us), mean(itc_60us), mean(itc_180us), mean(itc_540us)]...
%    ,'-ro', 'LineWidth', 12, 'MarkerSize', 20);
% hold on;
% for i = 1:numel(itc_20us)
%     h = plot([20, 60, 180, 540], [itc_20us(i), itc_60us(i), itc_180us(i), itc_540us(i)], '--ko', ...
%         'LineWidth', 3, 'MarkerSize', 20);
%     hold on;
% end
% [~, hobj2, ~, ~] = legend('Average', 'Individual subject', 'location', 'best');
% hLine = findobj(hobj2, 'type', 'line');
% set(hLine, 'LineWidth', 4);
% title('ITD-evoked response across ITDs');
% htext = findobj(hobj2, 'type', 'text');
% set(htext, 'FontSize', 30);
% 
% xticklabels({'20', '60', '180', '540'});
% xticks([20, 60, 180, 540]);
% % set(gca,'xtick',[])
% % set(gca,'xticklabel',[])
% ylabel('Normalized magnitude');
% xlabel('ITD [us]');
% set(gca, 'FontSize', 45);

%% Model of ITD-evoked response 
fid = fopen('dataSetEEG.csv', 'w');
fprintf(fid, 'Subject, EEG_ITC, Conditions, ITD_avg, FM_avg\n');
numSubj = numel(subjs_EEG);
conditions = [20, 60, 180, 540]; % change as needed
for s = 1:numSubj
    ITDs = dataArrayITD{s}.thresh;
    ITDavg = mean(ITDs);
    FMleftTmp = dataArrayFMleft{s};
    FMleftTmp = FMleftTmp(1);
    FMleft = mean(FMleftTmp.thresh);
    FMrightTmp = dataArrayFMright{s};
    FMrightTmp = FMrightTmp(1);
    FMright = mean(FMrightTmp.thresh);
    FMavg = (FMleft + FMright)/2;
    EEGs = [EEG_20us(s), EEG_60us(s), EEG_180us(s), EEG_540us(s)];
    
    for b = 1:numel(EEGs)
        fprintf(fid, '%s, %f, %f, %f, %f', subjs_EEG{s}, EEGs(b), conditions(b), ITDavg, FMavg);
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');
end