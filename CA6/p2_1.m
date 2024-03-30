key_names = {'c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b'};
freq = [523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880.00, 932.33, 987.77];

keys = cell(2, length(key_names));

for i = 1:length(key_names)
    keys{1, i} = key_names{i};
    keys{2, i} = freq(i);
end

fs = 8000;
T = 0.5;
tau = 0.025;

sound = {{'d', T/2}, {'d', T/2}, {'g', T}, {'f#', T}, {'d', T},...
        {'d', T/2}, {'e', T/2}, {'e', T/2}, {'d', T/2}, {'f#', T/2}, {'d', T/2}, {'e', T/2}, {'d', T/2}, {'e', T/2}, {'f#', T/2}, {'e', T/2},...
        {'d', T}, {'e', T}, {'f#', T}, {'e', T}, ...
        {'d', T/2}, {'e', T/2}, {'e', T/2}, {'d', T/2}, {'f#', T/2}, {'d', T/2}, {'e', T},...
        {'d', T}, {'e', T/2}, {'d', T/2}, {'f#', T}, {'e', T}, ...
        {'d', T}, {'e', T/2}, {'d', T/2}, {'f#', T}, {'e', T}, ...
        {'d', T/2}, {'d', T/2}, {'e', T}, {'f#', T/2}, {'e', T/2}, {'f#', T}, ...
        {'f#', T/2}, {'e', T/2}, {'f#', T}, {'f#', T}, {'d', T}
};

sound_vector = [];

for i = 1:length(sound)
    note_name = sound{i}{1};
    note_duration = sound{i}{2};
    note_index = find(strcmp(note_name, keys(1, :)));
    note_freq = keys{2, note_index};  
    t_note = 0:1/fs:note_duration -1/fs;
    note_sound = sin(2 * pi * note_freq * t_note);
    sound_vector = [sound_vector, note_sound];
    if i < length(sound)
        silence_samples = round(tau * fs);
        sound_vector = [sound_vector, zeros(1, silence_samples)];
    end
end

sound(sound_vector, fs);
