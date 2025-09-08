% --- Step-by-Step Discrete Convolution (Animated with Highlight Overlap) ---
clear; clc; close all;

% 1. DEFINE SIGNALS
k = -2:10;                                   % Index range
x = (k >= 0 & k <= 4);                       % Rectangular pulse
h = (0.8).^k .* (k >= 0 & k <= 6);           % Decaying ramp

% 2. PREPARE FOR CONVOLUTION
n_start = k(1) + k(1);
n_end   = k(end) + k(end);
n       = n_start:n_end;
y       = zeros(1, length(n));

h_flipped   = fliplr(h);                     % h[-k]
k_flipped   = -fliplr(k);

% 3. ANIMATED VISUALIZATION
figure('Name','Discrete Convolution with Highlight','Position',[100 100 1000 700]);

for i = 1:length(n)
    current_n = n(i);

    % Overlap indices
    [k_common, ix, ih] = intersect(k, k_flipped + current_n);

    % Product init
    product = zeros(1, length(k));
    if ~isempty(k_common)
        product(ix) = x(ix) .* h_flipped(ih);
    end
    y(i) = sum(product);

    % --- Plot 1: x[k] and shifted h[n-k] with overlap highlight ---
    subplot(3,1,1);
    stem(k, x, 'b','filled','LineWidth',1.5); hold on;
    stem(k_flipped+current_n, h_flipped,'r','filled','LineWidth',1.5);

    % Highlight overlap area (shaded)
    if ~isempty(k_common)
        area(k_common, min(x(ix), h_flipped(ih)), 'FaceColor',[0.7 0.9 0.7], 'FaceAlpha',0.5, 'EdgeColor','none');
    end
    hold off;
    title(['Step ', num2str(i), '/', num2str(length(n)), ' → Overlap for y[', num2str(current_n), ']']);
    legend('x[k]','h[n-k]','Overlap');
    grid on; xlim([n_start, n_end]); ylim([0, max([x,h])+1]);

    % --- Plot 2: product ---
    subplot(3,1,2);
    stem(k, product,'g','filled','LineWidth',1.5);
    title('Product: x[k]·h[n-k]');
    grid on; xlim([n_start, n_end]); ylim([0, max(product)+1]);

    % --- Plot 3: partial convolution result ---
    subplot(3,1,3);
    stem(n(1:i), y(1:i),'m','filled','LineWidth',1.8);
    title(['Partial Convolution y[n], y[', num2str(current_n), '] = ', num2str(y(i),'%.3f')]);
    xlabel('n'); ylabel('y[n]');
    grid on; xlim([n_start, n_end]); ylim([0, max(y)+1]);

    pause(1); % animasi tiap step
end

% 4. FINAL RESULT
figure('Name','Final Convolution Result');
stem(n,y,'filled','k','LineWidth',2);
title('Final Convolution Output y[n]');
xlabel('n'); ylabel('y[n]');
grid on; ylim([0, max(y)+1]);

disp('Final convolved signal y[n]:');
disp(y);

