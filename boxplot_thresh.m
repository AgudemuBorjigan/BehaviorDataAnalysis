function boxplot_thresh(data, subjs, stimType, Ear, index) % data contain thresholds

threshSet = [];
dataTmp = data{1};
dataTmp = dataTmp(1);
nameSet = cell(1, numel(subjs) * numel(dataTmp.thresh));
iteration = 0;
for s = index
    iteration = iteration +1;
    dataTmp = data{s};
    dataTmp = dataTmp(1);
    threshSet = [threshSet, dataTmp.thresh];  %#ok<AGROW>
    for i = 1:numel(dataTmp.thresh)
        nameSet{(iteration-1)*numel(dataTmp.thresh) + i} = dataTmp.subj;
    end
end
h = boxplot(threshSet, nameSet);
set(h, 'LineWidth', 2);
set(gca, 'FontSize', 25);
if strcmp(stimType, 'FM')
    ylabel('FM [dB relative to Hz]');
    if strcmp(Ear, 'LeftEar')
        title('FM thresholds for all subjects (Left)');
    else
        title('FM thresholds for all subjects (Right)');
    end
elseif strcmp(stimType, 'ITD') || strcmp(stimType, 'ITD3down1up')
    ylabel('ITD [dB relative to us]');
    title('ITD thresholds for all subjects');
end
end