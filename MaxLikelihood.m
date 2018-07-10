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
    S = load(strcat(filePath, '/', fileName));
    if strcmp(ITDorFM, 'FM')
        ListPmtr{i} = S.fdevList;
        ListResp{i} = S.respList;
    else
        ListPmtr{i} = S.ITDList*1e6;
        ListResp{i} = S.respList;
    end
end
PmtrAllWithZero = cat(2, ListPmtr{1}, ListPmtr{2}, ListPmtr{3}, ListPmtr{4});
RespAllWithZero = cat(2, ListResp{1}, ListResp{2}, ListResp{3}, ListResp{4});
pmtrCorrt = PmtrAllWithZero(RespAllWithZero == 1);
pmtrWrong = PmtrAllWithZero(RespAllWithZero == 0);

% probability of correct answers
a = sym('x', [1, 2]);
syms p_corrt(k, T)
for i = 1:numel(pmtrCorrt)
    p_corrt = 0.5 + 0.5/(1+exp(-a(1)*(pmtrCorrt(i) - a(2))));
    if i == 1
        p_corrt_mul = p_corrt;
    else
        p_corrt_mul = p_corrt_mul * p_corrt;
    end
end

% probabiliy of wrong answers
syms p_wrong(k, T)
for i = 1:numel(pmtrWrong)
    p_wrong = 0.5 - 0.5/(1+exp(-a(1)*(pmtrWrong(i) - a(2))));
    if i == 1
        p_wrong_mul = p_wrong;
    else
        p_wrong_mul = p_wrong_mul * p_wrong;
    end
end

likelihood = p_corrt_mul * p_wrong_mul;
save('likelihood');
eqn1 = diff(likelihood, a(1)) == 0;
eqn2 = diff(likelihood, a(2)) == 0;
[solT, solk] = vpasolve(eqn1, eqn2);
% fun = @funcLikelihood;
% [solT, solk] = fsolve(fun, [0, 0]);
end


