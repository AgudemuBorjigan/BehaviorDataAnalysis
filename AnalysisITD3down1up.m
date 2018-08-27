%% Data storage
% Note that different day testing needs to be added right after its previous  
subjs = {'Satya', 'SatyaDD', 'Kristen', 'Rav', 'S116'}; 
dataArray = cell(1, numel(subjs));
for s = 1:numel(subjs)
    subjID = subjs{s};
    if strcmp(subjID(end-1:end), 'DD')
        subjID = subjID(1:end-2);
    end
    %dataDir = strcat('/media/agudemu/Storage/Data/Behavior/', subjID, '_behavior/', subjs(s), '_3down1up/');
    dataDir = strcat('/Users/baoagudemu1/Desktop/Lab/PilotExperiment/DataAnalysis/Data/', subjID, '_behavior/', subjs(s), '_3down1up/');
    
    allFiles = dir(strcat(dataDir{1}, '/*.mat')); % the first two files are hidden files
    thresholds = zeros(1, numel(allFiles));
    for i = 1:numel(allFiles)
        fileName = allFiles(i).name;
        fileDir = strcat(dataDir, fileName);
        load(fileDir{1});
        thresholds(i) = round(thresh*1e6, 1);
    end
    varIdvl = var(thresholds);
    varIdvlLast4 = var(thresholds(end/2+1:end));
    varIdvlFirst4 = var(thresholds(1:end/2));
    meanIdvl = mean(thresholds);
    meanLast4 = mean(thresholds(end/2+1:end));
    meanFirst4 = mean(thresholds(1:end/2));
    result = struct('subj', subjs(s),'thresh', thresholds, 'varianceLast4', varIdvlLast4, 'varianceFirst4', varIdvlFirst4, ...
        'variance', varIdvl, 'mean', mean(thresholds), 'meanLast4', meanLast4, 'meanFirst4', meanFirst4);
    dataArray{s} = result;
end
save('dataITD3down1up.mat', 'dataArray');
%% Data visualization
figure(1);
legendInfo = cell(1, numel(subjs));
means = zeros(1, numel(subjs));
meansLast4 = zeros(1, numel(subjs));
meansFirst4 = zeros(1, numel(subjs));
varsLast4 = zeros(1, numel(subjs));
varsFirst4 = zeros(1, numel(subjs));
vars = zeros(1, numel(subjs));
meanDiffDD = zeros(1, numel(subjs));
varDiffDD = zeros(1, numel(subjs));
for s = 1:numel(subjs)
    dataTmp = dataArray{s};
    subjName = dataTmp.subj;
    if strcmp(subjName(end-1:end), 'DD')
        LineStyle = '--';
        Color = h.Color;
        h = plot(dataTmp.thresh, 'LineStyle', LineStyle, 'Marker', 'o', 'LineWidth', 2, 'Color', Color);
    else
        LineStyle = '-';
        h = plot(dataTmp.thresh, 'LineStyle', LineStyle, 'Marker', 'o', 'LineWidth', 2);
    end
    hold on;
    legendInfo{s} = dataTmp.subj;
    
    % some data collection
    means(s) = dataTmp.mean;
    meansLast4(s) = dataTmp.meanLast4;
    meansFirst4(s) = dataTmp.meanFirst4;
    varsLast4(s) = dataTmp.varianceLast4;
    vars(s) = dataTmp.variance;
    varsFirst4(s) = dataTmp.varianceFirst4;
    if strcmp(subjName(end-1:end), 'DD')
        meanDiffDD(s) = abs(means(s) - means(s-1));
        varDiffDD(s) = abs(varsLast4(s) - varsLast4(s-1));
    else
        meanDiffDD(s) = 0;
        varDiffDD(s) = 0;
    end
end
xlabel('Repetitions');
ylabel('ITDs [us]');
title('ITD detection thresholds across repetitions');
legend(legendInfo);

% Box plot
figure(2);
threshSet = [];
nameSet = cell(1, numel(subjs) * numel(dataArray{1}.thresh));
for s = 1:numel(subjs)
    threshSet = [threshSet, dataArray{s}.thresh];  %#ok<AGROW>
    for i = 1:numel(dataArray{s}.thresh)
        nameSet{(s-1)*numel(dataArray{s}.thresh) + i} = dataArray{s}.subj;
    end
end
boxplot(threshSet, nameSet);
ylabel('ITD [us]');
title('ITD thresholds for all subjects');

%% Changes in data
varAcrossSubjs = var(means); % How to calculate across-subject variance? 
varDiffLas4vsAll = varsLast4 - vars;
varDiffLast4vsFirst4 = varsLast4 - varsFirst4;
meanDiffLast4vsAll = meansLast4 - means;
meanDiffLast4vsFirst4 = meansLast4 - meansFirst4;

save('dataITD3down1up.mat', 'means', 'meansLast4', 'meansFirst4', 'vars', 'varsLast4', 'varsFirst4', 'varDiffLas4vsAll', 'varDiffLast4vsFirst4', ...
    'meanDiffLast4vsAll', 'meanDiffLast4vsFirst4', 'meanDiffDD', 'varDiffDD');
