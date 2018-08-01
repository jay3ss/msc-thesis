clear;
to = 0; %initial time
tf =30; %final time
yo = [99 1 1 0 99 1 1 0]; %initial conditions of I1,S1,C1,R1,I2,S2,C2,R2 respectively
[t y] = ode45('hybrid_ypsirc',[to tf],yo);
subplot(2,1,1);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
title('SIRC1: b = .02, g = .1, a = .01, m = 0.1, w1 = .001, w2 = .001, a21 = 1')
xlabel('time')
ylabel('SIRC1 Population')
legend('I1','S1','C1','R1')
subplot(2,1,2)
plot(t,y(:,5),t,y(:,6),t,y(:,7),t,y(:,8))
title('SIRC2: b = .01, g = .1, a = .02, m = 0.1, w1 = .001, w2 = .001, a12 = .1')
xlabel('time')
ylabel('SIRC2 Population')
legend('I2','S2','C2','R2')