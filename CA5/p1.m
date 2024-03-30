%% 1.0

fs = 20;
t_start = 0;
t_end = 1;
ts = 1 / fs;
t = t_start:ts:t_end - ts;
N = length(t);
f = 0:(fs / N):((N - 1) * fs / N);
x1 = exp(1j * 2 * pi * 5 * t) + exp(1j * 2 * pi * 8 * t);
figure
subplot(2, 1, 1)
plot(f, abs(fft(x1)) / max(abs(fft(x1))))
xlabel('Frequency (Hz)')
title('FFT(x1)')


x2 = exp(1j * 2 * pi * 5 * t) + exp(1j * 2 * pi * 5.1 * t);
subplot(2, 1, 2)
plot(f, abs(fft(x2)) / max(abs(fft(x2))))
xlabel('Frequency (Hz)')
title('FFT(x2)')

%% 1.1

fs = 50;
t_start = 0;
t_end = 1;
ts = 1 / fs;
t = t_start:ts:t_end - ts;
N = length(t);
f = (-fs / 2):(fs / N):(fs / 2 - fs / N);
x1 = cos(2 * pi * 5 * t);
figure
subplot(2, 1, 1)
plot(t, x1)
title('cos(10\pi t)')
xlabel('time')
x1_fft = fftshift(fft(x1));
y1 = abs(x1_fft) / max(abs(x1_fft));
subplot(2, 1, 2)
plot(f,y1 )
xlabel('Frequency (Hz)')
title('FFT(cos(10\pi t))')

%% 1.2

fs = 100;
t_start = 0;
t_end = 1;
ts = 1 / fs;
t = t_start:ts:t_end - ts;
N = length(t);
f = (-fs / 2):(fs / N):(fs / 2 - fs / N);
x2 = cos((30 * pi * t)+ (pi/4));
figure
subplot(3, 1, 1)
plot(t, x2)
title('cos((30 \pi t)+ (\pi/4))')
xlabel('time')
x2_fft = fftshift(fft(x2));
y2 = abs(x2_fft) / max(abs(x2_fft));
subplot(3, 1, 2)
plot(f,y2)
xlabel('Frequency (Hz)')
title('FFT(cos((30 \pi t)+ (\pi/4)))')

% part 3
smallValue = 1e-6;
x2_fft(abs(x2_fft) < smallValue) = 0;
theta4 = angle(x2_fft);
subplot(3, 1, 3)
plot(f, theta4 / pi)
xlabel('Frequency (Hz)')
ylabel('\theta_4/\pi')
title('Phase of FFT(cos((30 \pi t)+ (\pi/4)))')