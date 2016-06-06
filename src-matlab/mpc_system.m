function [inp_del,a,b,c,d]=mpc_system(T,Delay,G)


inp_del = Delay/T;



[a,b,c,d]=ssdata(G);
try
Gd = ss(a,b,c,d,T,'inputdelay',inp_del);
catch
Gd = ss(a,b,c,d,T);
end
[a,b,c,d]=ssdata(Gd);

