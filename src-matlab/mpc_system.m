function [inp_del,a,b,c,d]=mpc_system(T,Delay,G,ftype)


inp_del = Delay/T;

% ak nie je zspace treba prekonvertovat do discrete time
if  ~strcmp(ftype,'zspace')
   G=c2d(G, T);
end

[a,b,c,d]=ssdata(G);
Gd = ss(a,b,c,d,T,'inputdelay',inp_del);
[a,b,c,d]=ssdata(Gd);

