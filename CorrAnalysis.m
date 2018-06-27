% Data collected
% ITDs = [36.88, 43.13, 28.13, 41.25, 34.38, 32.5, 52.5, 33.96, 35.32, 42.5,...
%     36.25, 44.07, 42.5, 19.38, 47.09, 49.53, 27.5, 38.75];

FMleft = [7.53, 4.5, 4.5, 7.5, 6, 5.5, 6, 11, 7.5, 6, 7.97, 4.73, 4.5, 2, 3, 1.5, 3, ...
    3, 5, 4.5, 2, 7, 7.5, 4.52];

FMright = [11.5, 6.5, 4.5, 6.5, 6.5, 5, 7, 11.77, 6.5, 6.5, 10, 6, 3.5, 3.5, 3, 3, ...
    3.5, 2, 2, 3, 3, 8, 6, 6.5];

FM = (FMleft + FMright)/2;


% evoked = [0.38, 0.59, 0.43, 0.37, 0.49, 0.11, 0.56, 0.6, 0.34, 0.99, 0.35, 0.4, 0.33, ...
%     0.36, 0.52, 0.36, 0.33, 0.39];

ITDs = [45, 45, 40, 20, 35, 30, 35, 65, 35, 50, 40, 40, 20, 15, 45, 32.81, 15, ...
    45, 49.53, 20, 20, 55, 15, 24.22];

evoked = [0.2, 0.38, 0.59, 0.43, 0.37, 0.49, 0.11, 0.56, 0.6, 0.34, 0.64, 0.99, 0.35, 0.4, 0.33, ...
    0.36, 0.36, 0.52, 0.36, 0.21, 0.33, 0.39, 0.13, 0.57];

% evoked_4 = [0.45, 1.05, 0.91, 0.91, 1.22, 0.81, 0.4, 1.25, 1.28, 0.73, 1.27, ...
%     1.37, 1.21, 1.14, 0.74, 1.04, 0.74, 1.07, 0.69, 0.42, 1.28, 0.62, 0.31, 1.38];
% 
% evoked_3 = [0.27, 0.55, 0.88, 0.87, 0.54, 1.5, 0.31, 1.1, 1.76, 0.73, 1.38, 1.68, ...
%     0.67, 1.31, 0.46, 0.87, 0.92, 0.61, 0.59, 0.8, 0.6, 1, 0.23, 1.09];
% 
% evoked_2 = [0.32, -0.01, 1.15, 0.11, 0.15, 0.24, 0.03, 0.25, 0.1, 0.12, 1.03, 1.19, 0.32, ...
%     0.27, 0.12, 0.37, 0.34, 0.66, 0.18, 0.19, 0.24, 0.16, 0.03, 0.25];
% 
% evoked_1 = [0.18, -0.04, 0.46, -0.01, 0.11, -0.04, -0.02, 0.07, 0.2, 0.04, 0.15, 0.09, 0.16, ...
%     0.24, 0.05, -0.03, -0.05, 0.11, 0.07, 0, 0.29, -0.04, 0.09, -0.08];
%%
% [corr_ITDs_FMleft, p_ITDs_FMleft] = corrcoef(ITDs, FMleft);
% [corr_ITDs_FMright, p_ITDs_FMright] = corrcoef(ITDs, FMright);

[corr_ITDs_FM, p_ITDs_FM] = corrcoef(ITDs, FMright);
[corr_ITDs_evoked, p_ITDs_evoked] = corrcoef(ITDs, evoked);
% [corr_evoked_FM, p_evoked_FM] = corrcoef(evoked, FM);

% [corr_ITDs_evoked1, p_ITDs_evoked1] = corrcoef(ITDs, evoked_1);
% [corr_evoked1_FM, p_evoked1_FM] = corrcoef(evoked_1, FM);
% 
% [corr_ITDs_evoked2, p_ITDs_evoked2] = corrcoef(ITDs, evoked_2);
% [corr_evoked2_FM, p_evoked2_FM] = corrcoef(evoked_2, FM);
% 
% [corr_ITDs_evoked3, p_ITDs_evoked3] = corrcoef(ITDs, evoked_3);
% [corr_evoked3_FM, p_evoked3_FM] = corrcoef(evoked_3, FM);
% 
% [corr_ITDs_evoked4, p_ITDs_evoked4] = corrcoef(ITDs, evoked_4);
% [corr_evoked4_FM, p_evoked4_FM] = corrcoef(evoked_4, FM);

