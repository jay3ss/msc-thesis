% Simulation parameters
% SI units used throughout
dt = 0.1;   % time step
N = 2000;   % number of time steps
n = 3;      % number of cars
L= 70;      % radius of Ring (m)
d =  5;     % length of car (m)

% IDM parameters
v0 = 80; % desired speed
T = 2;   % reaction time
s0 = 15; % min. bumper-to-bumper distance
a = 0.2; % acceleration
b = 4.0; % comfortable braking

% Initial conditions
Vi = 0; % initial velocity
dx = [Vi, Vi, Vi];      % velocities
x = [0, 10, 55];        % positions
s(1) = x(2) - x(1) - d; % headways
s(2) = x(3) - x(2) - d;
s(3) = 2*pi*L - x(3) - d;

for j = 1:1:N % Time Loop
    for i  = 1:1:n % Loop for number of cars
        % Find the relative velocity
        if i == n  % if the car is lead car
            vl = dx(i) - dx(1);
        else
            vl = dx(i) - dx(i+1);
        end
        % Updates in this order:
        % desired gap
        % acceleration
        % velocity
        % position
        % headway
        s_star = s0 + max(0, dx(i)*T ...
               + 0.5*dx(i)*vl/sqrt(a*b));
        dvdt(i) = a*(1- (dx(i)/v0))^4 ...
                - a*(s_star/s(i))^2;
        dx(i) = dx(i) + dvdt(i)*dt;

        if dx(i) < 0
            x(i) = x(i) - 0.5*dx(i)*dx(i)/dvdt(i);
            dx(i) = 0;
        else
            x(i) = x(i) + dx(i)*dt + 0.5*dvdt(i)*dt*dt;
        end

        theta(i) = x(i)*2*pi/L; % x convert to angle
        % Reset to beginning of ring if necessary
        if theta(i) > 2*pi
           theta(i) = theta(i) - 2*pi;
        end
    end

    % Calculate the headways
    s(1) = x(2) - x(1) - d;
    s(2) = x(3) - x(2) - d;
    s(3) = x(1) - x(3) - d;

    % Add the length of the road if the lead
    % vehicle is at the beginning of the
    % ring and the following vehicle is towards
    % the end
    if s(1) < 0
        s(1) = s(1) + L;
    end

    if s(2) < 0
        s(2) = s(2) + L;
    end

    if s(3) < 0
        s(3) = s(3) + L;
    end
    % Take care of states at each time step
    Theta(j,:) = theta(:);
    X(j,:) = x(:);      % Location
    V(j,:) = dx(:);     % Speed
    S(j,:) = s(:);      % Headways
    t(j) = dt*(j-1);	% actual running time
end

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
       'Location','northeast')
grid on

% Plot the headways
figure('DefaultAxesFontSize',20)
plot_headways = plot(t, S);
plot_headways(1).LineWidth = 4;
plot_headways(1).LineStyle = ':';
plot_headways(2).LineWidth = 4;
plot_headways(2).LineStyle = '--';
plot_headways(3).LineWidth = 4;
plot_headways(3).LineStyle = '-.';
title('Headway of vehicles')
xlabel('Time (s)')
ylabel('Headway (m)')
legend('First Car','Second Car','Third Car',...
       'Location','northeast')
grid on
