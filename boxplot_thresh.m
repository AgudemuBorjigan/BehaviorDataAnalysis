function boxplot_thresh(data, stimType, Ear, index) % data contain thresholds

threshSet = [];
iteration = 0;
numValidBlocks = 0;
for s = index
    iteration = iteration +1;
    dataTmp = data{s};
    dataTmp = dataTmp(1);
    threshSet = [threshSet, dataTmp.thresh];  %#ok<AGROW>
    for i = 1:numel(dataTmp.thresh)
        %         nameSet{numValidBlocks + i} = dataTmp.subj;
        nameSet{numValidBlocks + i} = num2str(iteration);
    end
    numValidBlocks = numValidBlocks + numel(dataTmp.thresh);
end
h = boxplot(threshSet, nameSet);
set(h, 'LineWidth', 3);
set(gca, 'FontSize', 30);
if strcmp(stimType, 'FM')
    ylabel('FM [dB relative to 1 Hz]');
    xlabel('Subjects')
    if strcmp(Ear, 'LeftEar')
        title('FM thresholds for all subjects (Left ear)');
    else
        title('FM thresholds for all subjects (Right ear)');
    end
elseif strcmp(stimType, 'ITD') || strcmp(stimType, 'ITD3down1up')
    ylabel('ITD [dB relative to 1 us]');
    xlable('Subjects')
    title('ITD thresholds for all subjects');
end
end