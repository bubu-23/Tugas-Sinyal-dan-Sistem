% --- Step-by-Step Continuous Convolution (Enhanced Visualization) ---
clear; clc; close all;

% 1. DEFINE SIGNALS
dt = 0.05;
tau = -2:dt:8;

x = (tau >= 0 & tau <= 2);                % Rectangular pulse
h = tripuls(tau - 1, 2);                  % Triangular pulse

% 2. TIME AXIS FOR OUTPUT
t_start = tau(1) + tau(1);
t_end = tau(end) + tau(end);
t = t_start:dt:t_end;
y = zeros(1, length(t));

% Flipped h
h_flipped = fliplr(h);
tau_flipped = -fliplr(tau);

% Visualization
figure('Name','Continuous Convolution Steps','Position',[50,50,1000,800]);

t_visual_indices = 1:3:length(t); % animate every 3rd step

for i = t_visual_indices
    current_t = t(i);

    clf;

    % Subplot 1: x(tau)
    subplot(4,1,1);
    plot(tau, x, 'b', 'LineWidth', 2);
    title(['Step for t = ', num2str(current_t,'%.2f')]);
    ylabel('x(\tau)','FontWeight','bold');
    grid on; ylim([0,1.2]); xlim([t_start, t_end]);

    % Subplot 2: h(t-tau)
    subplot(4,1,2);
    plot(tau_flipped+current_t, h_flipped, 'r', 'LineWidth', 2);
    ylabel('h(t-\tau)','FontWeight','bold');
    grid on; ylim([0,1.2]); xlim([t_start, t_end]);

    % Shifted version for multiplication
    h_shifted = interp1(tau_flipped+current_t, h_flipped, tau, 'linear', 0);

    % Product
    product = x .* h_shifted;
    y(i) = sum(product)*dt;

    % Subplot 3: Product area
    subplot(4,1,3);
    area(tau, product, 'FaceColor',[0 0.7 0], 'FaceAlpha',0.5, 'EdgeColor','g');
    ylabel('x(\tau)h(t-\tau)','FontWeight','bold');
    grid on; ylim([0,1.2]); xlim([t_start, t_end]);

    % Subplot 4: Result so far
    subplot(4,1,4);
    plot(t, y, 'm', 'LineWidth', 2); hold on;
    plot([current_t current_t],[0 max(y)],'k--'); % vertical line tracker
    title(sprintf('y(%.2f) = %.3f', current_t, y(i)));
    ylabel('y(t)','FontWeight','bold'); xlabel('t','FontWeight','bold');
    grid on; xlim([t_start, t_end]);

    drawnow;
end

% Final calculation for smooth result
for i = 1:length(t)
    current_t = t(i);
    h_shifted = interp1(tau_flipped+current_t, h_flipped, tau, 'linear', 0);
    product = x .* h_shifted;
    y(i) = sum(product)*dt;
end

% Final result plot
subplot(4,1,4);
plot(t, y, 'm', 'LineWidth', 3);
title('Final Result: y(t) = (x*h)(t)');

