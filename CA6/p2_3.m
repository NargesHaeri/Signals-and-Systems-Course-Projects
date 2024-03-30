[music, fs] = audioread('mysong.wav');
fs = 8000;
Ts = 1/fs;
T = 0.50;
tau = 0.025;
key_names = {'c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b'};
freq = [523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880.00, 932.33, 987.77];
keys = cell(2, length(key_names));
for i = 1:length(key_names)
    keys{1, i} = key_names{i};
    keys{2, i} = freq(i);
end

silence = zeros(1, round(tau * fs));
chunks = [];
chunk = cell(1, 0);

music = music';
for i = 1 : length(silence) : length(music) - length(silence)
    seg = music(i : i + length(silence) - 1);
    if sum(seg) == 0 
        if length(chunks) > 0
            chunk{end + 1} = chunks;
            chunks = [];
        end
    end
    chunks = [chunks, seg];
end

chunk{end + 1} = chunks;

for i = 1 : length(chunk)
    fft_chunk = fftshift(fft(chunk{i}));
    [~, mx_chunk] = max(abs(fft_chunk));
    frequency = abs(mx_chunk * fs/(length(chunk{i})) - floor(fs / 2) - 1);
    keys_indx = 1;
    min = abs(keys{2, 1} - frequency);
    for i = 2:length(keys)
        diffrencr = abs(keys{2, i} - frequency);
        if diffrencr < min
            min = diffrencr;
            keys_indx = i;
        end
    end
    key_name = keys{1, keys_indx};
    disp(["Detected Key:", num2str(key_name)]);
end

