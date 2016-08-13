function [inp_del,a,b,c,d]=mpc_system(T,Delay,G,ftype)


inp_del = Delay/T;

% ziska sa stavovy model 
[a,b,c,d]=ssdata(G);

% ak nie je zspace treba prekonvertovat do discrete time inak
if  ~strcmp(ftype,'zspace')
    try
      G = ss(a,b,c,d,'inputdelay',Delay);
    catch
      G = ss(a,b,c,d)
    end
    Gd=c2d(G, T);
else
   try
     Gd = ss(a,b,c,d,T,'inputdelay',inp_del);
   catch
     G = ss(a,b,c,d,T)
   end
end
[a,b,c,d]=ssdata(Gd);
