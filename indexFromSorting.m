function [index] = indexFromSorting(subjs, data)
medianThresh = [];
for s = 1:numel(subjs)
    dataTmp = data{s};
    dataTmp = dataTmp(1);
    medianThresh = [medianThresh, median(dataTmp.thresh)]; %#ok<AGROW>
end

[~, index] = sort(medianThresh);
end