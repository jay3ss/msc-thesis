close all; clear all
% Proportional control problem. Only performing proportional control on the
% positions of the vehicle
% SI units used throughout
% Initialize three car system
three_car_init

% Proportional gain
Kp = 10e-4;

% Time parameters
tinitial = 0;
tfinal = 500;
dt = 0.01;
t = tinitial:dt:tfinal;
sim_time = tfinal/dt+1;

% Preallocate vectors
X = zeros(NUM_VEHICLES, sim_time); % position
H = zeros(NUM_VEHICLES, sim_time); % headway
V = zeros(NUM_VEHICLES, sim_time); % velocity
U = zeros(NUM_VEHICLES, sim_time); % control/acceleration

% Initialize vectors
X(:,1) = [0; 10; 55];
H(1,1) = X(2,1) - X(1,1) - VLENGTH;
H(2,1) = X(3,1) - X(2,1) - VLENGTH;
H(3,1) = 2*pi*R - X(3,1) - VLENGTH;
% H(:,1) = [h1_init; h2_init; h3_init];
V(:,1) = [v1_init; v2_init; v3_init];

% Acceleration limits
ubounds(1) = 2.5;   % upper limit
ubounds(2) = -1.5;  % lower limit

% Safety distance. Controls/accelerations won't be applied
% within this distance
HSAFE = 10;

% Time loop
for i = 1:sim_time
    % Loop for each vehicle
    for j = 1:NUM_VEHICLES % from three_car_init
        % Get current vehicle's position and speed
        x = X(j,i);
        v = V(j,i);

        % Determine if lead car and find headway
        if j == NUM_VEHICLES
            xl = X(1,i);
        else
            xl = X(j+1,i);
        end

        h(j,1) = xl - x - VLENGTH;

        if h(j,1) < 0
            h(j,1) = h(j,1) + RLENGTH;
        end

        % Find the error in the headway
        err = h(j,1) - HDES - HSAFE;
        accel = Kp*err;
        % accel = validate_accel(h(j), x, xl, v, accel, HSAFE, ubounds);
        % validate_accel(h, vel, accel, dt, hsafe, vbounds, ubounds)
        accel = validate_accel(h(j,1), v, accel, dt, HSAFE, VMAX, ubounds);
        u(j,1) = accel;

        % if h(j,1) <= hsafe
        %     disp('Not safe')
        %     u(j,1) = 0
        % end
        % if u(j,1) < 0 & v <= 0
        %     disp('Dont go backwards')
        %     u(j,1) = 0
        % if u(j,1) > ubounds(1)
        %     disp('Too big of an acceleration')
        %     u(j,1) = ubounds(1)
        % end
        % if u(j,1) < ubounds(2)
        %     disp('Too big of a deceleration')
        %     u(j,1) = ubounds(2)
        % end
        %
        % if new_vel > vbounds
        %     disp('Youd go too fast')
        %     u(j,1) = 0
        % end
        % if (xl - (x + v*dt + 0.5*accel*dt*dt)) < HSAFE
        %     u(j,i) = 0;
        % end
    end
    if i == sim_time
        break
    end
    % Use Euler method to propagate states
    X(:,i+1) = X(:,i) + V(:,i)*dt + 0.5*U(:,i)*dt*dt;
    V(:,i+1) = V(:,i) + U(:,i)*dt;
    U(:,i+1) = u(:);
    H(:,i+1) = h(:);
end

% Plot the positions
figure('DefaultAxesFontSize',20)
plot_velocities = plot(t, X);
plot_velocities(1).LineWidth = 4;
plot_velocities(1).LineStyle = ':';
plot_velocities(2).LineWidth = 4;
plot_velocities(2).LineStyle = '--';
plot_velocities(3).LineWidth = 4;
plot_velocities(3).LineStyle = '-.';
xlabel('Time (s)')
ylabel('Position (m)')
title('Position of Vehicles')
legend('First Car','Second Car','Third Car',...
       'Location','northwest')
grid on

% Plot the velocities
figure('DefaultAxesFontSize',20)
plot_velocities = plot(t, V);
plot_velocities(1).LineWidth = 4;
plot_velocities(1).LineStyle = ':';
plot_velocities(2).LineWidth = 4;
plot_velocities(2).LineStyle = '--';
plot_velocities(3).LineWidth = 4;
plot_velocities(3).LineStyle = '-.';
xlabel('Time (s)')
ylabel('Speed (m/s)')
title('Speed of Vehicles')
legend('First Car','Second Car','Third Car',...
       'Location','southeast')
grid on

% Plot the accelerations
figure('DefaultAxesFontSize',20)
plot_velocities = plot(t, U);
plot_velocities(1).LineWidth = 4;
plot_velocities(1).LineStyle = ':';
plot_velocities(2).LineWidth = 4;
plot_velocities(2).LineStyle = '--';
plot_velocities(3).LineWidth = 4;
plot_velocities(3).LineStyle = '-.';
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('Acceleration of Vehicles')
legend('First Car','Second Car','Third Car',...
       'Location','northeast')
grid on

% Plot the headways
figure('DefaultAxesFontSize',20)
plot_velocities = plot(t, H);
plot_velocities(1).LineWidth = 4;
plot_velocities(1).LineStyle = ':';
plot_velocities(2).LineWidth = 4;
plot_velocities(2).LineStyle = '--';
plot_velocities(3).LineWidth = 4;
plot_velocities(3).LineStyle = '-.';
xlabel('Time (s)')
ylabel('Headway (m)')
title('Headways of Vehicles')
legend('First Car','Second Car','Third Car',...
       'Location','northeast')
grid on
