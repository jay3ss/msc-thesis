clc
close all
clear all

T = 1.5;
s = tf('s');
P = 1/(T*s + 1);


Kp = [1 10 25];

start = 0;
stop = 5;
dt = 0.01;
t = start:dt:stop;

figure('DefaultAxesFontSize',16)

for i=1:length(Kp)
    C = pid(Kp(i));
    Ts = feedback(C*P,1);
    step(Ts,t);
    hold on
end

tr = 0:50;
r = ones(1,51);
plot(tr,r, '--')
ylim([0,1.1])

lgd_label = {
    strcat('K=',num2str(Kp(1))),...
    strcat('K=',num2str(Kp(2))),...
    strcat('K=',num2str(Kp(3))),...
    'r(s)'};

lgd = legend;
lgd.Location = 'southeast';
lgd.FontSize = 16;
lgd.String = lgd_label;
% set(gcf, 'Position', get(0, 'Screensize'));