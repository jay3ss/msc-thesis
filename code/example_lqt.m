% SI units used throughout
clc
close all
clear all

% System parameters
T = 1.5;
A = -1/T;
B = 1/T;

% Problem parameters
Q = 25;
H = Q;
R = 5e-3;
r = 1;

% Initial values
X0 = 0;

% Boundary conditions
Kfinal = H;
Sfinal = -H*r;
tinitial = 0;
tfinal = 15;

% ODE options
rel_tol = 1e-6;
abs_tol = rel_tol;
options = odeset('RelTol', rel_tol,'AbsTol', abs_tol);

dt = 1e-2;
step_sz = 0.1;

tu = 0:dt:tfinal;
u = ones(1, length(tu));
eps = 1e-1;
max_iterations = 1000;

% Symbols for solving system of differential equations
syms K S

[tk, K] = ode45(@(t, K)kdot(t, K, A, B, Q, R),...
                [tfinal, tinitial], Kfinal, options);
[ts, S] = ode45(@(t, S)sdot(t, S, A, B, K, Q, R, r, tk),...
                [tfinal, tinitial], Sfinal, options);

            
K_new = interp1(tk, K', tu);
S_new = interp1(ts, S', tu);
tic
for i = 1:max_iterations
    [tx, X] = ode45(...
                   @(t, X)xdot(t, X, tu, u, K, S, A, B, tk, ts),...
                   [tinitial, tfinal], X0, options);

    X_new = interp1(tx, X', tu);
    p = K_new.*X_new + S_new;
    dH = dhdu(u, p, B, R);
    H_norm(i,1) = dH*dH';
    
    % Find the cost
    J(i,1) = 0.5*((X_new-r)*Q*(X_new-r)'/length(tx) + (u*R*u')/length(tu));
    
    if H_norm(i,1) < eps
        J(i,1)
        break
    else
        u_old = u;
        u = adjust_control(u, dH, step_sz);
    end
end
toc
tr = 0:0.1:tfinal;
rr = ones(1,length(tr));

% Plot the state and control trajectories
createlqtexamplefigure(tx, X, tr, rr, tu, u);

% Plot the cost per iteration
createcostfigure(J);


function dkdt = kdot(t, K, A, B, Q, R)
    dkdt = -K*A - A'*K - Q + K*B*(R^-1)*B'*K;
end

function dsdt = sdot(t, s, A, B, K, Q, R, r, tk)
    K = interp1(tk, K, t);
    dsdt = -(A' - K*B*(R^-1)*B')*s + Q*r;
end

function dxdt = xdot(t, X, tu, U, K, S, A, B, tk, ts)
    U = interp1(tu, U, t);
    K = interp1(tk, K, t);
    S = interp1(ts, S, t);
%     U = -(R^-1)*B'*K*X - (R^-1)*B'*S;
    dxdt = A*X + B*U;
    dxdt = dxdt(:);
end

function dh = dhdu(u, P, B, R)
    dh = R*u + B*P;
end

function u_new = adjust_control(u, dH, step_sz)
    u_new = u - dH*step_sz;
end