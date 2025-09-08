% Continuous-Time Convolution Integral (Modified t range)
t = -1:0.005:6;       % Rentang t baru, lebih luas
dt = t(2) - t(1);

x = ones(size(t));                % x(t) = u(t)
h = exp(-t);                      % h(t) = e^{-t} u(t)
h(t<0) = 0;                       % u(t) = 0 untuk t<0

y = zeros(size(t));
for i = 1:length(t)
    tau = t(1):dt:t(i);                    % tau menyesuaikan rentang t
    xtau = interp1(t, x, tau, 'linear', 0);
    htau = interp1(t, h, t(i) - tau, 'linear', 0);
    y(i) = trapz(tau, xtau .* htau);
end

% Plotting
figure;
subplot(3,1,1); plot(t, x, 'r'); title('x(t)'); xlabel('t'); ylabel('Amplitude'); grid on;
subplot(3,1,2); plot(t, h, 'b'); title('h(t)'); xlabel('t'); ylabel('Amplitude'); grid on;
subplot(3,1,3); plot(t, y, 'm'); title('y(t) = x(t) * h(t)'); xlabel('t'); ylabel('Amplitude'); grid on;

