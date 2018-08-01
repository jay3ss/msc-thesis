clear;
to = 0;
tf =50;
yo = [99 1 0];
[t y] = ode45('ypsir',[to tf],yo);
plot(t,y(:,1),t,y(:,2),t,y(:,3))
title('Put Title Here')
xlabel('time')
ylabel('susceptible, infected, recovered') 