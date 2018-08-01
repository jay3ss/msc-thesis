function Herd_Immunity_bvp
%HI_BVP    Scenario 2 of optimal control.
% Initial guess for the solution
solinit = bvpinit(linspace(0,2000,50), [0 0 0 0]);
options = bvpset('Stats','on','RelTol',1e-1);
global R; % control scaling
R = 1;
global Q; % (x1 + x2)^2 scaling
Q = 2.5;
global L; % time lamba in the cost function
L = 1;
global B; % beta = spreading rate
B = 0.004; %.3, .01
global G; % gamma = stifling rate
G = 0.001; %.1, .001
global tf; % final time
tf = 50;
sol = bvp4c(@BVP_ode, @BVP_bc, solinit, options);
t = sol.x;
y = sol.y;
%global p_d;
objective = G/B % (x1 + x2) desired objective
% Calculate u(t) from x1,x2,p1,p2
ut = (y(3,:)*B.*y(1,:))/(2*R);
% Calculate total control
u_total = trapz(ut)
%u_total = trapz(ut)
n = length(t);
% Calculate the cost
J = tf*(ut*ut'*R +Q*(y(1,:)+y(2,:))*(y(1,:)+y(2,:))' + L)/n;
figure(1);
plot(t, y(1:2,:)','-');hold on;
xlabel('time');
ylabel('states');
legend('x_1(t)','x_2(t)');
hold off;
figure(2);
plot(t, (y(1,:)+y(2,:))','cx-');hold on;
plot(t,ones(size(t))*objective,'g--');
plot(t,ut', 'r:')
s = strcat('Total Control is: u=',num2str(u_total));
text(600,1.4,s);
xlabel('time');
ylabel('states');
legend('x_1(t)+x_2(t)','objective','u(t)');
hold off;
%------------------------------------------------
% ODE's for states and costates
function dydt = BVP_ode(t,y)
global R;
global Q;
global B;
global G;
x1 = y(1);
x2 = y(2);
p1 = y(3);
p2 = y(4);
u =  y(3)*B.*y(1)/(2*R);
dydt = [-B*x1.*x2-B.*u.*x1
        B*x1.*x2-G*x2
        -2*Q*(x1+x2) + p1*B.*(x2+u) - p2*B.*x2
        -2*Q*(x1+x2) + (p1-p2).*B.*x1 + p1*G];
% -----------------------------------------------
% The boundary conditions:
% x1(0) = 0.7, x2(0) = 0.1, tf = 100, p1(tf) = 0, p2(tf) = 0;
function res = BVP_bc(ya,yb)
res = [ ya(1) - 0.90 %0.70
        ya(2) - 0.10 %0.30
        yb(3) - 0
        yb(4) - 0 ];