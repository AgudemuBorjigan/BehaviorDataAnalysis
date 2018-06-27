function [threshArray, meanThresh, closestPerCorr] = BehaviorDataAnalysis(subID, ITDOrFM, LeftOrRight)
if strcmp(ITDOrFM, 'ITD')
    filePath = strcat('/home/agudemu/Data/Behavior/', subID, '_behavior/', subID);
else
    filePath = strcat('/home/agudemu/Data/Behavior/', subID, '_behavior/', subID, '_', LeftOrRight);
end
files = dir(strcat(filePath,'/*.mat'));
threshArray = zeros(1,numel(files));
ListPmtr = cell(1, numel(files));
ListResp = cell(1, numel(files));
trialNum = zeros(1, numel(files));
for i = 1:numel(files)
    fileName = files(i).name;
    load(strcat(filePath, '/', fileName));
    if strcmp(ITDOrFM, 'FM')
        ListPmtr{i} = fdevList;
        ListResp{i} = respList;
        threshArray(i) = thresh;
        trialNum(i) = numel(fdevList);
        for j = 1:numel(respList)
            respList(j) = respList(j) - 0.01*j;
        end
        figure(1);
        plot(fdevList, respList-0.05*(i-1), 'o'); 
    else
        ListPmtr{i} = ITDList*1e6;
        ListResp{i} = respList;
        threshArray(i) = thresh*1e6;
        trialNum(i) = numel(ITDList);
        for j = 1:numel(respList)
            respList(j) = respList(j) - 0.01*j;
        end
        figure(1);
        plot(ITDList*1e6, respList-0.05*(i-1), 'o');
    end
    hold on;
end
meanThresh = mean(threshArray); % average of 4 repetitions
PmtrAllWithZero = cat(2, ListPmtr{1}, ListPmtr{2}, ListPmtr{3}, ListPmtr{4});
if strcmp(ITDOrFM, 'ITD')
    PmtrAllWithZero = int16(PmtrAllWithZero); % the first zero ITD or frequency deviation is not technically zero, rather it's a very small number
end
PmtrAll = PmtrAllWithZero(PmtrAllWithZero ~= 0); % excluding 0 ITDs or frequency deviation
RespAllWithZero = cat(2, ListResp{1}, ListResp{2}, ListResp{3}, ListResp{4});
RespAll = RespAllWithZero(PmtrAllWithZero ~= 0);

% the number of responses excluding responses to zero ITDs or frequency
% deviation 
NumGuess = sum(RespAll(PmtrAll<meanThresh));
NumWrong = numel(RespAll(PmtrAll<meanThresh))-NumGuess;
NumCorrect = sum(RespAll(PmtrAll>meanThresh));
NumMistakes = numel(RespAll(PmtrAll>meanThresh))-NumCorrect;

% the number of responses including responses to zero ITDs or frequency
% deviation
NumGuessWithZero = sum(RespAllWithZero(PmtrAllWithZero<meanThresh));
NumWrongWithZero = numel(RespAllWithZero(PmtrAllWithZero<meanThresh))-NumGuessWithZero;
NumCorrectWithZero = sum(RespAllWithZero(PmtrAllWithZero>meanThresh));
NumMistakesWithZero = numel(RespAllWithZero(PmtrAllWithZero>meanThresh))-NumCorrectWithZero;

% percent correct calculation below each ITD that is in the range of ITD
% measured
ITDFdevs = unique(PmtrAll);
numOnes = zeros(1, numel(ITDFdevs));
numZeros = zeros(1, numel(ITDFdevs));
ITDFdevs = double(min(ITDFdevs)): 0.01 : double(max(ITDFdevs));
perCorr = zeros(1, numel(ITDFdevs));
ITDFdevsWithZeros = unique(PmtrAllWithZero);
for i = 1:numel(ITDFdevs)
    numResp = numel(RespAll(PmtrAll <= ITDFdevs(i)));
    corrs = sum(RespAll(PmtrAll <= ITDFdevs(i)));
    perCorr(i) = corrs/numResp;
end
[~, indexITDFdev] = min(abs(perCorr - 0.75));
Thresh = ITDFdevs(indexITDFdev);
closestPerCorr = perCorr(indexITDFdev)*100;

% plotting the reference line for two thresholds
plot([Thresh, Thresh], [-1, 1], 'g');
plot([meanThresh, meanThresh], [-1,1], 'r'); 

