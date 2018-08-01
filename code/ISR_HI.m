%Graphs the time evolution of the dynamics
clear;
to = 0;
tf =50;
yo = [.70 .30 0];
[t y] = ode45('ypISR_HI',[to tf],yo);
plot(t,y(:,1),t,y(:,2),t,y(:,3))
title('Time Evolution of ISR Model for Social Media:')
xlabel('time')
ylabel('Population')
legend('I','S','R')