% Continuous-Time Convolution Visualization with Gradient Effect
clear; clc; close all;

t = 0:0.01:5;
dt = t(2) - t(1);
x = ones(size(t));           % x(t) = u(t)
h = exp(-t);                 % h(t) = e^{-t}u(t)

figure('Name','Convolution Animation with Gradient','Position',[200 100 700 600]);

for k = 1:20:length(t)
    tau = t(k);

    % Geser h(t)
    h_shifted = interp1(t, h, tau - t, 'linear', 0);

    % Produk dan integral
    product = x .* h_shifted;
    y_tau = trapz(t, product);

    clf;

    % --- x(t) ---
    subplot(3,1,1);
    plot(t, x, 'b', 'LineWidth', 2);
    title('Input: x(t) = u(t)');
    ylim([0 1.2]); grid on;

    % --- h(tau - t) dengan gradasi warna ---
    subplot(3,1,2);
    hold on;
    cmap = jet(length(t));   % colormap untuk gradasi
    for n = 1:length(t)-1
        plot(t(n:n+1), h_shifted(n:n+1), 'Color', cmap(n,:), 'LineWidth', 2);
    end
    hold off;
    title(['Shifted: h(\tau - t), \tau = ' num2str(tau,'%.2f')]);
    ylim([0 1.2]); grid on;

    % --- x(t) * h(tau - t) ---
    subplot(3,1,3);
    area(t, product, 'FaceColor',[0 0.7 0], 'FaceAlpha',0.4, 'EdgeColor','g');
    hold on; plot(t, product, 'g', 'LineWidth', 2);
    title(['Product: x(t)·h(\tau - t), Integral ≈ ' num2str(y_tau,'%.3f')]);
    ylim([0 1.2]); grid on;

    pause(0.3);
end

