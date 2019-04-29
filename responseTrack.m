function responseTrack(data, stimType, Ear)
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
    l = legend('block1', 'block2', 'block3', 'block4', 'block5', 'block6', 'block7', 'block8');
    l.FontSize = 10;
    titleTxt = 'Response track, ITD';
else
    ylabel({'Frequency deviation', '[Hz]'});
    legend('block1', 'block2', 'block3', 'block4');
    if strcmp(Ear, 'Left')
        titleTxt = 'Response track, Left';
    elseif strcmp(Ear, 'Right')
        titleTxt = 'Response track, Right';
    end
end
% title(strcat('Response track:', subj));
title(titleTxt);
set(gca, 'FontSize', 20);

end