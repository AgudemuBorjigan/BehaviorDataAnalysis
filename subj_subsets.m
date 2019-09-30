function [subjs_behavior, subjs_NH] = subj_subsets(OS)
rootDir = '/media/agudemu/Storage/Data/Behavior/';
% all subjects who have done audiogram
% note: this code only works for current file management style, modify as
% needed
subjs_Audiogram = subjNames(strcat(rootDir, 'Audiogram'));
rootDir = '/media/agudemu/Storage/Data/Behavior/';
% picking out subjects who did not pass hearing screening test
subjs_HI = aud_abnormal(rootDir, OS);
subjs_NH = setdiff(subjs_Audiogram, subjs_HI);
subjs_OD = {'S216', 'S218'}; % subjects with obscure disfunction 

% picking out subjects who finished FM and ITD test, also passed the
% screening
rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_FM = subjNames(strcat(rootDir, 'FM'));
subjs_FM = intersect(subjs_FM, subjs_NH);

rootDir = '/media/agudemu/Storage/Data/Behavior/';
subjs_ITD = subjNames(strcat(rootDir, 'ITD'));
subjs_ITD = intersect(subjs_ITD, subjs_NH);
% subjects who did both FM and ITD tests and passed the screening
subjs_behavior = intersect(subjs_FM, subjs_ITD);
end