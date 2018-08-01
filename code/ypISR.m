function ypISR = ypISR(t,y)
%This function outputs the dynamics to be analyzed
%   Detailed explanation goes here
a = .03;  %stifling constant
b = .6;   %spreading constant
k = .1;  %interaction constant
tau = .01; %natural decay time constant
ypISR(1) =-b*k*y(1)*y(2);
ypISR(2) = b*k*y(1)*y(2)-a*k*y(2)*(y(2))-y(2));
ypISR(3) = a*k*y(2)*(y(2))+y(2));
ypISR = [ypISR(1) ypISR(2) ypISR(3)]'; 

end

