% --- Corrected & Compatible Discrete Convolution (step-by-step) ---
clear; clc; close all;

% 1. DEFINE SIGNALS
k = -2:10;                               % index vector
x = double(k >= 0 & k <= 4);             % rectangular pulse
h = (0.8) .^ (k) .* double(k >= 0 & k <= 6); % decaying ramp

% 2. OUTPUT INDEX RANGE
n_start = k(1) + k(1);
n_end   = k(end) + k(end);
n = n_start:n_end;
y = zeros(1, length(n));

% 3. FIGURE SETUP (pakai subplot biar aman di MATLAB & Octave)
figure('Name','Discrete Convolution Steps','Color','w','Position',[100,100,1000,700]);

% 4. STEP-BY-STEP COMPUTATION
for i = 1:length(n)
    current_n = n(i);

    % hitung index h yang sesuai (h[n-k])
    idx_h_needed = current_n - k;
    [tf, loc] = ismember(idx_h_needed, k);

    % align h dengan x
    h_aligned = zeros(size(k));
    h_aligned(tf) = h(loc(tf));

    % product & sum
    product = x .* h_aligned;
    y(i) = sum(product);

    % ---------------- Visualization ----------------
    subplot(4,1,1); cla;
    stem(k, x, 'b','filled','LineWidth',1.2);
    title(['x[k], computing y[' num2str(current_n) ']']);
    xlim([n_start n_end]); ylim([0 1.2]); grid on; ylabel('x[k]');

    subplot(4,1,2); cla;
    stem(k, h_aligned, 'r','filled','LineWidth',1.2);
    title('h[n-k] (aligned)');
    xlim([n_start n_end]); ylim([0 max(h)+0.2]); grid on; ylabel('h[n-k]');

    subplot(4,1,3); cla;
    stem(k, product, 'g','filled','LineWidth',1.2);
    title('Product: x[k]·h[n-k]');
    xlim([n_start n_end]); ylim([0 1.2]); grid on; ylabel('product');

    subplot(4,1,4); cla;
    stem(n, y, 'm','filled','LineWidth',1.2); hold on;
    stem(current_n, y(i), 'ko','filled','MarkerSize',6); % highlight titik aktif
    title(sprintf('y[%d] = sum(x[k]·h[n-k]) = %.2f', current_n, y(i)));
    xlim([n_start n_end]); ylim([0 max(y)+0.5]); grid on;
    xlabel('n'); ylabel('y[n]');

    pause(0.3);
end

% 5. FINAL COMPARISON WITH MATLAB conv()
y_conv = conv(x, h);                          % hasil conv bawaan MATLAB
n_conv = (0:length(y_conv)-1) + (k(1)+k(1));  % index hasil conv

figure('Color','w','Position',[200,200,900,350]);
subplot(1,2,1);
stem(n, y, 'm','filled'); title('Manual step-by-step y[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(1,2,2);
stem(n_conv, y_conv, 'k','filled'); title('MATLAB conv(x,h)');
xlabel('n'); ylabel('Amplitude'); grid on;

% print hasil ke command window
disp('Manual y[n] ='); disp(y);
disp('conv(x,h)  ='); disp(y_conv);

