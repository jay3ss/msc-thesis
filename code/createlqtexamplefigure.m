function createlqtexamplefigure(X1, Y1, X2, Y2, X3, Y3)
%CREATEFIGURE(X1, Y1, X2, Y2, X3, Y3)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  Y2:  vector of y data
%  X3:  vector of x data
%  Y3:  vector of y data

%  Auto-generated by MATLAB on 31-Jul-2018 00:55:01

% Create figure
figure1 = figure('DefaultAxesFontSize',16);

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0612088752869166 0.11 0.87911247130834 0.815]);
hold(axes1,'on');

% Activate the left side of the axes
yyaxis(axes1,'left');
% Create plot
plot(X1,Y1,'DisplayName','x(t)','LineWidth',2);

% Create plot
plot(X2,Y2,'DisplayName','reference','LineWidth',1);

% Create ylabel
ylabel('x');

% Set the remaining axes properties
set(axes1,'YColor',[0 0.447 0.741]);
% Activate the right side of the axes
yyaxis(axes1,'right');
% Create plot
plot(X3,Y3,'DisplayName','u(t)','LineWidth',2);

% Create ylabel
ylabel('u');

% Set the remaining axes properties
set(axes1,'YColor',[0.85 0.325 0.098]);
% Create xlabel
xlabel('Time (s)');

% Create title
title('State and Control Trajectories');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 5.1]);
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'LineStyleOrderIndex',2);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Location','east','FontSize',16);

