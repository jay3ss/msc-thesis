function ypISSRR = ypISSRR(t,y)
%given the input parameters of an SIRC model, this function sets up the dynamics of the
%system to be solved in ODE45
b1 = .12;  % beta_1 spread constant
b2 = .1; % beta_2 spread constant
g11 = .01; % gamma stifle constant from S1 to R1
g12 = .001; % gamma stifle constant from S1 to R2
g21 = .001; % gamma stifle constant from S2 to R1
g22 = .01; % gamma stifle constant from S2 to R2
d12 = .51; % influence of group 1 on group 2
d21 = .49; % influence of group 2 on group 1

ypISSRR(1) =-b1*y(1)*y(2)-b2*y(1)*y(3); %ignorant
ypISSRR(2) = b1*y(1)*y(2)+(d12-d21)*y(2)*y(3)-(g11+g12)*y(2)^2; %spreader 1
ypISSRR(3) = b2*y(1)*y(3)+(d21-d12)*y(2)*y(3)-(g22+g21)*y(3)^2; %spreader 2
ypISSRR(4) = g11*y(2)^2+g21*y(3)^2; %recovered 1
ypISSRR(5) = g22*y(3)^2+g12*y(2)^2; %recovered 2
ypISSRR = [ypISSRR(1) ypISSRR(2) ypISSRR(3) ypISSRR(4) ypISSRR(5)]'; 

end

