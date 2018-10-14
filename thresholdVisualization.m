OS = 'Mac';

%% ITD3down1up
% Note that different day testing needs to be added right after its previous  
subjs = {'S117', 'S128', 'S132', 'S078', 'S149', ...
    'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127', 'S133', 'S135', 'S075', 'S031', 'S173'}; 
%---------------------------------------------------------------------------
%Paradigm was chaneged after them): 'Satya', 'SatyaDD', 'Kristen', 'Rav', 'S116', 'Anna', 'Bre'
%117DD was excluded
%---------------------------------------------------------------------------
numSubj = numel(subjs);

dataArrayITD = dataExtraction(subjs, OS, 'ITD3down1up', 'BothEar');
% variance, mean of the first, last half, and the whole session can be
% computed for storage and saved
% save('dataITD3down1up.mat', 'dataArray');
figure;
legendInfo = cell(1, numSubj);

for s = 1:numSubj
    dataTmp = dataArrayITD{s};
    dataTmp = dataTmp(1);
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
end
xlabel('Repetitions');
ylabel('ITDs [us]');
title('ITD detection thresholds across repetitions');
legend(legendInfo);

% Response track of one subject
responseTrack(dataArrayITD{2}, 'ITD');

% Box plot

index = indexFromSorting(subjs, dataArrayITD);

figure;
boxplot_thresh(dataArrayITD, subjs, 'ITD', 'BothEar', index);

%% FM 
subjs = {'S117', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046', 'S043', 'S127',...
    'S133', 'S135','S075', 'S031', 'S173'}; 

dataArrayFMLeft = dataExtraction(subjs, OS, 'FM', 'LeftEar');
dataArrayFMRight = dataExtraction(subjs, OS, 'FM', 'RightEar');
% variance, mean of the first, last half, and the whole session can be
% computed for storage
%save('dataFM.mat', 'dataArrayLeft');
%save('dataFM.mat', 'dataArrayRight');

% Response track of one subject
responseTrack(dataArrayFMLeft{2}, 'FM');

index = indexFromSorting(subjs, dataArrayFMLeft);

% Box plot
figure;
boxplot_thresh(dataArrayFMLeft, subjs, 'FM', 'LeftEar', index);
figure;
boxplot_thresh(dataArrayFMRight, subjs, 'FM', 'RightEar', index);

%% Hearing threshold
subjs = {'S117', 'S128', 'S132', 'S078', 'S149', 'S123', 'S143', 'S084', 'S072', 'S046'}; 
dataArrayHLLeft = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
dataArrayHLRight = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');