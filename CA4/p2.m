
clc;
clear;
close all;

ts = 1e-9;        
T = 1e-5;         
tau = 1e-6;       

C = 3e8;          
R = 450;          
alpha = 0.5;     
td = (2 * R) / C; 

t = 0:ts:T;

N = round(tau / ts);
sentSignal = zeros(size(t));
sentSignal(1 : N) = 1;
td_index = round(td / ts);
receivedSignal = zeros(size(t));
receivedSignal(td_index : td_index + N) = alpha;


figure;

subplot(3, 1, 1);
plot(t, sentSignal, 'b', 'LineWidth', 1);
title('Transmitted Signal');
xlabel('Time (s)');

subplot(3, 1, 2);
plot(t, receivedSignal, 'r', 'LineWidth', 1);
title('Received Signal');
xlabel('Time (s)');

%% 2.2
co = conv(sentSignal, receivedSignal);
t_conv = linspace(0, T + (length(co) - 1) * ts, length(co));  
subplot(3, 1, 3);
plot(t_conv, co, 'c', 'LineWidth', 1);
title('Convolution of Signals');
xlabel('Time (s)');
[MAXCO, td1] = max(co);
td1 = td1*ts - tau;
R1 = td1 * C / 2; 
fprintf('Calculated Distance: %.2f meters\n', R1);

%% 2.3
noisePower = 0.1;  
noisyReceivedSignal = receivedSignal + noisePower * randn(size(receivedSignal));
figure;

subplot(3, 1, 1);
plot(t, sentSignal, 'b', 'LineWidth', 1);
title('Transmitted Signal');
xlabel('Time (s)');

subplot(3, 1, 2);
plot(t, noisyReceivedSignal, 'r', 'LineWidth', 1);
title('Noisy Received Signal');
xlabel('Time (s)');

co = conv(sentSignal, noisyReceivedSignal);
t_conv = linspace(0, T + (length(co) - 1) * ts, length(co));  
subplot(3, 1, 3);
plot(t_conv, co, 'c', 'LineWidth', 1);
title('Convolution of Signals');
xlabel('Time (s)');

[MAXCO, td1] = max(co);
td1 = td1*ts - tau;
R1 = td1 * C / 2; 
fprintf('Calculated Distance for noisy signal: %.2f meters\n', R1);

if abs(R1 - R) < 10
    disp('Distance estimation is accurate within 10 meters.');
else
    disp('Distance estimation error is greater than 10 meters.');
end

%%