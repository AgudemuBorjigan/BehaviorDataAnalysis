function responseTrack(data, stimType, subj)

% figure;
% dataTmp = data;
% trialNum = 0;
% % showing response for only one block
% for i = 1
%     list = dataTmp(i).parmtrList;
%     plot(1+trialNum:trialNum + numel(list), list, '-o', 'LineWidth', 3);
%     trialNum = trialNum + numel(list);
%     hold on;
% end
% xlabel('Trial number');
% if strcmp(stimType, 'ITD')
%     ylabel('ITD [us]');
% else
%     ylabel('Frequency deviation [Hz]');
% end
% title('Response track');
% set(gca, 'FontSize', 30);

figure;
dataTmp = data;
trialNum = 0;
for i = 1:numel(dataTmp)
    list = dataTmp(i).parmtrList;
    plot(1+trialNum:trialNum + numel(list), list, '-o', 'LineWidth', 3);
    trialNum = trialNum + numel(list);
    hold on;
end
xlabel('Trial number');
if strcmp(stimType, 'ITD')
    ylabel('ITD [us]');
    legend('block1', 'block2', 'block3', 'block4', 'block5', 'block6', 'block7', 'block8');
else
    ylabel('Frequency deviation [Hz]');
    legend('block1', 'block2', 'block3', 'block4');
end
% title(strcat('Response track:', subj));
title('Response track');
set(gca, 'FontSize', 30);

end