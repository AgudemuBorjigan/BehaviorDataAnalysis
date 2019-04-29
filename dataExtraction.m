function dataArray = dataExtraction(subjs, OS, stimType, earType)
dataArray = cell(1, numel(subjs));
problematic = zeros(1, numel(subjs)); % CHECK IF THERE IS NEGATIVE FDEV VALUES
for s = 1:numel(subjs)
    subjID = subjs{s};
    % CHANGE AS NEEDE
    if strcmp(OS, 'Mac') 
        rootDir = '/Users/baoagudemu1/Desktop/Lab/Experiment/DataAnalysis/Data/';
    elseif strcmp(OS, 'Ubuntu')
        rootDir = '/media/agudemu/Storage/Data/Behavior/';
    end
    
    if strcmp(stimType, 'FM')
        dataDir = strcat(rootDir, 'FM/', subjID, '/', subjID, '_', earType);
    elseif strcmp(stimType, 'ITD3down1up')
        dataDir = strcat(rootDir, 'ITD/', subjID, '/',  subjID, '_3down1up');
    elseif strcmp(stimType, 'Audiogram')
        dataDir = strcat(rootDir, 'Audiogram/', subjID, '/', subjID, '_', earType);
        freqs  = [0.5, 1, 2, 4, 8]*1000; 
        avgThresh = [8.6, 2.7, 0.5, 0.1, 23.1]; 
    end
    
    allFiles = dir(strcat(dataDir, '/*.mat')); % this makes sure hidden files are not included
    blockNum = numel(allFiles);
    
    thresholds = zeros(1, numel(allFiles));
    parmtrList = cell(1, numel(allFiles));
    responseList = cell(1, numel(allFiles));
    for i = 1:numel(allFiles)
        if strcmp(stimType, 'Audiogram')
            fSearch = strcat(dataDir, '/', subjID, '_', earType, '_', num2str(freqs(i)), '*.mat');
            fnames = dir(fSearch);
            ftmp = fnames;
            fileName = ftmp.name;
        else
            fileName = allFiles(i).name;
        end
        fileDir = strcat(dataDir, '/', fileName);
        load(fileDir);
        if strcmp(stimType, 'ITD3down1up')
            thresholds(i) = round(thresh*1e6, 1);
            parmtrList{i} = round(ITDList*1e6, 1);
        elseif strcmp(stimType, 'FM')
            thresholds(i) = thresh;
            parmtrList{i} = fdevList;
            if sum(fdevList<0)
                problematic(s) = 1;
            end
        elseif strcmp(stimType, 'Audiogram')
            thresholds(i) = thresh - avgThresh(i);
        end
        responseList{i} = respList;
    end
    if strcmp(stimType, 'Audiogram')
        result = struct('subj', subjs(s),'thresh', thresholds, 'freqs', freqs, 'blockNum', blockNum);
    else
        % taking log to make within individual variability look smaller
        result = struct('subj', subjs(s),'thresh', 20*log10(thresholds), 'parmtrList', parmtrList, 'resList', responseList, 'blockNum', blockNum);
        % result = struct('subj', subjs(s),'thresh', thresholds, 'parmtrList', parmtrList);
    end
    dataArray{s} = result;
end
end