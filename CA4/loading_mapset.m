
numberVoices = containers.Map('KeyType', 'double', 'ValueType', 'any');

numbers = [1:19, 20, 30, 40, 50, 60, 70, 80, 90];

for number = numbers

    filename =[num2str(number) '.m4a'];
    
    [voice, sampleRate] = audioread(filename);
   
    numberVoices(number) = struct('voice', voice, 'sampleRate', sampleRate);
end


[voice, sampleRate] = audioread('the_number.m4a');
numberVoices(28) = struct('voice', voice, 'sampleRate', sampleRate);

[voice, sampleRate] = audioread('to_counter.m4a');
numberVoices(29) = struct('voice', voice, 'sampleRate', sampleRate);

[voice, sampleRate] = audioread('o.m4a');
numberVoices(30) = struct('voice', voice, 'sampleRate', sampleRate);


save('numberVoicesMapset.mat', 'numberVoices');