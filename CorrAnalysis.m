%% Data collected

% Behavior
% Threshold "correction" based on the parameter value that has percent
% correct closest to 75%, counting all the responses before it, the percent
% correct is not exactly at its own value
% FMleft = [7.53, 4.5, 4.5, 7.5, 6, 5.5, 6, 11, 7.5, 6, 7.97, 4.73, 4.5, 2, 3, 1.5, 3, ...
%     3, 5, 4.5, 2, 7, 7.5, 4.52];
% 
% FMright = [11.5, 6.5, 4.5, 6.5, 6.5, 5, 7, 11.77, 6.5, 6.5, 10, 6, 3.5, 3.5, 3, 3, ...
%     3.5, 2, 2, 3, 3, 8, 6, 6.5];

% threshold correction based on maximum likelihooh estimation, at 75%
% FMleft = [4.1, 2.3, 2.5, 4.6, 3.9, 2.8, 4.8, 8.7, 4, 4.2, 6.7, 4.2, 2.4, 1.5, 1.9, 0.9, 1.9, ...
%     1.7, 2.4, 2.7, 1.3, 4.3, 5.5, 3.4];
% FMright = [8.6, 4.3, 2.7, 4.3, 4.3, 3.3, 4.3, 11.4, 3.7, 3.7, 7.4, 3.3, 2.3, 2.2, 1.9, 1.5, ...
%     1.9, 1.4, 1.6, 2, 1.5, 5.1, 4, 4.5];

% thresholds (maxlikelihood estimation) exluding those subjects with large
% different between two ears
FMleft = [2.5, 4.6, 3.9, 2.8, 4.8, 4, 4.2, 6.7, 4.2, 2.4, 1.5, 1.9, 0.9, 1.9, ...
    1.7, 2.4, 2.7, 1.3, 4.3];
FMright = [2.7, 4.3, 4.3, 3.3, 4.3, 3.7, 3.7, 7.4, 3.3, 2.3, 2.2, 1.9, 1.5, ...
    1.9, 1.4, 1.6, 2, 1.5, 5.1];

FM = (FMleft + FMright)/2;

% FMs selecting the bad ear after a few subjects excluded
% FM = [2.7, 4.6, 4.3, 3.3, 4.8, 4, 4.2, 7.4, 4.2, 2.4, 2.2, 1.9, 1.5, 1.9, 1.7, 2.4, 2.7, 1.5, 5.1];

% FM = abs(FMleft - FMright);

% Threshold "correction" based on percent correct calculation considering
% responses at values before the "potential threshold"
% ITDThreshs = [45, 45, 40, 20, 35, 30, 35, 65, 35, 50, 40, 40, 20, 15, 45, 32.81, 15, ...
%     45, 49.53, 20, 20, 55, 15, 24.22];

% Threshold estimation based on maximum likelihood estimation  
% ITDThreshs = [17, 28, 36, 17, 26, 21, 23, 51, 21, 26, 25, 27, 14, 22, 29, 11, 13, ...
%     27, 43, 14, 15, 39, 14, 8];

% Thresholds excluding subjects with large FM threshold difference between
% two ears
ITDThreshs = [36, 17, 26, 21, 23, 21, 26, 25, 27, 14, 22, 29, 11, 13, ...
    27, 43, 14, 15, 39];

% EEG
evoked = [0.15, 0.34, 0.52, 0.43, 0.27, 0.55, 0.12, 0.5, 0.4, 0.3, 0.87, 0.88, 0.51, ...
    0.64, 0.21, 0.48, 0.47, 0.57, 0.26, 0.26, 0.43, 0.4, 0.12, 0.58]; % auditory channels selected, peak selected by program

evoked_cond1 = [0.18, -0.03, -0.01, 0.01, 0.13, -0.01, 0.02, 0.08, 0.23, 0.05, 0.15, 0.09, 0.17, 0.38, 0.06, ...
    -0.03, 0.01, 0.11, 0.08, 0.01, 0.34, 0.12, 0.09, 0.06];
