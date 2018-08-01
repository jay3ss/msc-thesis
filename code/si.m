clear;
to = 0; % initial time
tf =25; % final time
yo = [99 1]; % initial ignorants and spreaders
[t y] = ode45('ypsi',[to tf],yo); % call to ode45 and plotting the results
plot(t,y(:,1),t,y(:,2))
title('Sample Ignorant-Spreader Model Behavior')
xlabel('time')
ylabel('Ignorant, Spreader')
legend('I','S')