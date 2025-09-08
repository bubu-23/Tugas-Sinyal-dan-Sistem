% --- Step-by-Step Discrete Convolution (Improved Version) ---
clear; clc; close all;

% 1. DEFINE SIGNALS
k = -2:10;
x = (k >= 0 & k <= 4);                     % x[k] = rectangular pulse
h = (0.8).^k .* (k >= 0 & k <= 6);         % h[k] = decaying ramp

% 2. INITIALIZE CONVOLUTION
n_start = k(1) + k(1);
n_end   = k(end) + k(end);
n = n_start:n_end;
y = zeros(1, length(n));

% Flip h[k] -> h[-k]
h_flipped = fliplr(h);
k_flipped = -fliplr(k);

% 3. STEP-BY-STEP VISUALIZATION
figure('Name','Discrete Convolution Steps','Position',[50 50 1000 750]);

for i = 1:length(n)
    current_n = n(i);
    clf;

    % Plot original x[k]
    subplot(4,1,1);
    stem(k, x,'b','filled','LineWidth',1.5); hold on;
    xline(current_n,'--k','LineWidth',1); % vertical marker
    title(['Step ', num2str(i), ' of ', num2str(length(n)), ...
           ' → Calculating y[', num2str(current_n), ']']);
    ylabel('x[k]'); grid on; xlim([n_start, n_end]);

    % Plot shifted h[n-k]
    subplot(4,1,2);
    stem(k_flipped+current_n, h_flipped,'r','filled','LineWidth',1.5);
    xline(current_n,'--k','LineWidth',1);
    ylabel('h[n-k]'); grid on; xlim([n_start, n_end]);

    % Overlap calculation
    [k_common, ix, ih] = intersect(k, k_flipped + current_n);
    product = zeros(1, length(k));
    if ~isempty(k_common)
        product(ix) = x(ix).*h_flipped(ih);
    end
    y(i) = sum(product);

    % Plot product x[k]h[n-k]
    subplot(4,1,3);
    stem(k, product,'g','filled','LineWidth',1.5);
    ylabel('Product'); grid on; xlim([n_start, n_end]);

    % Plot partial result y[n]
    subplot(4,1,4);
    stem(n, y,'m','filled','LineWidth',1.5); hold on;
    stem(current_n, y(i),'ko','filled','MarkerSize',7); % highlight current point
    ylabel('y[n]'); xlabel('n'); grid on; xlim([n_start, n_end]);

    % Display calculation details
    non_zero = product(product~=0);
    if isempty(non_zero)
        sum_str = '0';
    else
        sum_str = strjoin(arrayfun(@(v) sprintf('%.2f',v), non_zero,'UniformOutput',false),' + ');
    end
    sgtitle(sprintf('y[%d] = %s = %.2f',current_n,sum_str,y(i)),'FontWeight','bold');

    pause(1); % control animation speed
end

% 4. FINAL RESULT
figure('Name','Final Convolution Result','Position',[300 100 800 400]);
stem(n,y,'m','filled','LineWidth',1.5); grid on;
title('Final Convolution Result y[n]'); xlabel('n'); ylabel('y[n]');

