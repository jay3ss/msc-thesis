function ypISCR = ypISCR(t,y)
%This function sets up the dynamics of the system to be solved in ODE45
b = .01; %beta = spread rate
g = .01; %gamma = stifle rate
a = .01; %alpha = counter-spread rate
m = .01; %mu = counter-stifle rate
k = .5;  %average number of contacts of each individual
w1 = .001; %omega1 = spreader openness to counter-spreader
w2 = .001; %omega1 = counter-spreader openness to spreader
% Defines the dynamics
ypISCR(1) =-b*k*y(1)*y(2)-a*k*y(1)*y(3); %ignorant
ypISCR(2) = b*k*y(1)*y(2)-w1*k*y(2)*y(3)+w2*k*y(2)*y(3)-g*k*y(2)*(y(2)+y(4)); %spreader
ypISCR(3) = a*k*y(1)*y(3)+w1*k*y(2)*y(3)-w2*k*y(2)*y(3)-m*k*y(3)*(y(3)+y(4)); %counter
ypISCR(4) = g*k*y(2)*(y(2)+y(4))+m*k*y(3)*(y(3)+y(4)); %recovered
ypISCR = [ypISCR(1) ypISCR(2) ypISCR(3) ypISCR(4)]'; 
end

