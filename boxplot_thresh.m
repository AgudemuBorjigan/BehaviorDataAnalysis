function boxplot_thresh(data, stimType, Ear, index) % data contain thresholds
figure;
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
set(h, 'LineWidth', 4);
set(h, 'DefaultTextFontSize', 36);
set(gca, 'FontSize', 36);
if strcmp(stimType, 'FM')
    ylabel('FM [dB relative to 1 Hz]');
    xlabel('Subjects')
    if strcmp(Ear, 'LeftEar')
        title('FM thresholds for all subjects (Left ear)');
    else
        title('FM thresholds for all subjects (Right ear)');
    end
    ax1 = axes('Position', [.17 .65 .2 .2]);
    box on;
    responseTrack(data{16}, 'FM', 'Left');
elseif strcmp(stimType, 'ITD')
    ylabel('ITD [dB relative to 1 us]');
    xlabel('Subjects')
    title('ITD thresholds for all subjects');
    
    ax1 = axes('Position', [.16 .60 .25 .25]);
    box on;
    responseTrack(data{16}, 'ITD', 'Left');
end
end