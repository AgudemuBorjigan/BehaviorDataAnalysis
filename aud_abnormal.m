function subjs_HI = aud_abnormal(rootDir, OS)
subjs = subjNames(strcat(rootDir, 'Audiogram'));
left = zeros(5, numel(subjs)); % thresholds in left ear at 5 different frequencies
right = zeros(5, numel(subjs));
dataArrayHL_left = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
dataArrayHL_right = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');
for i = 1:numel(subjs)
    threshRight = dataArrayHL_right{i}.thresh;
    threshLeft = dataArrayHL_left{i}.thresh;
    for k = 1:5 % 5 frequencies
        right(k, i) = threshRight(k);
        left(k, i) = threshLeft(k);
    end
end
count = 0;
% 25 HL is the cut-off
for i = 1:numel(subjs)
    if (~ all(right(:, i) < 25)) || (~ all(left(:, i) < 25))
        count = count + 1;
        subjs_HI{count} = subjs{i};
    end
end
end