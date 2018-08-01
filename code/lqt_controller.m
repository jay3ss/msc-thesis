% SI units used throughout
% Constants
% HDES places the vehicles evenly on the road
VLENGTH = 5; % m (vehicle length)
R = 70;
RLENGTH = R*2*pi; % m (road length)
VMAX = 5; % m/s (70 mph)
NUM_VEHICLES = 3;
HDES = (RLENGTH - NUM_VEHICLES*VLENGTH)/NUM_VEHICLES;

% System parameters
A = [
 0, 1, 0,  0, 0, -1;
 0, 0, 0,  0, 0,  0;
 0, 0, 0, -1, 0,  1;
 0, 0, 0,  0, 0,  0;
-1, 0, 1,  0, 0,  0;
 0, 0, 0,  0, 0,  0
];

B = [
0, 0, 0;
1, 0, 0;
0, 0, 0;
0, 1, 0;
0, 0, 0;
0, 0, 1
];

% Problem parameters
Q = 2.5e-5*eye(size(A));
Q(2, 2) = 1e-2; Q(4, 4) = 1e-2; Q(4, 4) = 1e-2;
H = Q;
R = 10*eye(3);
r = [HDES; VMAX; HDES; VMAX; HDES; VMAX];

% Initial positions
pos3 = RLENGTH;
pos2 = pos3 + 125 - RLENGTH;
pos1 = pos2 + 125;

h1_init = pos3 - pos1;
v1_init = 0;
h2_init = abs(pos2 - pos1);
v2_init = 0;
h3_init = abs(pos3 - pos2);
v3_init = 0;

X0 = [h1_init; v1_init; h2_init;
      v2_init; h3_init; v3_init];

% Boundary conditions
Kfinal = H;
Sfinal = -H*r;
tinitial = 0;
tfinal = 500;

% ODE options
rel_tol = 1e-6;
abs_tol = 1e-6*ones(1, 6);
abs_tol_k = 1e-6*ones(1, 36);
non_neg_idx = 1:6;
options1 = odeset('RelTol', rel_tol,...
                  'AbsTol', abs_tol, 'Refine',10);
optionsk = odeset('RelTol', rel_tol,...
                  'AbsTol', abs_tol_k, 'Refine',10);
% Apply constraint of non-negative numbers only
options2 = odeset(options1,'NonNegative',non_neg_idx);

% Symbols for solving system of differential equations
K = sym('K%d%d', [6, 6]);
S = sym('S%d', [6, 1]);

[tk, K] = ode45(@(t, K)kdot(t, K, A, B, Q, R),...
                [tfinal, tinitial], Kfinal, optionsk);
[ts, S] = ode45(@(t, S)sdot(t, S, A, B, K, Q, R, r, tk),...
                [tfinal, tinitial], Sfinal, options1);

[tx, X] = ode45(...
               @(t, X)xdot(t, X, K, S, R, A, B, tk, ts),...
               [tinitial, tfinal], X0, options2);
dt = 1e-1;
sim_time = tfinal*(dt^-1) + 1;
for j = 1:1:sim_time
    t_new=(j-1)*dt;
    K_new = interp1(tk, K, t_new);
    K_new = reshape(K_new, size(A));
    
    S_new = interp1(ts, S, t_new);
    S_new = S_new';

    X_new = interp1(tx, X, t_new);
    X_new = X_new';

    u(:,j) = -(R^-1)*B'*K_new*X_new - (R^-1)*B'*S_new;
   
    % Make sure that we don't go backwards!
    if u(1,j) <= 0 && X_new(2,1) <= 0
        u(1,j) = 0;
    end
    if u(2,j) <= 0 && X_new(4,1) <= 0
        u(2,j) = 0;
    end
    if u(3,j) <= 0 && X_new(6,1) <= 0
        u(3,j) = 0;
    end
    tu(j)=t_new;
end

% Plot the headways
endtime = 250;
figure('DefaultAxesFontSize',16)
p1 = plot(tx, X(:, 1), tx, X(:, 3), tx, X(:, 5));
p1(1).LineWidth = 2;
p1(1).LineStyle = ':';
p1(2).LineWidth = 2;
p1(2).LineStyle = '--';
p1(3).LineWidth = 2;
p1(3).LineStyle = '-.';
title('Headways')
xlabel('Time (s)')
ylabel('Headways h_{i}(t) (m)')
legend('h_{1}^*(t)','h_{2}^*(t)','h_{3}^*(t)')
xlim([0, endtime])
grid on

% Plot the velocities
figure('DefaultAxesFontSize',16)
p2 = plot(tx, X(:, 2), tx, X(:, 4), tx, X(:, 6));
p2(1).LineWidth = 2;
p2(1).LineStyle = ':';
p2(2).LineWidth = 2;
p2(2).LineStyle = '--';
p2(3).LineWidth = 2;
p2(3).LineStyle = '-.';
title('Velocities')
xlabel('Time (s)')
ylabel('Velocities v_{i}(t) (m/s)')
legend('v_{1}^*(t)','v_{2}^*(t)','v_{3}^*(t)',...
       'Location', 'SouthEast')
xlim([0, endtime])
ylim([0, VMAX+1])
grid on

% Plot the control trajectories
figure('DefaultAxesFontSize',16)
p3 = plot(tu, u(1,:), tu, u(2,:), tu, u(3,:));
p3(1).LineWidth = 2;
p3(1).LineStyle = ':';
p3(2).LineWidth = 2;
p3(2).LineStyle = '--';
p3(3).LineWidth = 2;
p3(3).LineStyle = '-.';
title('Control trajectories')
xlabel('Time (s)')
ylabel('u^*(t) (m/s^2)')
legend('u_{1}^*(t)', 'u_{2}^*(t)', 'u_{3}^*(t)')
xlim([0, endtime])
print -depsc -r300 opt_ctrl_controls.eps
grid on

function dkdt = kdot(t, K, A, B, Q, R)
    K = reshape(K, size(A));
    dkdt = -K*A - A'*K - Q + K*B*(R^-1)*B'*K;
    dkdt = dkdt(:);
end

function dsdt = sdot(t, s, A, B, K, Q, R, r, tk)
    K = interp1(tk, K, t);
    K_new = reshape(K, size(A));
    dsdt = -(A' - K_new*B*(R^-1)*B')*s + Q*r;
    dsdt = dsdt(:);
end

function dxdt = xdot(t, X, K, S, R, A, B, tk, ts)
    K = interp1(tk, K, t);
    K = reshape(K, size(A));
    
    S = interp1(ts, S, t);
    S = S';

    U = -(R^-1)*B'*K*X - (R^-1)*B'*S;
    dxdt = A*X + B*U;
    dxdt = dxdt(:);
end