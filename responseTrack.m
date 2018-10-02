function responseTrack(data, stimType)

figure;
dataTmp = data;
trialNum = 0;
for i = 1
    list = dataTmp(i).parmtrList;
    plot(1+trialNum:trialNum + numel(list), list, '-o', 'LineWidth', 2);
    trialNum = trialNum + numel(list);
    hold on;
end
xlabel('Trial number');
if strcmp(stimType, 'ITD')
    ylabel('ITD [us]');
else
    ylabel('Frequency deviation [Hz]');
end
title('Response track');
set(gca, 'FontSize', 26);

figure;
dataTmp = data;
trialNum = 0;
for i = 1:numel(dataTmp)
    list = dataTmp(i).parmtrList;
    plot(1+trialNum:trialNum + numel(list), list, '-o', 'LineWidth', 2);
    trialNum = trialNum + numel(list);
    hold on;
end
xlabel('Trial number');
if strcmp(stimType, 'ITD')
    ylabel('ITD [us]');
else
    ylabel('Frequency deviation [Hz]');
end
legend('block1', 'block2', 'block3', 'block4');
title('Response track');
set(gca, 'FontSize', 26);

end