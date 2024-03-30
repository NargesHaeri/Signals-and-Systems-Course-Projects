load('numberVoicesMapset.mat');

calling_customer(20,2)

function calling_customer(number1, number2)

    load('numberVoicesMapset.mat', 'numberVoices');
    
    the_number = numberVoices(28).voice;
    to_counter = numberVoices(29).voice;
    
    
    if (number1 < 20) || (mod(number1, 10) == 0)
        voice1 = numberVoices(number1).voice;
        voice2 = numberVoices(number2).voice;
        combinedVoice = [the_number;voice1;to_counter; voice2];
    else
        num1=number1 - mod(number1, 10);
        voice1 = numberVoices(num1).voice;
        voice2 = numberVoices(number2).voice;
        o_sound = numberVoices(30).voice;
        number3 = mod(number1, 10);
        voice3 = numberVoices(number3).voice;
        combinedVoice = [the_number;voice1;o_sound;voice3;to_counter; voice2];
    end
    

    sound(combinedVoice, numberVoices(number2).sampleRate);
end
