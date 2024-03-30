function signal=coding_amp(binary_msg,bit_rate)

fs=100;
step=1/fs;
end_time=1;

coded_signal=[];
for i=1:bit_rate:length(binary_msg)
    Coefficient=bin2dec(binary_msg(i:i+bit_rate-1))/(2^bit_rate-1);
    t=0:step:end_time;
    y=Coefficient.*sin(2*pi*t);
    coded_signal=[coded_signal y];
end

signal=coded_signal;
end