annotation('textbox', [.2 .5 .3 .3], 'String', strcat('Num of guesses: ', num2str(NumGuessWithZero)), 'FitBoxToText', 'on');
annotation('textbox', [.2 .2 .3 .3], 'String', strcat('Num of wrong answers: ', num2str(NumWrongWithZero)), 'FitBoxToText', 'on');
annotation('textbox', [.5 .5 .3 .3], 'String', strcat('Num of correct answers: ', num2str(NumCorrectWithZero)), 'FitBoxToText', 'on');
annotation('textbox', [.5 .2 .3 .3], 'String', strcat('Num of mistakes: ', num2str(NumMistakesWithZero)), 'FitBoxToText', 'on');

if strcmp(ITDOrFM, 'FM')
    title(strcat('Subject response: ', subID, LeftOrRight));
else
    title(strcat('Subject response: ', subID));
end

if strcmp(ITDOrFM, 'FM')
    xlabel('Fdev [Hz]');
else
    xlabel('ITD [us]');
end
ylabel('Correct or wrong');
legend('Rep1', 'Rep2', 'Rep3', 'Rep4', strcat('Adjusted threshold---', num2str(Thresh), 'us, at', num2str(closestPerCorr),'%'), strcat('meanThreshold---', num2str(meanThresh), 'us, at', ...
    num2str(NumGuessWithZero/(NumGuessWithZero + NumWrongWithZero)*100), '%'));

% ones and zeros as a function of ITDs
for i = 1:numel(ITDFdevsWithZeros)
    % number of responses with responses to the zero ITDs included
    respITDFdev = RespAllWithZero(PmtrAllWithZero == ITDFdevsWithZeros(i));
    numOnes(i) = sum(respITDFdev);
    numZeros(i) = numel(respITDFdev) - numOnes(i);
end
figure(2);
plot(ITDFdevsWithZeros, numOnes, '-.ko');
hold on;
plot(ITDFdevsWithZeros, numZeros, '--b*');
hold on;
plot([meanThresh, meanThresh], [0,40], 'r');
plot([Thresh, Thresh], [0, 40], 'g');
if strcmp(ITDOrFM, 'FM')
    xlabel('Fdev [Hz]');
    title(strcat('Number of ones and zeros vs Fdevs: ', subID, LeftOrRight));
    
else
    xlabel('ITD [us]');
    title(strcat('Number of ones and zeros vs ITDs: ', subID));
end
ylabel('Number of responses');
legend('Correct', 'Wrong', strcat('meanThreshold---', num2str(meanThresh), 'us, at', num2str(NumGuessWithZero/(NumGuessWithZero + NumWrongWithZero)*100), '%'), ...
    strcat('Adjusted threshold---', num2str(Thresh), 'us, at', num2str(closestPerCorr), '%'));
str = {strcat('Num of corrects below threshold: ', num2str(NumGuessWithZero)), ...
    strcat('Num of total responses below threshold: ', num2str(NumGuessWithZero+NumWrongWithZero)), ...
    strcat('Percent correct: ', num2str(NumGuessWithZero/(NumGuessWithZero + NumWrongWithZero)*100), '%')};
annotation('textbox', [.2 .5 .3 .3], 'String', str, 'FitBoxToText', 'on');
%% Percent correct
% figure(3);
% PmtrUnique = unique(PmtrAll);
% PmtrReps = histc(PmtrAll, PmtrUnique); % repetitions of an ITD
% percentCorrt = zeros(1, numel(PmtrUnique));
% for i = 1:numel(PmtrUnique)
%     correct = sum(RespAll(PmtrAll == PmtrUnique(i)));
%     percentCorrt(i) = correct/PmtrReps(i)*100;
% end
% plot(PmtrUnique, percentCorrt, 'o');
% xlabel('ITD [us]');
% ylabel('Percent correct [%]');
% title('Percent corrects vs ITDs');
% parameter trace plot
% figure(4);
% for i = 1:numel(files)
%     if i == 1
%         trialNumTtl = trialNum(i);
%         plot(1:trialNumTtl, ListPmtr{i},'-o');
%     else
%         plot((trialNumTtl + 1):(trialNumTtl + trialNum(i)), ListPmtr{i},'-o');
%         trialNumTtl = trialNumTtl + trialNum(i);
%     end
%     hold on;
% end
% if strcmp(ITDOrFM, 'ITD')
%     ylabel('ITD [us]');
% else
%     ylabel('Frequency deviation [Hz]');
% end
% title(strcat('Parameter trace: ', subID));
% xlabel('Number of trials');
% legend('Rep1', 'Rep2', 'Rep3', 'Rep4');
