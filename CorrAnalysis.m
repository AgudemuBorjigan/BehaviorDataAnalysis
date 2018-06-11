ITDs = [97.03, 56.88, 38.59, 44.53, 42.50, 40.94, 36.56, 34.69, 39.22, 46.25, 32.81, 24.69, 45.47];
FMleft = [6.91, 7.53, 3.61, 4.00, 4.95, 4.73, 4.40, 4.09, 2.98, 2.86, 2.52, 3.03, 2.48];
FMright = [8.25, 10.08, 4.88, 3.48, 5.58, 3.97, 6.64, 2.91, 3.73, 3.52, 2.77, 2.73, 2.41];
evoked = [1.16, 0.57, 0.85, 0.93, 1.28, 1.45, 0.83, 0.97, 0.93, 0.67, 0.86, 0.61, 0.94];
% evoked_1 = [0.43, 0.43, 0.84, 0.64];
% evoked_2 = [1.12, 0.63, 0.70, 0.53];
% evoked_3 = [1.43, 0.76, 1.00, 0.90];
% evoked_4 = [1.29, 0.90, 1.00, 1.06];


[corr_ITDs_evoked, p_evoked] = corrcoef(ITDs, evoked);
[corr_ITDs_FMleft, p_FMleft] = corrcoef(ITDs, FMleft);
[corr_ITDs_FMright, p_FMright] = corrcoef(ITDs, FMright);

figure(1);
plot(ITDs', evoked', '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
hold on;
ref = refline(0,0);
set(ref, 'Color', 'k', 'LineStyle', '-.');
xlabel('ITD threshold [us]');
ylabel('Normalized amplitude of evoked response');
title('ITD vs normalized evoked amplitude');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITDs_evoked(1,2); p = p_evoked(1,2);
info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

figure(2);
plot(ITDs', FMleft', '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
hold on;
ref = refline(0,0);
set(ref, 'Color', 'k', 'LineStyle', '-.');
xlabel('ITD threshold [us]');
ylabel('FM threshold (left) [Hz]');
title('ITD vs FM threshold (left)');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITDs_FMleft(1,2); p = p_FMleft(1,2);
info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');

figure(3);
plot(ITDs', FMright', '+', 'LineWidth', 2);
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 2);
hold on;
ref = refline(0,0);
set(ref, 'Color', 'k', 'LineStyle', '-.');
xlabel('ITD threshold [us]');
ylabel('FM threshold (right) [Hz]');
title('ITD vs FM threshold (right)');
set(gca, 'FontSize', 16);

dim = [.2 .5 .3 .3];
corr = corr_ITDs_FMright(1,2); p = p_FMright(1,2);
info = strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)); 
annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
