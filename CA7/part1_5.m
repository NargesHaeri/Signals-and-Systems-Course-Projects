t = 0 : 1/1000 : 5; 
u = heaviside(t);  

y = -3/2 * exp(-t) .* u + 1/2 * exp(-3*t) .* u + u;

plot(t, y);
title('Step Response');
xlabel('time');
grid on;
