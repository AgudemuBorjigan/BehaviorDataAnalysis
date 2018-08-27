function [slope, thresh] = MaxLikelihoodGrid(stimulusType, LeftOrRight)

% subList = {'S025', 'S028', 'S031', 'S043', 'S046', 'S072', 'S075', 'S078', 'S083', 'S084', 'S117', 'S119', 'S123', ...
%     'S127', 'S128', 'S132', 'S133', 'S135', 'S139', 'S140', 'S143', 'S144', 'S145', 'S149'};
subList = {'Satya', 'SatyaDD', 'Kristen', 'Rav', 'S116'};
slope = zeros(1, numel(subList));
thresh = zeros(1, numel(subList));

for s = 1:numel(subList)
    if strcmp(stimulusType, 'ITD')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s});
    elseif strcmp(stimulusType, 'FM')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s}, '_', LeftOrRight);
    elseif strcmp(stimulusType, 'FM3Intervals')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s}, '_3Intervals', '_', LeftOrRight);
    elseif strcmp(stimulusType, 'ITD3Intervals')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s}, '_3Intervals');
    elseif strcmp(stimulusType, 'ITD3down1up')
        subjID = subList{s};
        if strcmp(subjID(end-1:end), 'DD') % different day testig is stored in the same folder as previous
            subjID = subjID(1:end-2);
        end
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subjID, '_behavior/', subList{s}, '_3down1up');
    end
    files = dir(strcat(filePath,'/*.mat'));
    ListPmtr = cell(1, numel(files));
    ListResp = cell(1, numel(files));
    PmtrAllWithZero = [];
    RespAllWithZero = [];
    for i = 1:numel(files)
        fileName = files(i).name;
        S = load(strcat(filePath, '/', fileName));
        if strcmp(stimulusType, 'FM') || strcmp(stimulusType, 'FM3Intervals')
            ListPmtr{i} = S.fdevList;
            ListResp{i} = S.respList;
        else
            ListPmtr{i} = S.ITDList*1e6;
            ListResp{i} = S.respList;
        end
        PmtrAllWithZero = [PmtrAllWithZero, ListPmtr{i}]; %#ok<AGROW>
        RespAllWithZero = [RespAllWithZero, ListResp{i}]; %#ok<AGROW>
    end
    pmtrCorrt = PmtrAllWithZero(RespAllWithZero == 1);
    pmtrWrong = PmtrAllWithZero(RespAllWithZero == 0);
    
    if strcmp(stimulusType, 'ITD') || strcmp(stimulusType, 'ITD3down1up')
        T = 1:0.01:100;% CHANGE AS NEEDED
        k = 0.01:0.01:1;% CHANGE AS NEEDED
    elseif strcmp(stimulusType, 'ITD3Intervals')
        T = 1:300;% CHANGE AS NEEDED
        k = 0.001:0.001:5;% CHANGE AS NEEDED
    else
        T = 0.1:0.1:15;% CHNAGE AS NEEDED
        k = 0.001:0.001:8;% CHANGE AS NEEDED
    end
    
    llhd = zeros(numel(T), numel(k));
    
    for i = 1:numel(T)
        for j = 1:numel(k)
            llhd(i, j) = likelihood(k(j), T(i), pmtrCorrt, pmtrWrong);
        end
    end
    [maxllhd, ~] = max(llhd(:));
    [rows, columns] = find(llhd == maxllhd);
    slope(s) = k(columns);
    thresh(s) = T(rows);
end
end