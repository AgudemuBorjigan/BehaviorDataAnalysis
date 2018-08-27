perCorrt_co_rav = [23/25, 25/25, 22/25, 23/25, 13/25, 7/25]; 
perCorrt_sp_rav = [25/25, 24/25, 21/25, 25/25, 15/25, 7/25];

perCorrt_co_anna = [25/25, 25/25, 23/25, 17/25, 17/25, 11/25];
perCorrt_sp_anna = [25/25, 24/25, 23/25, 20/25, 20/25, 10/25];


SNR_co = [12, 9, 6, 3, 0, -3];
SNR_sp = [9, 6, 3, 0, -3, -6];

figure, scatter(SNR_co, perCorrt_co_rav, 'b');
hold on;
scatter(SNR_sp, perCorrt_sp_rav, 'b');
scatter(SNR_co, perCorrt_co_anna, 'r');
scatter(SNR_sp, perCorrt_sp_anna, 'r');
ylabel('Percent correct');
xlabel('SNR dB');

% fit psychometric functions
targets = [0.25, 0.5, 0.75]; % 25%, 50%, and 75% percent performance
weights = ones(1, length(SNR_co)); % no weighting

% fit for colocated, rav
[coeffsCoRav, curveCoRav, thresholdCoRav] = FitPsycheCurveLogit(SNR_co, perCorrt_co_rav, weights, targets);
% fit for separated, rav
[coeffsSpRav, curveSpRav, thresholdSpRav] = FitPsycheCurveLogit(SNR_sp, perCorrt_sp_rav, weights, targets);
% fit for colocated, anna
[coeffsCoAnna, curveCoAnna, thresholdCoAnna] = FitPsycheCurveLogit(SNR_co, perCorrt_co_anna, weights, targets);
% fit for separated, anna
[coeffsSpAnna, curveSpAnna, thresholdSpAnna] = FitPsycheCurveLogit(SNR_sp, perCorrt_sp_anna, weights, targets);

% plot psychometric curves
plot(curveCoRav(:,1), curveCoRav(:,2), 'b', 'LineWidth', 2);
plot(curveSpRav(:,1), curveSpRav(:,2), 'b', 'LineStyle', '--', 'LineWidth', 2);
plot(curveCoAnna(:,1), curveCoAnna(:,2), 'r', 'LineWidth', 2);
plot(curveSpAnna(:,1), curveSpAnna(:,2), 'r', 'LineStyle', '--', 'LineWidth', 2);
