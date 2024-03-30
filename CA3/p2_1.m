fr = [697, 770, 852, 941];
fc = [1209, 1336, 1477];
fs = 8000;
sequence = '810198';
signal = [];
Ts = 1/fs;
Ton = 0.1;
Toff = 0.1;
t = 0:Ts:Ton;

for i = 1:length(sequence)
    digit = sequence(i);
    switch digit
        case '1'
            k = 1;
            j = 1;
        case '2'
            k = 1;
            j = 2;
        case '3'
            k = 1;
            j = 3;
        case '4'
            k = 2;
            j = 1;
        case '5'
            k = 2;
            j = 2;
        case '6'
            k = 2;
            j = 3;
        case '7'
            k = 3;
            j = 1;
        case '8'
            k = 3;
            j = 2;
        case '9'
            k = 3;
            j = 3;
        case '0'
            k = 4;
            j = 2;
        otherwise
            error('Invalid DTMF digit');
    end
    y1 = sin(2 * pi * fr(k) * t);
    y2 = sin(2 * pi * fc(j) * t);
    y = (y1 + y2) / 2;
    signal = [signal, y];
    if i < length(sequence)
        t_silence = round(Toff * fs) + 1;

        signal = [signal, zeros(1, t_silence)];
    end
end
filename = 'y.wav';
audiowrite(filename, signal, fs);
