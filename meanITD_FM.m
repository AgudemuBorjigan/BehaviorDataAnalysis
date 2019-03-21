function threshMean = meanITD_FM(subjs, OS, stimulus, type)
% [threshMean, threshMeanFMLeft, threshMeanFMRight] = meanITD_FM(subjs, OS, stimulus)
 numSubj = numel(subjs);
if strcmp(stimulus, 'ITD3down1up')
    %% Mean ITD and FM thresholds
    % Extracting mean ITD thresholds
    dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
    threshMean = zeros(1, numSubj);
    for s = 1:numSubj
        dataTmp = dataArrayITD{s};
        dataTmp = dataTmp(1);
        %---------------------------------------
        % Taking the mean is appropriate, since there is no block effects from
        % linear regression analysis
        %---------------------------------------
        if strcmp(type, 'min')
            threshMean(s) = min(dataTmp.thresh);
        elseif strcmp(type, 'mean')
            threshMean(s) = mean(dataTmp.thresh);
        elseif strcmp(type, 'max')
            threshMean(s) = max(dataTmp.thresh);
        elseif strcmp(type, 'median')
            threshMean(s) = median(dataTmp.thresh);
        end
    end
else
    % Extracting mean FM thresholds
    dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
    dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'RightEar');
    
    threshMeanFMLeft = zeros(1, numSubj);
    threshMeanFMRight = zeros(1, numSubj);
    threshMean = cell(1,2);
    for s = 1:numSubj
        dataTmpLeft = dataArrayFMLeft{s};
        dataTmpLeft = dataTmpLeft(1);
        dataTmpRight = dataArrayFMRight{s};
        dataTmpRight = dataTmpRight(1);
        %---------------------------------------
        % Taking the mean is appropriate since there are only 4 blocks
        %---------------------------------------
%         threshMeanFMLeft(s) = mean(dataTmpLeft.thresh);
%         threshMeanFMRight(s) = mean(dataTmpRight.thresh);
        if strcmp(type, 'min')
            threshMeanFMLeft(s) = min(dataTmpLeft.thresh);
            threshMeanFMRight(s) = min(dataTmpRight.thresh);
        elseif strcmp(type, 'mean')
            threshMeanFMLeft(s) = mean(dataTmpLeft.thresh);
            threshMeanFMRight(s) = mean(dataTmpRight.thresh);
        elseif strcmp(type, 'max')
            threshMeanFMLeft(s) = max(dataTmpLeft.thresh);
            threshMeanFMRight(s) = max(dataTmpRight.thresh);
        elseif strcmp(type, 'median')
            threshMeanFMLeft(s) = median(dataTmpLeft.thresh);
            threshMeanFMRight(s) = median(dataTmpRight.thresh);
        end
    end
    threshMean{1} = threshMeanFMLeft;
    threshMean{2} = threshMeanFMRight;
end
end