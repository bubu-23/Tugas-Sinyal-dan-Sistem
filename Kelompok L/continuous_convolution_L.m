% --- Continuous-Time Convolution Integral ---
t = 0:0.01:5;
dt = t(2) - t(1);

% Sinyal input
x = ones(size(t));           % x(t) = u(t)
h = exp(-t);                 % h(t) = e^{-t}u(t)

% Hitung konvolusi numerik
y = zeros(size(t));
for i = 1:length(t)
    tau = 0:dt:t(i);
    xtau = interp1(t, x, tau, 'linear', 0);
    htau = interp1(t, h, t(i) - tau, 'linear', 0);
    y(i) = trapz(tau, xtau .* htau);
end

% --- Modifikasi Output ---
y_norm = y / max(y);            % Normalisasi 0–1
y_gain = 2 * y;                 % Perbesar amplitudo 2x
y_mod  = y .* cos(2*pi*0.5*t);  % Modulasi dengan cosinus

% --- Plotting ---
figure;

subplot(4,1,1);
plot(t, y, 'r','LineWidth',1.5);
title('Output Asli y(t) = x(t) * h(t)'); xlabel('t'); ylabel('Amplitude'); grid on;

subplot(4,1,2);
plot(t, y_norm, 'g','LineWidth',1.5);
title('Output Normalisasi'); xlabel('t'); ylabel('Amplitude'); grid on;

subplot(4,1,3);
plot(t, y_gain, 'b','LineWidth',1.5);
title('Output dengan Gain 2x'); xlabel('t'); ylabel('Amplitude'); grid on;

subplot(4,1,4);
plot(t, y_mod, 'm','LineWidth',1.5);
title('Output Termodulasi (dengan cosinus)'); xlabel('t'); ylabel('Amplitude'); grid on;

