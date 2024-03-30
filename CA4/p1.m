%% 1.1 loading mapset

Alphabet='abcdefghijklmnopqrstuvwxyz .,!;"';

num_alphabet=length(Alphabet);
mapset=cell(2,num_alphabet);
for i=1:num_alphabet
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end
char_bin_len = length(mapset{2, 1});


fs = 100;

%% 1.2 coding a msg

msg = 'signal';
index=[];
for i=1:length(msg)
    ch=msg(i);
    index=[index, find(strcmp(ch,mapset(1,:))==1)];
end
bin_msg=cell2mat(mapset(2,index));

figure

bit_rates = [1, 2, 3];
for j = 1:length(bit_rates)
    bit_rate = bit_rates(j);
    subplot(length(bit_rates), 1, j);
    coded_signal = coding_amp(bin_msg, bit_rate);
    t = linspace(0, length(coded_signal) / fs, length(coded_signal));
    plot(t, coded_signal);
    title([num2str(bit_rate),' Bit/Sec Signal ']);
end


%% 1.3 decoding a msg

for i = 1:length(bit_rates)
    bit_rate = bit_rates(i);
    coded_signal = coding_amp(bin_msg, bit_rate);
    binary_decoded_signal = decoding_amp(coded_signal,bit_rate);
    decoded_signal = binary_to_string(binary_decoded_signal, mapset);
    disp(['the encoded massage (with the bitrate =',num2str(bit_rate),')is :', decoded_signal])
end

%% 1.4 Adding noise

figure
noise = 0.7;

for i = 1:length(bit_rates)
    bit_rate = bit_rates(i);
    coded_signal = coding_amp(bin_msg, bit_rate);
    noisy_signal = coded_signal + noise * randn(size(coded_signal));
    binary_decoded_signal = decoding_amp(noisy_signal, bit_rate);
    decoded_signal = binary_to_string(binary_decoded_signal, mapset);
    disp(['the encoded massage (with the bitrate =',num2str(bit_rate),' and noise =',num2str(noise),')is :', decoded_signal])
    subplot(length(bit_rates), 1, i);
    t = linspace(0, length(coded_signal) / fs, length(coded_signal));
    plot(t, noisy_signal);
    title([num2str(bit_rate),' Bit/Sec Signal with ',num2str(noise),' noise']);
    
end

%% 1.5
noisySignal = randn(1,3000);
mu=abs(mean(noisySignal));
disp(['mean: ', num2str(mu)]);
disp(['variance: ', num2str((std(noisySignal))^2)]);

figure;
histogram(noisySignal, 'Normalization', 'pdf', 'EdgeColor', 'black', 'FaceColor', 'yellow');
hold on;

x = linspace(min(noisySignal), max(noisySignal), 100);
y = normpdf(x, 0, 1);
plot(x, y, 'LineWidth', 2, 'Color', 'red');

title('Histogram of Gaussian Noise');
xlabel('Value');
ylabel('Probability Density');
legend('Generated Data', 'Standard Normal Distribution');

%%
function str = binary_to_string(bin, mapset)
    lenght=length(bin)/5;
    index=[];
    for i=1:lenght
        index=[index, find(strcmp(bin(5*i-4:5*i),mapset(2,:))==1) ];
    end
    str=cell2mat(mapset(1,index));
end

