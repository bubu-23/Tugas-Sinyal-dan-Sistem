% Discrete-Time Convolution Visualization (Modified Index k)
x = [1 2 3];         % Input signal x[n]
h = [1 1];           % Impulse response h[n]
N = length(x) + length(h) - 1;

% Tentukan rentang index (lebih lebar dari panjang sinyal)
k = -2:6;            % Ubah bagian t/index (sebelumnya 0:length(x)-1)

figure;
for n = 0:N-1
    clf;

    % Buat vektor sinyal sesuai panjang k
    x_plot = zeros(size(k));
    x_plot(k >= 0 & k <= length(x)-1) = x;

    hk = fliplr(h);
    hk_shifted_plot = zeros(size(k));

    % Geser h sesuai n
    for i = 1:length(h)
        idx = n - i + 1; % posisi index
        if any(k == idx)
            hk_shifted_plot(k == idx) = hk(i);
        end
    end

    % Perkalian titik demi titik
    product = x_plot .* hk_shifted_plot;
    y_n = sum(product);

    % Plot x[n]
    subplot(3,1,1);
    stem(k, x_plot, 'filled','r');
    title('x[n]'); ylim([0 4]); grid on;

    % Plot h yang sudah digeser
    subplot(3,1,2);
    stem(k, hk_shifted_plot, 'filled','b');
    title(['h[n-' num2str(n) '] (flipped & shifted)']); ylim([0 2]); grid on;

    % Plot hasil perkalian
    subplot(3,1,3);
    stem(k, product, 'filled','m');
    title(['x[k] \cdot h[n-k], sum = ' num2str(y_n)]); ylim([0 6]); grid on;

    pause(1);  % Pause untuk animasi
end

