function [threshMeanITD, threshMeanFMLeft, threshMeanFMRight] = meanITD_FM(subjs, OS)
%% Mean ITD and FM thresholds
% Extracting mean ITD thresholds
dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
numSubj = numel(subjs);
threshMeanITD = zeros(1, numSubj);
for s = 1:numSubj
    dataTmp = dataArrayITD{s};
    dataTmp = dataTmp(1);
    %---------------------------------------
    % Taking the mean is appropriate, since there is no block effects from
    % linear regression analysis
    %---------------------------------------
    threshMeanITD(s) = mean(dataTmp.thresh);
end

% Extracting mean FM thresholds
dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'RightEar');

threshMeanFMLeft = zeros(1, numSubj);
threshMeanFMRight = zeros(1, numSubj);
for s = 1:numSubj
    dataTmpLeft = dataArrayFMLeft{s};
    dataTmpLeft = dataTmpLeft(1);
    dataTmpRight = dataArrayFMRight{s};
    dataTmpRight = dataTmpRight(1);
    %---------------------------------------
    % Taking the mean is appropriate since there are only 4 blocks
    %---------------------------------------
    threshMeanFMLeft(s) = mean(dataTmpLeft.thresh);
    threshMeanFMRight(s) = mean(dataTmpRight.thresh);
end
end