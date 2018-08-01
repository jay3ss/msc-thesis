function ypsi = ypsi(t,y)
% Sets up the dynamics to be called to ode45
b = .005;  %spreading rate, beta
ypsi(1) =-b*y(1)*y(2);
ypsi(2) = b*y(1)*y(2);
ypsi = [ypsi(1) ypsi(2)]'; 

end

