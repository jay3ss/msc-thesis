function ypISS = ypISS(t,y)
%This function outputs the dynamics to be analyzed
a = .03;  %stifling constant
b = .1;   %spreading constant
k = .05;  %interaction constant
% Dynamics to be called to ode45
ypISS(1) =-b*k*y(1)*y(2);
ypISS(2) = b*k*y(1)*y(2)-a*k*y(2)*(y(2)+y(3));
ypISS(3) = a*k*y(2)*(y(2)+y(3));
ypISS = [ypISS(1) ypISS(2) ypISS(3)]'; 
end

