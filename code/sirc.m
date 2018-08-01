clear;
to = 0; %initial time
tf =50; %final time
yo = [99 1 1 0]; %initial conditions of I,S,C,R respectively
[t y] = ode45('ypSIRC',[to tf],yo);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
title('ISCR Model: b = .01, g = .1, a = .02, m = 0.1, w1 = .001, w2 = .001')
xlabel('time')
ylabel('Ignorant, Spreader, Counter-spreader, Recovered')
legend('I','S','C','R')