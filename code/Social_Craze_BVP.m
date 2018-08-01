function Social_Craze_BVP
%SC_BVP    Scenario 1 of optimal control.
% Initial guess for the solution
solinit = bvpinit(linspace(0,20,40), [0 0]);
options = bvpset('Stats','on','RelTol',1e-1);
global R; % control scaling
R = 1;
global M; % (x1 - xd)^2 scaling
M = 10;
global L; % time lambda in the cost function
L = 1;
global B1; % beta_1 = spreading rate due to advertisement
B1 = 0.6;
global B2; % beta_2 = spreading rate due to social media
B2 = 0.5;
global d;
d = 0.1;  % delta = rate of decay due to disinterest
global x_d; 
x_d = d/B2 % desired objective
global tf; % final time
tf = 20;
sol = bvp4c(@BVP_ode, @BVP_bc, solinit, options);
t = sol.x;
y = sol.y;
% Calculate u(t) from x1,p1
ut = -(y(2,:)*B1.*(1-y(1,:)))/2*R;
%Calculate total control
u_total = trapz(ut)
%u_total = trapz(ut)
n = length(t);
% Calculate the cost
J = tf*((M*(y(1,:)-x_d)'*(y(1,:)-x_d)) + R*(ut*ut') + L)/n;
figure(1);
plot(t, y(1,:)','-');hold on;
plot(t,ones(size(t))*x_d,'g--');
plot(t,ut', 'r:')
s = strcat('Total Control is: u=',num2str(u_total));
text(6,.6,s);
xlabel('time');
ylabel('states');
legend('x(t)','x_d','u(t)');
hold off;
%------------------------------------------------
% ODE's for states and costates
function dydt = BVP_ode(t,y)
global R;
global B1;
global B2;
global d;
global M;
global x_d;
x1 = y(1);
p1 = y(2);
u =  -(y(2)*B1.*(1-y(1)))/(2*R);
dydt = [B1*(1-x1).*u + B2*x1*x1' - d*x1
        2*M*(x_d-x1) + p1*(B1*u - 2*B2*x1 + d)];
% -----------------------------------------------
% The boundary conditions:
% x1(0) = 0, tf = 10, p1(tf) = x_d;
function res = BVP_bc(ya,yb)
global x_d;
res = [ ya(1) - 0
        yb(2) - x_d ];