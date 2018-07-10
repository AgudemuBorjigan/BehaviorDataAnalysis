function MaxLikelihood(subID, ITDorFM, LeftOrRight)
if strcmp(ITDorFM, 'ITD')
    filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subID, '_behavior/', subID);
else
    filePath = strcat('/media/agudemu/Storage/Data/Behavior/', subID, '_behavior/', subID, '_', LeftOrRight);
end
files = dir(strcat(filePath,'/*.mat'));
ListPmtr = cell(1, numel(files));
ListResp = cell(1, numel(files));
for i = 1:numel(files)
    fileName = files(i).name;
    load(strcat(filePath, '/', fileName));
    if strcmp(ITDorFM, 'FM')
        ListPmtr{i} = fdevList;
        ListResp{i} = respList;
    else
        ListPmtr{i} = ITDList*1e6;
        ListResp{i} = respList;
    end
end
PmtrAllWithZero = cat(2, ListPmtr{1}, ListPmtr{2}, ListPmtr{3}, ListPmtr{4});
RespAllWithZero = cat(2, ListResp{1}, ListResp{2}, ListResp{3}, ListResp{4});
pmtrCorrt = PmtrAllWithZero(RespAllWithZero == 1);
pmtrWrong = PmtrAllWithZero(RespAllWithZero == 0);

% probability of correct answers
syms p_corrt(k, T)
for i = 1:numel(pmtrCorrt)
    p_corrt(k, T) = 0.5 + 0.5/(1+exp(-k*(pmtrCorrt(i) - T)));
    if i == 1
        p_corrt_mul = p_corrt(k, T);
    else
        p_corrt_mul = p_corrt_mul * p_corrt(k, T);
    end
end

% probabiliy of wrong answers
syms p_wrong(k, T)
for i = 1:numel(pmtrWrong)
    p_wrong(k, T) = 0.5 - 0.5/(1+exp(-k*(pmtrWrong(i) - T)));
    if i == 1
        p_wrong_mul = p_wrong(k, T);
    else
        p_wrong_mul = p_wrong_mul * p_wrong(k, T);
    end
end

likelihood = p_corrt_mul * p_wrong_mul;
eqn1 = diff(likelihood, k) == 0;
eqn2 = diff(likelihood, T) == 0;
[solT, solk] = vpasolve(eqn1, eqn2);
end


