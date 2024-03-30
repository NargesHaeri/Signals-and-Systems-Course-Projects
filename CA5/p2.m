%% 2.1 creating a mapset

Alphabet='abcdefghijklmnopqrstuvwxyz .,!;"';

num_alphabet=length(Alphabet);
mapset=cell(2,num_alphabet);
for j=1:num_alphabet
    mapset{1,j}=Alphabet(j);
    mapset{2,j}=dec2bin(j-1,5);
end
char_bin_len = length(mapset{2, 1});

%% 2.2/2.3 coding a massage

fs = 100;
msg = 'signal';
index=[];
for j=1:length(msg)
    ch=msg(j);
    index=[index, find(strcmp(ch,mapset(1,:))==1)];
end
bin_msg=cell2mat(mapset(2,index));

figure

bit_rate=1;
subplot(2, 1, 1);
coded_signal = coding_freq(bin_msg, bit_rate);
t = linspace(0, length(coded_signal) / fs, length(coded_signal));
plot(t, coded_signal);
title([num2str(bit_rate),' Bit/Sec Signal ']);

bit_rate=5;
subplot(2, 1, 2);
coded_signal = coding_freq(bin_msg, bit_rate);
t = linspace(0, length(coded_signal) / fs, length(coded_signal));
plot(t, coded_signal);
title([num2str(bit_rate),' Bit/Sec Signal ']);


%% 2.4 decoding a massage
bit_rate=1;
coded_signal = coding_freq(bin_msg, bit_rate);
binary_decoded_signal = decoding_freq(coded_signal,bit_rate);
decoded_signal = binary_to_string(binary_decoded_signal, mapset);
disp(['the encoded massage (with the bitrate =',num2str(bit_rate),')is :', decoded_signal])

bit_rate=5;
coded_signal = coding_freq(bin_msg, bit_rate);
binary_decoded_signal = decoding_freq(coded_signal,bit_rate);
decoded_signal = binary_to_string(binary_decoded_signal, mapset);
disp(['the encoded massage (with the bitrate =',num2str(bit_rate),')is :', decoded_signal])

%% 2.5-6-7 Adding noise

noise_amp = 0.01:0.01:2;
bit_rates = [1,5];
max_noise_var = zeros(size(bit_rates));

for j = 1:length(bit_rates)
for i = 1: length(noise_amp)


    bit_rate = bit_rates(j);
    coded_signal = coding_freq(bin_msg, bit_rates(j));
    noisy_signal = coded_signal + noise_amp(i) * randn(size(coded_signal));
    binary_decoded_signal = decoding_freq(noisy_signal, bit_rate);
    decoded_signal = binary_to_string(binary_decoded_signal, mapset);
    disp(['the encoded massage (with the bitrate =',num2str(bit_rate),' and noise =',num2str(noise_amp(i)),')is :', decoded_signal])
    if ~strcmp(decoded_signal,'signal')
        max_noise_var(j) = max(max_noise_var(j),noise_amp(i));
        break
    end
end
end
max_noise_var

%%

function str = binary_to_string(bin, mapset)
    lenght=length(bin)/5;
    index=[];
    for i=1:lenght
        index=[index, find(strcmp(bin(5*i-4:5*i),mapset(2,:))==1) ];
    end
    str=cell2mat(mapset(1,index));
end