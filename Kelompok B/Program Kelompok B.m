% Discrete-Time Convolution Visualization (Modified)
x = [2 2 5];          % Input signal x[n]
h = [2 2];            % Impulse response h[n]
N = length(x) + length(h) - 1;

y = zeros(1, N);      % Simpan hasil konvolusi

pause_time = 1;       % Durasi jeda animasi (detik)

figure;
for n = 0:N-1
    clf;
    k = 0:length(x)-1;           % Indeks untuk x
    hk_shifted = zeros(1, length(x));

    % Geser h sesuai posisi n
    for i = 1:length(h)
        idx = n - (i-1);
        if idx >= 1 && idx <= length(x)
            hk_shifted(idx) = h(i);
        end
    end

    % Hitung hasil sementara
    product = x .* hk_shifted;
    y_n = sum(product);
    y(n+1) = y_n;   % Simpan hasil ke array

    % === Plotting ===
    subplot(4,1,1);
    stem(k, x, 'filled'); title('x[n]'); ylim([0 6]); grid on;

    subplot(4,1,2);
    stem(k, hk_shifted, 'filled','r');
    title(['h[n-' num2str(n) '] (shifted)']); ylim([0 3]); grid on;

    subplot(4,1,3);
    stem(k, product, 'filled','g');
    title(['x[k] * h[n-k], sum = ' num2str(y_n)]); ylim([0 12]); grid on;

    subplot(4,1,4);
    stem(0:n, y(1:n+1), 'filled','b');
    title('y[n] (output konvolusi, bertambah tiap step)'); ylim([0 15]); grid on;

    pause(pause_time);  % jeda biar terlihat animasinya
end

% Validasi hasil dengan MATLAB conv()
disp('Hasil konvolusi dengan conv():');
disp(conv(x,h));

