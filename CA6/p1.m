%% 1.1
fc = 5;
fs = 100;
t_start = 0;
t_end = 1;
ts = 1 / fs;
t = t_start:ts:t_end - ts;
N = length(t);
f = (-fs / 2):(fs / N):(fs / 2 - fs / N);
x1 = cos(2 * pi * fc * t);
figure
subplot(2, 1, 1)
plot(t, x1)
title('cos(2\pi 100t)')
xlabel('time')

%% 1.2
beta = 0.3;
V = 50;
C = 3e8;          
R = 250000;          
alpha = 0.5;     
td = (2 * R) / C;
fd = beta * V;
x2 = alpha * cos(2 * pi * (fc+fd) * (t-td));
subplot(2, 1, 2)
plot(t, x2)
title('\alpha cos(2\pi(fc+fd)(t-td))')
xlabel('time')

%% 1.3
x2_fft = fftshift(fft(x2));
y2 = abs(x2_fft) / max(abs(x2_fft));
y_phase = angle(x2_fft);
[~, maxIndex] = max(y2);
fd = abs(maxIndex - floor(fs/2)-1)-fc;
td = y_phase(maxIndex)/(2*pi*(fd+fc));
estimated_V = fd/beta;
estimated_R = (td*C)/2;
disp(['Estimated V is:',num2str(estimated_V*3.6),' and estimated R is:',num2str(estimated_R/1000)]);

%% 1.4
noise_amp = 0 : 0.2:2;
R_resistance = 0;
V_resistance = 0;
for i = 1: length(noise_amp)

    noisy_signal = x2 + noise_amp(i) * randn(size(x2));
    x2_fft = fftshift(fft(noisy_signal));
    y2 = abs(x2_fft) / max(abs(x2_fft));
    y_phase = angle(x2_fft);
    [~, maxIndex] = max(y2);
    fd = abs(maxIndex - floor(fs/2)-1)-fc;
    td = y_phase(maxIndex)/(2*pi*(fd+fc));
    estimated_V = fd/beta;
    estimated_R = (td*C)/2;
    if(R_resistance == 0 && estimated_R ~= R)
        R_resistance = noise_amp(i);
    end

    if(V_resistance == 0 && estimated_V ~= V)
        V_resistance = noise_amp(i);
    end

end

disp(['Resistance of V is until:',num2str(V_resistance),' and Resistance of R is until:',num2str(R_resistance)]);

%% 1.5

V1 = 50;
R1 = 250000;
alpha1 = 0.5;
td1 = (2 * R1) / C;
fd1 = beta * V1;
x_1 = alpha1 * cos(2 * pi * (fc+fd1) * (t-td1));

V2 = 60;       
R2 = 200000;
alpha2 = 0.6;
td2 = (2 * R2) / C;
fd2 = beta * V2;
x_2 = alpha2 * cos(2 * pi * (fc+fd2) * (t-td2));

recived_sig = x_1+x_2;
figure
plot(t, recived_sig)
title('\alpha cos(2\pi(fc+fd)(t-td))')
xlabel('time')

%% 1.6

sig_fft = fftshift(fft(recived_sig));
sig_fft2 = abs(sig_fft) / max(abs(sig_fft));
[peak,x_peaks]= findpeaks(abs(sig_fft2));
[peak,index]=sort(peak,'descend');
x_peaks = x_peaks(index);
sig_phase = angle(sig_fft);

Vs = zeros(1,2);
Rs = zeros(1,2);
fds = zeros(1,2);
tds = zeros(1,2);

for i = 1:2
    fds(i) = abs(x_peaks(2*i)-fs/2-1)-fc;
    tds(i) = abs((sig_phase(x_peaks(2*i)))/(2*pi*(fds(i)+fc)));
    Vs(i) = fds(i)/beta;
    Rs(i) = ((tds(i))/(2/C));
    disp(['Estimated V is:',num2str(Vs(i)*3.6),' and estimated R is:',num2str(Rs(i)/1000)]);
end



