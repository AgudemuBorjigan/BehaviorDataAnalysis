datadir = '/media/agudemu/Storage/Data/Behavior/Audiogram/S053/';
cd '/media/agudemu/Storage/Data/Behavior/Audiogram/S053/'
%datadir = '/Users/baoagudemu1/Desktop/Lab/Experiment/DataAnalysis/Data/S199_behavior/Audiogram/';
%cd '/Users/baoagudemu1/Desktop/Lab/Experiment/DataAnalysis/Data/S199_behavior/Audiogram/';
subjs = dir(strcat(datadir, '*Ear'));
fid = fopen('AudiogramData.csv', 'w');
freqs  = [0.5, 1, 2, 4, 8]*1000;
avgThresh = [8.6, 2.7, 0.5, 0.1, 23.1];
fprintf(fid, 'Subject, Ear, 500, 1000, 2000, 4000, 8000\n');
threshArrays = zeros(2, numel(freqs));
threshOriginal = zeros(2, numel(freqs));
for k = 1:numel(subjs)
    subj = subjs(k);
    sID = subj.name(1:4);
    ear = subj.name(6);
    fprintf(fid, '%s, %s', sID, ear);
    j = 0;
    for freq = freqs
        j = j + 1;
        fsearch = strcat(subj.folder, '/', subj.name, '/', subj.name, '_', ...
            num2str(freq), '*.mat');
        fnames = dir(fsearch);
        ftemp = fnames(1);
        fname = ftemp.name;
        data = load(strcat(subj.folder, '/', subj.name, '/', fname), 'thresh');
        hearingLevel = data.thresh - avgThresh(j);
        threshArrays(k, j) = hearingLevel;
        threshOriginal(k, j) = data.thresh;
        fprintf(fid, ',%f',hearingLevel);
    end
    fprintf(fid, '\n');
end
fprintf(fid, '%s, %s', sID, 'diff');
for i = 1:numel(freqs)
    diff = abs(threshArrays(1, i) - threshArrays(2, i));
    fprintf(fid, ',%f', diff);
end
fclose(fid);

