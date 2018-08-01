clc
close all
clear all

% Generate the data
kj = 4;
uf = 4;

density_vals = linspace(0, kj);
speed_vals = linspace(0,uf);

speed_density = uf/kj*(kj - density_vals);
flow_speed = uf/kj*density_vals.*(kj - density_vals);
speed_flow = kj*speed_vals.*(1 - speed_vals/uf);

figure('DefaultAxesFontSize',16)
subplot(2,2,1)
% subplot(1,2,1)
p1 = plot(density_vals, speed_density);
p1.LineWidth = 2;
title('Speed-Density Relation')
xlabel('Density (\rho)')
ylabel('Speed (V)')

tick_cell = {'XTickLabel',{},'YTickLabel',{}};
set(gca, tick_cell{:});
% set(gca,'XTick',4)
% set(gca,'XTickLabel',{'\rho_{max}'})
% set(gca,'YTick',4)
% set(gca,'YTickLabel',{'V_{max}'})
xlim([0 kj+0.5]);
ylim([0 uf+0.5]);

subplot(2,2,2)
% subplot(1,2,2)
p2 = plot(speed_vals, flow_speed);
p2.LineWidth = 2;
title('Flow-Speed Relation')
xlabel('Speed (V)')
ylabel('Flow (Q)')

tick_cell = {'XTickLabel',{},'YTickLabel',{}};
set(gca, tick_cell{:});
% set(gca,'XTick',4)
% set(gca,'XTickLabel',{'\rho_{max}'})
% set(gca,'YTick',4)
% set(gca,'YTickLabel',{'V_{max}'})
xlim([0 kj+0.5]);
ylim([0 uf+0.5]);

subplot(2,2,[3, 4])
% subplot(2,2,3)
p3 = plot(speed_flow, speed_vals);
p3.LineWidth = 2;
title('Speed-Flow Relation')
xlabel('Flow (Q)')
ylabel('Speed (V)')

tick_cell = {'XTickLabel',{},'YTickLabel',{}};
set(gca, tick_cell{:});
% set(gca,'XTick',4)
% set(gca,'XTickLabel',{'\rho_{max}'})
% set(gca,'YTick',4)
% set(gca,'YTickLabel',{'V_{max}'})
xlim([0 uf+0.5]);
ylim([0 kj+0.5]);
