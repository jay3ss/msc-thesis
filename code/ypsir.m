function ypsir = ypsir(t,y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
a = .01;
b = .1;
ypsir(1) =-a*y(1)*y(2);
ypsir(2) = a*y(1)*y(2)-b*y(2);
ypsir(3) = b*y(2);
ypsir = [ypsir(1) ypsir(2) ypsir(3)]'; 

end

