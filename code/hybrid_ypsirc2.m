function hybrid_ypsirc2 = hybrid_ypsirc2(t,y)
%given the input parameters of an SIRC model, this function sets up the dynamics of the
%system to be solved in ODE45
b2 = .01; %beta1 = spread rate
g2 = .1; %gamma1 = stifle rate
a2 = .02; %alpha1 = counter-spread rate
m2 = .1; %mu1 = counter-stifle rate
w21 = .001; %omega11 = spreader openness to counter-spreader
w22 = .001; %omega12 = counter-spreader openness to spreader
a12 = 0 %a12 = receptiveness to group 1

hybrid_ypsirc2(1) =-b2*y(1)*y(2)-a2*y(1)*y(3); %ignorant 2
hybrid_ypsirc2(2) = b2*y(1)*y(2)-w21*y(2)*y(3)+w22*y(2)*y(3)-g2*y(2); %spreader 2
hybrid_ypsirc2(3) = a2*y(1)*y(3)+w21*y(2)*y(3)-w22*y(2)*y(3)-m2*y(3); %counter 2
hybrid_ypsirc2(4) = g2*y(2)+m2*y(3); %recovered 2
hybrid_ypsirc2 = [hybrid_ypsirc2(1) hybrid_ypsirc2(2) hybrid_ypsirc2(3) hybrid_ypsirc2(4)]'; 

end

