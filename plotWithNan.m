function h = plotWithNan(a, b)
i = ~isnan(a) & ~isnan(b);
h = plot(a(i), b(i), '--s', 'LineWidth', 1, 'MarkerSize', 8, 'Color', [0.3, 0.3, 0.3]);
% set(h, 'markerfacecolor', get(h, 'color'));
end