evoked_cond2 = [0.34, 0.07, 1.15, 0.15, 0.15, 0.25, 0.03, 0.26, 0.22, 0.12, 1.03, 1.2, 0.33, 0.28, 0.13, ...
    0.38, 0.34, 0.66, 0.19, 0.2, 0.25, 0.16, 0.03, 0.28];
evoked_cond3 = [0.28, 0.56, 0.88, 0.87, 0.56, 1.51, 0.32, 1.1, 1.78, 0.73, 1.39, 1.68, 0.68, 1.31, 0.47, 0.87, ...
    0.92, 0.62, 0.6, 0.81, 0.62, 1.02, 0.25, 1.11];
evoked_cond4 = [0.46, 1.06, 0.91, 0.92, 1.22, 0.81, 0.41, 1.25, 1.28, 0.73, 1.27, 1.37, 1.22, 1.16, 0.75, ...
    1.04, 0.74, 1.07, 0.69, 0.43, 1.29, 0.63, 0.32, 1.41];


%% plot data
figure(1);
% ITD vs FM
[corr_ITDs_FM, p_ITDs_FM] = corrcoef(ITDThreshs, FM);
plot(ITDThreshs', FM', '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
xlabel('ITD threshold [us]');
ylabel('FM threshold [Hz]');
title('ITD vs FM threshold');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITDs_FM(1,2); p = p_ITDs_FM(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), 'N = 24'}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

% ITD vs evoked
figure(2);
[corr_ITDs_evoked, p_ITDs_evoked] = corrcoef(ITDThreshs, evoked);
plot(ITDThreshs', evoked', '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
xlabel('ITD threshold [us]');
ylabel('Evoked response amplitude');
title('ITD vs Evoked');
set(gca, 'FontSize', 16);

dim = [.5 .5 .3 .3];
corr = corr_ITDs_evoked(1,2); p = p_ITDs_evoked(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), 'N = 24'}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

% evoeked magnitudes across onditions for each subject
figure(3);
ITDs = [20, 60, 180, 540]; % uSeconds
slopes = zeros(1, numel(evoked));
for i = 1:numel(evoked)
    evokeds = [evoked_cond1(i), evoked_cond2(i), evoked_cond3(i), evoked_cond4(i)];
    if i == numel(evoked)
        x1 = plot(ITDs, evokeds, '--ko');
    else
        plot(ITDs, evokeds, '--ko');
    end
    
    p = polyfit(ITDs, evokeds, 1);
    slopes(i) = p(1);
    
    hold on;
end
evokeds_avg = [mean(evoked_cond1), mean(evoked_cond2), mean(evoked_cond3), mean(evoked_cond4)];
x2 = plot(ITDs, evokeds_avg, '-ro', 'LineWidth', 2);
xlabel('ITD [us]');
ylabel('Normalized magnitude');
xticks([20, 60, 180, 540]);
xticklabels({'20', '60', '180', '540'});
title('Normalized evoked magnitudes across conditions');
legend([x1, x2], 'Individual subjects', 'Mean');

% ITD thresholds vs slopes
figure(4);
[corr_ITDs_slopes, p_ITDs_slopes] = corrcoef(ITDThreshs, slopes);
plot(ITDThreshs, slopes, '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
xlabel('ITD threshold [us]');
ylabel('Slopes');
title('ITD vs slopes');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITDs_slopes(1,2); p = p_ITDs_slopes(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), 'N = 24'}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

% FM difference vs Evoked response
figure(5);
[corr_FM_evoked, p_FM_evoked] = corrcoef(evoked, FM);
plot(evoked, FM, '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
ylabel('FM threshold [Hz]');
xlabel('Normalized magnitude');
title('FM vs evoked');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITDs_slopes(1,2); p = p_ITDs_slopes(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), 'N = 24'}; 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');