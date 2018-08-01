% Plots the three companies with the highest average autonomous miles
% driven per disengagement for the reporting years 2015, 2016, 2017
% Sourced from:
% - https://www.dmv.ca.gov/portal/dmv/detail/vr/autonomous/disengagement_report_2015
% - https://www.dmv.ca.gov/portal/dmv/detail/vr/autonomous/disengagement_report_2016
% - https://www.dmv.ca.gov/portal/dmv/detail/vr/autonomous/disengagement_report_2017

% 2015 - Waymo, Volkswagen, Delphi
waymo2015 = 1560.0404411765;
volks2015 = 57.4807692308;
delphi2015 = 41.1407407407;

% 2016 - Waymo, Ford, Nissan
waymo2016 = 5127.9677419355;
ford2016 = 196.6666666667;
nissan2016 = 146.3928571429;

% 2017 - Waymo, Cruise, Nissan
waymo2017 = 5127.9677419355;
cruise2017 = 1254.0565714286;
nissan2017 = 208.625;

first = [waymo2015, waymo2016, waymo2017];
second = [volks2015, ford2016, cruise2017];
third = [delphi2015, nissan2016, nissan2017];

figure('DefaultAxesFontSize',20)
years = [2015, 2016, 2017];
width = 0.6;
bar(years, first, width)
hold on
bar(years, second, width)
hold on
bar(years, third, width)

grid on
title('Miles Driven per Disengagement')
ylabel('Average miles driven per disengagement')
xlabel('Year')
% legend({'First', 'Second', 'Third'},'Location','northwest')
set (gca,'yscale','log');
ylim([10 10000])

text_settings = {...
     'VerticalAlignment', 'top',...
     'HorizontalAlignment', 'center',...
     'FontSize', 15,...
     'FontWeight', 'bold'};

% Label each portion of the bar graphs indicating which company corresponds
% to which graph
% First
text(2015, waymo2015, 'Waymo', text_settings{:})
text(2016, waymo2016, 'Waymo', text_settings{:})
text(2017, waymo2017, 'Waymo', text_settings{:})

% Second
text(2015, volks2015,  'Volkswagen', text_settings{:})
text(2016, ford2016,   'Ford',       text_settings{:})
text(2017, cruise2017, 'GM Cruise',  text_settings{:})

% Third
text(2015, delphi2015, 'Delphi', text_settings{:})
text(2016, nissan2016, 'Nissan', text_settings{:})
text(2017, nissan2017, 'Nissan', text_settings{:})