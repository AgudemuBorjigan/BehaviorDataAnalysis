function subjs_HI = audiogramPop(rootDir, OS)
subjs = subjNames(strcat(rootDir, 'FM'));
left = zeros(5, numel(subjs));
right = zeros(5, numel(subjs));
dataArrayHL_left = dataExtraction(subjs, OS, 'Audiogram', 'LeftEar');
dataArrayHL_right = dataExtraction(subjs, OS, 'Audiogram', 'RightEar');
for i = 1:numel(subjs)
    threshRight = dataArrayHL_right{i}.thresh;
    threshLeft = dataArrayHL_left{i}.thresh;
    for k = 1:5
        right(k, i) = threshRight(k);
        left(k, i) = threshLeft(k);
    end
end
count = 0;
for i = 1:numel(subjs)
    if (~ all(right(:, i) < 25)) || (~ all(left(:, i) < 25))
        count = count + 1;
        subjs_HI{count} = subjs{i};
    end
end
end