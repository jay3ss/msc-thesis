function ypsirc = ypsirc(t,y)
%given the input parameters of an SIRC model, this function sets up the dynamics of the
%system to be solved in ODE45
b = .01; %beta = spread rate
g = .1; %gamma = stifle rate
a = .02; %alpha = counter-spread rate
m = .1; %mu = counter-stifle rate
w1 = .001; %omega1 = spreader openness to counter-spreader
w2 = .001; %omega1 = counter-spreader openness to spreader

ypsirc(1) =-b*y(1)*y(2)-a*y(1)*y(3); %ignorant
ypsirc(2) = b*y(1)*y(2)-w1*y(2)*y(3)+w2*y(2)*y(3)-g*y(2); %spreader
ypsirc(3) = a*y(1)*y(3)+w1*y(2)*y(3)-w2*y(2)*y(3)-m*y(3); %counter
ypsirc(4) = g*y(2)+m*y(3); %recovered
ypsirc = [ypsirc(1) ypsirc(2) ypsirc(3) ypsirc(4)]'; 

end

