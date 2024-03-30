function binary_msg=decoding_freq(signal,bit_rate)
    fs=100;
    N=100;
    Tend=1;
    chunk = round(Tend * fs);
    binary_msg='';
    Thresholds=[];
    f=0:fs/N:(fs/2) - fs/N;
    partition=length(f)/(2^bit_rate);

    for i=0:1:(2^bit_rate-1)
        Thresholds=[Thresholds partition*i];
        
    end
    
    Thresholds=[Thresholds N/2];
    
    for i = 1:chunk:(length(signal) - chunk)
        sig_part = signal(i:i+chunk-1);    
        y=fftshift(fft(sig_part));
        F=y/max(abs(y));
        f=-(fs/2):(fs/N):(fs/2)-(fs/N);
        row = find(abs(F) == max(abs(F)));
        m=f(row);    
        found_freq= m(m>0);
        decoded_bits = 0;
        for i=(2^bit_rate+1):-1:1
            if Thresholds(i) <= found_freq    
                decoded_bits = i -1;
                break;
            
            elseif (i == 1)
                decoded_bits = 0;
            end
        end
        binary_msg=strcat(binary_msg,dec2bin(decoded_bits,bit_rate));
    end
end
