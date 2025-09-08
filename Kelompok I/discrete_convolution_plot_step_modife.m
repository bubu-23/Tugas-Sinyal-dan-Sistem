% --- Step-by-Step Discrete Convolution (Grid View with Highlight) ---
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

% 3. GRID VISUALIZATION
figure('Name','Discrete Convolution (Grid View)','Position',[100 100 1200 800]);

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

    % --- SUBPLOTS IN GRID ---
    subplot(length(n), 3, (i-1)*3 + 1);
    stem(k, x, 'b','filled','LineWidth',1.2); hold on;
    stem(k_flipped+current_n, h_flipped,'r','filled','LineWidth',1.2);
    title(['Step ', num2str(i), ' → y[', num2str(current_n), ']']);
    ylabel('Signals');
    grid on; xlim([n_start, n_end]);

    subplot(length(n), 3, (i-1)*3 + 2);
    stem(k, product,'g','filled','LineWidth',1.2);
    title('x[k]·h[n-k]');
    grid on; xlim([n_start, n_end]);

    subplot(length(n), 3, (i-1)*3 + 3);
    stem(n(1:i), y(1:i),'m','filled','LineWidth',1.2);
    title(['Partial y[n], sum = ', num2str(y(i),'%.2f')]);
    grid on; xlim([n_start, n_end]); ylim([0, max(y)+1]);
end

% 4. FINAL RESULT
figure('Name','Final Convolution Result');
stem(n,y,'filled','k','LineWidth',1.8);
title('Final Convolution Output y[n]');
xlabel('n'); ylabel('y[n]');
grid on; ylim([0, max(y)+1]);

disp('Final convolved signal y[n]:');
disp(y);

