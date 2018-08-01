function hybrid_ypsirc = hybrid_ypsirc(t,y)
%This function sets up the dynamics of the system to be solved in ODE45
b1 = .02; %beta1 = spread rate
g1 = .1; %gamma1 = stifle rate
a1 = .01; %alpha1 = counter-spread rate
m1 = .1; %mu1 = counter-stifle rate
w11 = .001; %omega11 = spreader openness to counter-spreader
w12 = .001; %omega12 = counter-spreader openness to spreader
a21 = 1; %a21 = receptiveness to group 2
b2 = .01; %beta1 = spread rate
g2 = .1; %gamma1 = stifle rate
a2 = .02; %alpha1 = counter-spread rate
m2 = .1; %mu1 = counter-stifle rate
w21 = .001; %omega11 = spreader openness to counter-spreader
w22 = .001; %omega12 = counter-spreader openness to spreader
a12 = .1; %a12 = receptiveness to group 1
%SIRC1
hybrid_ypsirc(1) =-b1*y(1)*y(2)-a1*y(1)*y(3)-a21*b2*y(1)*y(6)-a21*a2*y(1)*y(7); %ignorant 1
hybrid_ypsirc(2) = b1*y(1)*y(2)-w11*y(2)*y(3)+w12*y(2)*y(3)-g1*y(2)+a21*b2*y(1)*y(6); %spreader 1
hybrid_ypsirc(3) = a1*y(1)*y(3)+w11*y(2)*y(3)-w12*y(2)*y(3)-m1*y(3)+a21*a2*y(1)*y(7); %counter 1
hybrid_ypsirc(4) = g1*y(2)+m1*y(3); %recovered 1
%SIRC2
hybrid_ypsirc(5) =-b2*y(5)*y(6)-a2*y(5)*y(7)-a12*b1*y(5)*y(2)-a12*a1*y(5)*y(3); %ignorant 2
hybrid_ypsirc(6) = b2*y(5)*y(6)-w21*y(6)*y(7)+w22*y(6)*y(7)-g2*y(6)+a12*b1*y(5)*y(2); %spreader 2
hybrid_ypsirc(7) = a2*y(5)*y(7)+w21*y(6)*y(7)-w22*y(6)*y(7)-m2*y(7)+a12*a1*y(5)*y(3); %counter 2
hybrid_ypsirc(8) = g2*y(6)+m2*y(7); %recovered 2
hybrid_ypsirc = [hybrid_ypsirc(1) hybrid_ypsirc(2) hybrid_ypsirc(3) hybrid_ypsirc(4) hybrid_ypsirc(5) hybrid_ypsirc(6) hybrid_ypsirc(7) hybrid_ypsirc(8)]'; 
end

