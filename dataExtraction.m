function dataArray = dataExtraction(subjs, OS, stimType, earType)
dataArray = cell(1, numel(subjs));
for s = 1:numel(subjs)
    subjID = subjs{s};
    if strcmp(subjID(end-1:end), 'DD')
        subjID = subjID(1:end-2);
    end
    
    if strcmp(OS, 'Mac') % CHANGE AS NEEDED
        rootDir = '/Users/baoagudemu1/Desktop/Lab/Experiment/DataAnalysis/Data/';
    elseif strcmp(OS, 'Ubuntu')
        rootDir = '/media/agudemu/Storage/Data/Behavior/';
    end
    
    if strcmp(stimType, 'FM')
        dataDir = strcat(rootDir, subjID, '_behavior/', subjs(s), '_', earType);
        if numel(dir(dataDir{1})) == 0 
            dataDir{1} = strcat(rootDir, subjID, '_behavior/', subjID, '_', earType);
        end
    elseif strcmp(stimType, 'ITD3down1up')
        dataDir = strcat(rootDir, subjID, '_behavior/', subjs(s), '_3down1up');
        if numel(dir(dataDir{1})) == 0 
            dataDir{1} = strcat(rootDir, subjID, '_behavior/', subjID, '_3down1up');
        end
    elseif strcmp(stimType, 'ITD')
        dataDir = strcat(rootDir, subjID, '_behavior/', subjs(s));
        if numel(dir(dataDir{1})) == 0 
            dataDir{1} = strcat(rootDir, subjID, '_behavior/', subjID);
        end
    elseif strcmp(stimType, 'Audiogram')
        dataDir = strcat(rootDir, subjID, '_behavior/', 'Audiogram/', subjs(s), '_', earType);
        if numel(dir(dataDir{1})) == 0 
            dataDir{1} = strcat(rootDir, subjID, '_behavior/', 'Audiogram/', subjID, '_', earType);
        end
        freqs  = [0.5, 1, 2, 4, 8]*1000; % CHANGE AS NEEDED
        avgThresh = [8.6, 2.7, 0.5, 0.1, 23.1]; % CHANGE AS NEEDED
    end
    
    allFiles = dir(strcat(dataDir{1}, '/*.mat')); % this makes sure hidden files are not included
    
    thresholds = zeros(1, numel(allFiles));
    parmtrList = cell(1, numel(allFiles));
    for i = 1:numel(allFiles)
        if strcmp(stimType, 'Audiogram')
            fSearch = strcat(dataDir, '/', subjs(s), '_', earType, '_', num2str(freqs(i)), '*.mat');
            if numel(dir(fSearch{1})) == 0
                fSearch = strcat(dataDir, '/', subjID, '_', earType, '_', num2str(freqs(i)), '*.mat');
            end
            fnames = dir(fSearch{1});
            ftmp = fnames(1);
            fileName = ftmp.name;
        else
            fileName = allFiles(i).name;
        end
        fileDir = strcat(dataDir, '/', fileName);
        load(fileDir{1});
        if strcmp(stimType, 'ITD') || strcmp(stimType, 'ITD3down1up')
            thresholds(i) = round(thresh*1e6, 1);
            parmtrList{i} = round(ITDList*1e6, 1);
        elseif strcmp(stimType, 'FM')
            thresholds(i) = thresh;
            parmtrList{i} = fdevList;
        elseif strcmp(stimType, 'Audiogram')
            thresholds(i) = thresh - avgThresh(i);
        end
    end
    if strcmp(stimType, 'Audiogram')
        result = struct('subj', subjs(s),'thresh', thresholds, 'freqs', freqs);
    else
        result = struct('subj', subjs(s),'thresh', 20*log10(thresholds), 'parmtrList', parmtrList);
    end
    dataArray{s} = result;
end
end