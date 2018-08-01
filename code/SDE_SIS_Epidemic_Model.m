%Stochastic Differential Equation
%SIS Epidemic Model
%Three Sample Paths and the Deterministic Solution
clear
beta=1;
b=0.25;
gam=0.25;
N=100;
init=2;
dt=0.01;
time=25;
sim=3;
for k=1:sim
    clear i %, t
    j=1;
    i(j)=init;
    t(j)=dt;
    while i(j)>0 & t(j)<25
        mu=beta*i(j)*(N-i(j))/N-(b+gam)*i(j);
        sigma=sqrt(beta*i(j)*(N-i(j))/N+(b+gam)*i(j));
        rn=randn; % standard normal random number
        i(j+1)=i(j)+mu*dt+sigma*sqrt(dt)*rn;
        t(j+1)=t(j)+dt;
        j=j+1;
    end
    plot(t,i,'r-','Linewidth',2);
    hold on
end
%Euler's method applied to the deterministic SIS model.
y(1)=init;
for k=1:time/dt
    y(k+1)=y(k)+dt*(beta*(N-y(k))*y(k)/N-(b+gam)*y(k));
end
plot([0:dt:time],y,'k--','Linewidth',2);
axis([0,time,0,80]);
xlabel('Time');
ylabel('Number of Infectives');
hold off