%%
figure(1);
% ITD vs FM
subplot(1,2,1);
plot(ITDs', FM', '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
hold on;
ref = refline(0,0);
set(ref, 'Color', 'k', 'LineStyle', '-.');
xlabel('ITD threshold [us]');
ylabel('FM threshold [Hz]');
title('ITD vs FM threshold');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITDs_FM(1,2); p = p_ITDs_FM(1,2);
info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

% ITD vs evoked
subplot(1,2,2);
plot(ITDs', evoked', '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
hold on;
ref = refline(0,0);
set(ref, 'Color', 'k', 'LineStyle', '-.');
xlabel('ITD threshold [us]');
ylabel('Evoked response amplitude');
title('ITD vs Evoked');
set(gca, 'FontSize', 16);

dim = [.5 .5 .3 .3];
corr = corr_ITDs_evoked(1,2); p = p_ITDs_evoked(1,2);
info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

% % evoked vs FM 
% subplot(1,3,3);
% plot(evoked', FM', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('Evoked response amplitude');
% ylabel('FM threshold [Hz]');
% title('Evoked vs FM threshold');
% set(gca, 'FontSize', 16);
% 
% dim = [.75 .5 .3 .3];
% corr = corr_evoked_FM(1,2); p = p_evoked_FM(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');


% %%
% figure(2);
% subplot(1,2,1);
% plot(ITDs', FMleft', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('ITD threshold [us]');
% ylabel('FM threshold (left) [Hz]');
% title('ITD vs FM threshold (left)');
% set(gca, 'FontSize', 16);
% 
% dim = [.2 .5 .3 .3];
% corr = corr_ITDs_FMleft(1,2); p = p_ITDs_FMleft(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% subplot(1,2,2);
% plot(ITDs', FMright', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('ITD threshold [us]');
% ylabel('FM threshold (right) [Hz]');
% title('ITD vs FM threshold (right)');
% set(gca, 'FontSize', 16);
% 
% dim = [.7 .5 .3 .3];
% corr = corr_ITDs_FMright(1,2); p = p_ITDs_FMright(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

% %%
% fig3 = figure(3);
% % ITD condition 1
% h1 = subplot(2,2,1);
% plot(ITDs', evoked_1', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('ITD threshold [us]');
% ylabel('Evoked');
% title('condition 1');
% set(gca, 'FontSize', 16);
% 
% dim = [.2 .6 .3 .3];
% corr = corr_ITDs_evoked1(1,2); p = p_ITDs_evoked1(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% h2 = subplot(2,2,2);
% plot(ITDs', evoked_2', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('ITD threshold [us]');
% ylabel('Evoked');
% title('condition 2');
% set(gca, 'FontSize', 16);
% 
% dim = [.6 .6 .3 .3];
% corr = corr_ITDs_evoked2(1,2); p = p_ITDs_evoked2(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% h3 = subplot(2,2,3);
% plot(ITDs', evoked_3', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('ITD threshold [us]');
% ylabel('Evoked');
% title('condition 3');
% set(gca, 'FontSize', 16);
% 
% dim = [.2 .1 .3 .3];
% corr = corr_ITDs_evoked3(1,2); p = p_ITDs_evoked3(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% h4 = subplot(2,2,4);
% plot(ITDs', evoked_4', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('ITD threshold [us]');
% ylabel('Evoked');
% title('condition 4');
% set(gca, 'FontSize', 16);
% 
% dim = [.6 .1 .3 .3];
% corr = corr_ITDs_evoked4(1,2); p = p_ITDs_evoked4(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% % YLabelH1 = get(h1, 'YLabel');
% % set(YLabelH1, 'String', 'Evoked vs ITD');
% 
% % axes = findobj(fig3, 'Type', 'Axes');
% % titles = get(axes, 'Title');
% % titleOne = [titles{:}];
% % set(titleOne, 'String', 'Evoked vs ITD');
% 
% %%
% fig3 = figure(4);
% % ITD condition 1
% h1 = subplot(2,2,1);
% plot(FM', evoked_1', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('FM [Hz]');
% ylabel('Evoked amplitude');
% title('condition 1');
% set(gca, 'FontSize', 16);
% 
% dim = [.2 .6 .3 .3];
% corr = corr_evoked1_FM(1,2); p = p_evoked1_FM(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% h2 = subplot(2,2,2);
% plot(FM', evoked_2', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('FM [Hz]');
% ylabel('Evoked amplitude');
% title('condition 2');
% set(gca, 'FontSize', 16);
% 
% dim = [.6 .6 .3 .3];
% corr = corr_evoked2_FM(1,2); p = p_evoked2_FM(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% h3 = subplot(2,2,3);
% plot(FM', evoked_3', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('FM [Hz]');
% ylabel('Evoked amplitude');
% title('condition 3');
% set(gca, 'FontSize', 16);
% 
% dim = [.2 .1 .3 .3];
% corr = corr_evoked3_FM(1,2); p = p_evoked3_FM(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
% 
% h4 = subplot(2,2,4);
% plot(FM', evoked_4', '+', 'LineWidth', 2);
% hold on;
% l = lsline;
% set(l, 'Color', 'r', 'LineWidth', 2);
% hold on;
% ref = refline(0,0);
% set(ref, 'Color', 'k', 'LineStyle', '-.');
% xlabel('FM [Hz]');
% ylabel('Evoked amplitude');
% title('condition 4');
% set(gca, 'FontSize', 16);
% 
% dim = [.6 .1 .3 .3];
% corr = corr_evoked4_FM(1,2); p = p_evoked4_FM(1,2);
% info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
% annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');