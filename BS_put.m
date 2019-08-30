function F = BS_put(x,S,r,K,T,c)
x = x(2);
F = -S*(1-normcdf((log(S/K)+r*T)/(x*T^0.5) + 0.5*x*T^0.5)) + K*exp(-r*T)*(1-normcdf((log(S/K)+r*T)/(x*T^0.5) + 0.5*x*T^0.5 - x*T^0.5)) - c;