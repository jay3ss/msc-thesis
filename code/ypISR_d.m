function ypISR_d = ypISR_d(t,y)
%This function outputs the dynamics to be analyzed
%   Detailed explanation goes here
a = .03;  %stifling constant
b = .6;   %spreading constant
k = .1;  %interaction constant
tau = .01; %natural decay time constant
ypISR_d(1) =-b*k*y(1)*y(2);
ypISR_d(2) = b*k*y(1)*y(2)-a*k*y(2)*(y(2))-y(2)*(1-exp(-t/tau));
ypISR_d(3) = a*k*y(2)*(y(2))+y(2)*(1-exp(-t/tau));
ypISR_d = [ypISR_d(1) ypISR_d(2) ypISR_d(3)]'; 

end

