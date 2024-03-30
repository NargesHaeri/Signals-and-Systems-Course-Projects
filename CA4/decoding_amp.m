function binary_msg=decoding_freq(signal,bit_rate)
Fs=100;
step=1/Fs;
end_time=1;
bin='';
chunk = round(end_time * Fs);
threshold = 2*(2^bit_rate-1); 

Coefficient=[];
for i=0:1:(2^bit_rate-1)
    curr_coff=i/(2^bit_rate-1);
    Coefficient = [Coefficient curr_coff];
end

for i = 1:chunk:(length(signal) - chunk)
    sig_part = signal(i:i+chunk-1);
    t=0:step:end_time;
    Correlation = max(0.01*xcorr(sig_part, 2*sin(2*pi*t)));
    [th, index] = min(abs(Coefficient - Correlation));

     if threshold > th
        bin=strcat(bin,dec2bin(index-1,bit_rate));
     end
end

binary_msg = bin;

end
