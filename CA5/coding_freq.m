function signal = coding_freq(bin_msg, bit_rate)
    fs = 100;
    N = 100;
    t_start = 0;
    Ts = 1/fs;
    T_end = 1;
    t = t_start:Ts:T_end;
    f=0:fs/N:(fs/2) - fs/N;
    partition = length(f) / (2^bit_rate);
    middle_part = length(f) / ((2^bit_rate) * 2);
    coded_signal = [];

    for i = 1:bit_rate:length(bin_msg)
        frequency = partition * bin2dec(bin_msg(i:i+bit_rate-1)) + middle_part;
        y = sin(2 * pi * frequency * t);
        coded_signal = [coded_signal, y];
    end

    signal = coded_signal;
end
