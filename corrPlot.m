function corrPlot(input1, input2, corrMatrix, pMatrix, num, label_x, label_y, label_title)
figure;
plot(input1, input2, '+', 'MarkerSize', 8, 'LineWidth', 2); 
hold on;
l = lsline;
set(l, 'Color', 'r', 'LineWidth', 4);
ylabel(label_y);
xlabel(label_x);
title(label_title);
set(gca, 'FontSize', 8);

dim = [.2 .5 .3 .3];
corr = corrMatrix(1,2); p = pMatrix(1,2);
info = {strcat('corr = ', num2str(corr), ', ', 'p = ', num2str(p)), num2str(num)}; 
an = annotation('textbox', dim, 'String', info, 'FitBoxToText', 'on');
an.FontSize = 16;
end