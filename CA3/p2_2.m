[y, Fs] = audioread('a.wav');

fr = [697, 770, 852, 941];
fc = [1209, 1336, 1477, 1633];
keys = ['1', '2', '3', 'A'; '4', '5', '6', 'B'; '7', '8', '9', 'C'; '*', '0', '#', 'D'];

tone_duration = 0.1;  
threshold = 0.1;     
detected_keys = '';
tone_samples = round(tone_duration * Fs);

Ts = 1/Fs;
Ton = 0.1;
Toff = 0.1;
t = 0:Ts:Ton;

for i = 1: 2*tone_samples:(length(y)-tone_samples+1)

    chunk = y(i:i+tone_samples-1);

    
    row_correlations = zeros(1, length(fr));
    col_correlations = zeros(1, length(fc));

    for j = 1:length(fr)
        row_tone = sin(2 * pi * fr(j) * t);
        row_correlations(j) = max(xcorr(chunk, row_tone));
    end

    for j = 1:length(fc)
        col_tone = sin(2 * pi * fc(j) *t);
        col_correlations(j) = max(xcorr(chunk, col_tone));
    end

    [~, row_idx] = max(row_correlations);
    [~, col_idx] = max(col_correlations);

    if row_correlations(row_idx) > threshold && col_correlations(col_idx) > threshold
        detected_keys = [detected_keys, keys(row_idx, col_idx)];

    end
end

fprintf('Detected DTMF keys: %s', detected_keys);
