function subjNameArray = subjNames(rootDir)
files = dir(rootDir);
files(~strncmp({files.name}, 'S', 1)) = [];
numSubj = numel(files);
subjNameArray = cell(1, numSubj);
for i = 1:numSubj
    tmp = files(i).name;
    subjNameArray{i} = tmp(1:4);
end
end