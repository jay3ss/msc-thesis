%Graphs the time evolution of the dynamics
clear;
to = 0; % initial time
tf =10; % final time
yo = [99 1 0]; % initial ignorants and spreaders
[t y] = ode45('ypISR',[to tf],yo);
plot(t,y(:,1),t,y(:,2),t,y(:,3))
title('Time Evolution of ISR Model for Social Media:')
xlabel('time')
ylabel('Population')
legend('I','S','R')