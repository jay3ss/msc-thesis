function ypISR_HI = ypISR_HI(t,y)
%This function outputs the dynamics to be analyzed
%   Detailed explanation goes here
a = .1;  %stifling constant
b = .3;   %spreading constant
k = 1;  %interaction constant
tau = .01; %natural decay time constant
ypISR_HI(1) =-b*k*y(1)*y(2);
ypISR_HI(2) = b*k*y(1)*y(2)-a*k*y(2)*(y(2))-y(2));
ypISR_HI(3) = a*k*y(2)*(y(2))+y(2));
ypISR_HI = [ypISR_HI(1) ypISR_HI(2) ypISR_HI(3)]'; 

end

