cd '/Users/baoagudemu1/Desktop/2018Spring/Lab/PilotExperiment/DataAnalysis/S141_behavior/S141_RightEar'

files = dir('*.mat');
threshArray = zeros(1,numel(files));
for i = 1:numel(files)
    fileName = files(i).name;
    load(fileName);
    threshArray(i) = thresh;
    figure(i);
    %plot(fdevList);
    plot(ITDList);
end

meanThresh = mean(threshArray);