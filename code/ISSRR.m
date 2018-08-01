clear;
to = 0; %initial time
tf =10; %final time (60 day period)
yo = [98 1 1 0 0]; %initial conditions of I,S, S, R ,R respectively
[t y] = ode45('ypISSRR',[to tf],yo);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4),t,y(:,5))
title('ISSRR Model: Strong Group 1 spreading')
%b1=.12, b2=.1, g11=.01, g12=.001, g21=.001, g22=.01, d12=.51, d21=.49
xlabel('time')
ylabel('Population')
legend('I','S_1','S_2','R_1','R_2')