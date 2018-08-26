function [llhd] = likelihood(k, T, xCrrt, xWrong)

j = 0;
for i = 1:numel(xCrrt)
    pCrrt = 0.5 + 0.5 / (1 + exp(-k * (xCrrt(i) - T)));
    %     if pCrrt ~= 0
    %         j = j + 1;
    if i == 1
        pCrrtMul = pCrrt;
    else
        pCrrtMul = pCrrtMul * pCrrt;
    end
    %     end
end

j = 0;
for i = 1:numel(xWrong)
    pWrong = 0.5 - 0.5 / (1 + exp(-k * (xWrong(i) - T)));
    %     if pWrong ~= 0
    %         j = j + 1;
    if i == 1
        pWrongMul = pWrong;
    else
        pWrongMul = pWrongMul * pWrong;
    end
    %     end
end

llhd = pCrrtMul * pWrongMul;
end