function [threshArray, sensitivity] = psychFctn(OS, subjs, stimulus, ear)
numSubj = numel(subjs);

if strcmp(stimulus, 'ITD3down1up')
    dataArray = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
else
    if strcmp(ear, 'LeftEar')
        dataArray = dataExtraction(subjs, OS, 'FM', 'LeftEar');
    else
        dataArray = dataExtraction(subjs, OS, 'FM', 'RightEar');
    end
end
threshArray = zeros(1, numSubj);
sensitivity = zeros(1, numSubj);
for s = 1:numSubj
    
    dataTmp = dataArray{s};
    
    for k = 1:numel(dataTmp)
        if k == 1
            parmTtl = dataTmp(k).parmtrList;
            respTtl = dataTmp(k).resList;
        else
            parmTtl = [parmTtl dataTmp(k).parmtrList];
            respTtl = [respTtl dataTmp(k).resList];
        end
    end
    
    parmsUnique = unique(parmTtl);
    percentCorr = zeros(1, numel(parmsUnique));
    
    for i = 1:numel(parmsUnique)
        respPerParm = respTtl(parmsUnique(i) == parmTtl);
        percentCorr(i) = sum(respPerParm)/numel(respPerParm);
    end
    
    plot(parmsUnique, percentCorr, 'ro', 'LineWidth', 2);
    hold on;
    % fit psychometric function
    targets = [0.694, 0.794, 0.894]; % for 1-up-3-down, 2AFC procedure, threshold corresponds to 79.4%, needs to check the target values
    weights = ones(1, length(parmsUnique));
    [~, curve, threshold] = FitPsycheCurveLogit(parmsUnique, percentCorr, weights, targets);
    plot(curve(:,1), curve(:,2), 'b--', 'LineWidth', 2);
    threshArray(s) = threshold(2);
    sensitivity(s) = (threshold(3) - threshold(1))/2;
end
end