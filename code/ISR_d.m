%Graphs the time evolution of the dynamics
clear;
to = 0;
tf =10;
yo = [99 1 0];
[t y] = ode45('ypISR_d',[to tf],yo);
plot(t,y(:,1),t,y(:,2),t,y(:,3))
title('Time Evolution of ISR Model for Social Media with Decay:')
xlabel('time')
ylabel('Population')
legend('I','S','R')