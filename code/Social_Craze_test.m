function Social_Craze_test
%Social Crazy Optimal Control Problem
%Steepest descent method is used to find the solution.
clc
close all
clear all
eps = 1e-3;
options = odeset('RelTol', 1e-4, 'AbsTol',[1e-4 1e-4]);
t0 = 0; tf = 6;                    % want the craze to take hold in 6 days
%tf = 0.78;
R = 1;
B1 = 0.25;
B2 = 0.05;
d = 0.1;
l = 1;
x_d = d/B2;
M = 1; %weight
step = 0.05;
t_segment = 50;
Tu = linspace(t0, tf, t_segment);    % discretize time
u = ones(1,t_segment);               % guessed initial control  u=1
initx = [0 0];                       % initial values for states
initp = [0 0];                       % initial values for costates
max_iteration = 100;                 % Maximum number of iterations

for i = 1:max_iteration
   % 1) start with assumed control u and move forward
   [Tx,X] = ode45(@(t,x) stateEq(t,x,u,Tu), [t0 tf], initx, options);
   
   % 2) Move backward to get the trajectory of costates
   x1 = X(:,1); x2 = X(:,2);
   [Tp,P] = ode45(@(t,p) costateEq(t,p,u,Tu,x1,x2,Tx), [tf t0], initp, options);
   p1 = P(:,1);
   % Important: costate is stored in reverse order. The dimension of
   % costates may also different from dimension of states
   % Use interploate to make sure x and p is aligned along the time axis
   p1 = interp1(Tp,p1,Tx);
   
   % Calculate deltaH with x1(t), x2(t), p1(t), p2(t)
   dH = pH(x1,p1,Tx,u,Tu);
   H_Norm = dH'*dH;
   
   % Calculate the cost function
   %J(i,1) = tf*(((x1')*x1 + x_d^2)/length(Tx) + (u*u')/length(Tu) + l); 
   J(i,1) = tf*(((M*(x1-x_d)'*(x1-x_d)))/length(Tx) + R*(u*u')/length(Tu) + l); 
   % if dH/du < epslon, exit
   if H_Norm < eps
       % Display final cost
       J(i,1)
       break;
   else
       % adjust control for next iteration
       u_old = u;
       u = AdjControl(dH,Tx,u_old,Tu,step);
   end; 
end

% plot the state variables & cost for each iteration
figure(1);
plot(Tx, x1 ,'-');
hold on;
plot(Tu,u,'r:');
%text(1,0.75,'x(t)');
%text(.25,-.1,'x_2(t)');
%text(.5,4, 'u(t)');
s = strcat('Final cost is: J=',num2str(J(end,1)));
text(3.5,1,s);
xlabel('time');
ylabel('states');
legend('x(t)','u(t)');
hold off;
%print -djpeg90 -r300 eg2_descent.jpg

figure(2);
plot(J,'x-');
xlabel('Iteration number');
ylabel('J');
%print -djpeg90 -r300 eg2_iteration.jpg

if i == max_iteration
    disp('Stopped before required residual is obtained.');
end

% State equations
function dx = stateEq(t,x,u,Tu)
dx = zeros(2,1);
u = interp1(Tu,u,t); % Interploate the control at time t
B1 = 0.25;
B2 = 0.05;
d = 0.1;
dx(1) = B1*u - B1*x(1)*u + B2*x(1).^2 - d*x(1);
%dx(1) = -2*(x(1) + 0.25) + (x(2) + 0.5)*exp(25*x(1)/(x(1)+2)) - (x(1) + 0.25).*u;

% Costate equations
function dp = costateEq(t,p,u,Tu,x1,x2,xt)
dp = zeros(2,1);
x1 = interp1(xt,x1,t);   % Interploate the state variables
%x2 = interp1(xt,x2,t);
u = interp1(Tu,u,t);     % Interploate the control
B1 = 0.25;
B2 = 0.05;
d = 0.1;
M=1;
l = 1;
x_d = d/B2;
dp(1) = p(1).*B1*u - p(1).*2*B2*x1 + p(1).*d + 2*M*x_d - 2*M*x1;

% Partial derivative of H with respect to u
function dH = pH(x1,p1,tx,u,Tu)
% interploate the control
u = interp1(Tu,u,tx);
R = 1;
B1 = 0.25;
dH = 2*R*u + p1.*(B1 - B1*x1);

% Adjust the control
function u_new = AdjControl(pH,tx,u,tu,step)
% interploate dH/du
pH = interp1(tx,pH,tu);
u_new = u - step*pH;
