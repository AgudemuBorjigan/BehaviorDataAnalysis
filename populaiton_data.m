% This file pools data from all subjects into one excel file for statistic
% analysis
% Author: Agudemu Borjigin, 9/6/2019

OS = 'Ubuntu';
% extracting subjects who passed screening, and completed both FM and ITD
% behavior measurements
[subjs_behavior, subjs_NH] = subj_subsets(OS);

rootDir = '/media/agudemu/Storage/Data/EEG/';
subjs_ITD_EEG = subjNames(strcat(rootDir, 'ITD'));
subjs_ITD_EEG_NH = intersect(subjs_ITD_EEG, subjs_NH);
% Note that subjs_behavior doesn't contain some subjects who did ITDs but
% not FMs
subjs_behavior_EEG_ITD = intersect(subjs_ITD_EEG_NH, subjs_behavior);

rootDir = '/media/agudemu/Storage/Data/EEG/';
subjs_FFR = subjNames(strcat(rootDir, 'FFR'));
subjs_behavior_FFR = intersect(subjs_behavior_EEG_ITD, subjs_FFR);   

%% Behavior & EEG (ITD&FFR) dataset
fid = fopen('dataSet.csv', 'w');
fprintf(fid, 'Subject, ITDmean, FMleftMean, FMrightMean, mistakeITD, mistakeFMLeft, mistakeFMRight, ERPn1lat180, ERPp2lat180, ERPmag180, FFR1Kmag, Ref, HL500left, HL500right, HFAleft, HFAright\n');
numSubj = numel(subjs_behavior);

load('ERP_n1lat180');% variable: erp_n1lat180
load('ERP_p2lat180');
load('ERP_mag180');
load('FFR_1kmag');
load('RMS');
for s = 1:numSubj
    subj{1} = subjs_behavior{s};
    % ITD
    ITDs_tmp = dataExtraction(subj, OS, 'ITD3down1up', 'BothEar');
    ITDs = ITDs_tmp{1}.thresh;
    ITD_mean = mean(ITDs);
    percentITD = obvsMistkCntr(ITDs_tmp{1}, 'ITD');
    % FM left
    FMs_Left_tmp = dataExtraction(subj, OS, 'FM', 'LeftEar');
    FMleft_tmp = FMs_Left_tmp{1}.thresh;
    FMleftMean = mean(FMleft_tmp);
    percentFM_left = obvsMistkCntr(FMs_Left_tmp{1}, 'FM');
    % FM right
    FMs_Right_tmp = dataExtraction(subj, OS, 'FM', 'RightEar');
    FMright_tmp = FMs_Right_tmp{1}.thresh;
    FMrightMean = mean(FMright_tmp);
    percentFM_right = obvsMistkCntr(FMs_Right_tmp{1}, 'FM');
    % Audiogram
    HLright = dataExtraction(subj, OS, 'Audiogram', 'RightEar');
    HLleft = dataExtraction(subj, OS, 'Audiogram', 'LeftEar');
    for b = 1
        fprintf(fid, '%s, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f', ...
            subj{1}, ITD_mean, FMleftMean, FMrightMean,...
            percentITD, percentFM_left, percentFM_right, ...
            erp_n1lat180(s), erp_p2lat180(s), erp_mag180(s), ffr1kmag(s), rms(s)/(10e-6), ...
            HLleft{1}.thresh(1), HLright{1}.thresh(1), ...
            mean([HLleft{1}.thresh(4), HLleft{1}.thresh(5)]), ...
            mean([HLright{1}.thresh(4), HLright{1}.thresh(5)]));
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');
end

%% ploting individual EEG response (itc) across conditions
load('ITC_mag_both.mat');
itc_mag_both = 20*log10(itc_mag_both);
h_avg = plot([20, 60, 180, 540], [meanWithNan(itc_mag_both(:, 1)), meanWithNan(itc_mag_both(:, 2)), ... 
    meanWithNan(itc_mag_both(:, 3)), meanWithNan(itc_mag_both(:, 4))],'-rs', 'LineWidth', 4, 'MarkerSize', 10);
set(h_avg, 'markerfacecolor', get(h_avg, 'color'));

itc_size = size(itc_mag_both);
hold on;
for i = 1:itc_size(1)
    h = plotWithNan([20 60 180 540], itc_mag_both(i, 1:4));
    hold on;
end
[~, hobj, ~, ~] = legend('Average', 'Individual subject', 'location', 'best');
hLine = findobj(hobj, 'type', 'line');
set(hLine, 'LineWidth', 2);
htext = findobj(hobj, 'type', 'text');
set(htext, 'FontSize', 8);
% title('ITD-evoked response across ITDs');

xticklabels({'20', '60', '180', '540'});
xticks([20, 60, 180, 540]);
% set(gca,'xtick',[])
% set(gca,'xticklabel',[])
ylabel('Normalized magnitude [dB]');
xlabel('ITD [us]');
set(gca, 'FontSize', 10);