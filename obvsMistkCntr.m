function perct = obvsMistkCntr(data, stim)
dataTmp = data;
trialNum = 0;
nMistkTl = 0;
perctTl = 0;
if strcmp(stim, 'ITD')
    threshEasy = 80;
else
    threshEasy = 15;
end

for b = 1:numel(dataTmp)
    list = dataTmp(b).parmtrList;
    nPrmtr = numel(list);
    nMistk = 0;
    percTrial = 0;
    for l = 1:nPrmtr
        if l ~= nPrmtr
            if list(l) > threshEasy % 80 was chosen as the threshold for easy ITDs
                if list(l) < list(l+1)
                    nMistk = nMistk +1;
                end
            end
        end
    end
    perctTrial = nMistk/nPrmtr;
    trialNum = trialNum + nPrmtr;
    nMistkTl = nMistkTl + nMistk;
    perctTl = perctTl + perctTrial;
end
perct = perctTl/b;
end