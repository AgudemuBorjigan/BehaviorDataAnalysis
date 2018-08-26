function threshAcrossReps(stimulusType, LeftOrRight)

subList = {'S025', 'S028', 'S031', 'S043', 'S046', 'S072', 'S075', 'S078', 'S083', 'S084', 'S117', 'S119', 'S123', ...
    'S127', 'S128', 'S132', 'S133', 'S135', 'S139', 'S140', 'S143', 'S144', 'S145', 'S149'};

thresh = cell(1, numel(subList));

for s = 1:numel(subList)
    if strcmp(stimulusType, 'ITD')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s});
        ystring = 'ITD [us]';
    elseif strcmp(stimulusType, 'FM')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s}, '_', LeftOrRight);
        ystring = 'fdev [Hz]';
    elseif strcmp(stimulusType, 'FM3Intervals')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s}, '_3Intervals', '_', LeftOrRight);
        ystring = 'ITD [us]';
    elseif strcmp(stimulusType, 'ITD3Intervals')
        filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subList{s}, '_behavior/', subList{s}, '_3Intervals');
        ystring = 'fdev [Hz]';
    end
    files = dir(strcat(filePath,'/*.mat'));
    
    threshTmp = zeros(1, numel(files));
    for i = 1:numel(files)
        fileName = files(i).name;
        S = load(strcat(filePath, '/', fileName));
        if strcmp(stimulusType, 'FM') || strcmp(stimulusType, 'FM3Intervals')
            threshTmp(i) = S.thresh;
        elseif strcmp(stimulusType, 'ITD')
            threshTmp(i) = S.thresh*1e6;
        else
            threshTmp(i) = S.thresh*1e6;
%             threshTmp(i) = S.thresh;
        end
    end
    thresh{s} = threshTmp;
    plot(threshTmp, '-o');
    xlabel('Repetition');
    ylabel(ystring);
    hold on;
end