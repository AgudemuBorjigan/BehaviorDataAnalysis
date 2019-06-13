function [subjs_behavior] = subjs_behavior_set
OS = 'Ubuntu';

rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_Audiogram = subjNames(strcat(rootDir, 'Audiogram'));
rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_HI = audiogramPop(rootDir, OS);
subjs_NH = setdiff(subjs_Audiogram, subjs_HI);
subjs_OD = {'S216', 'S218'};

rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_FM = subjNames(strcat(rootDir, 'FM'));
subjs_FM = intersect(subjs_FM, subjs_NH);

rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_ITD = subjNames(strcat(rootDir, 'ITD'));
subjs_ITD = intersect(subjs_ITD, subjs_NH);

subjs_behavior = intersect(subjs_FM, subjs_ITD);
end