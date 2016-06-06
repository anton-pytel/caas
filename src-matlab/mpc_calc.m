function [u,iflag]=mpc_calc(Ahat,Bhat,Qhat,Quhat,Hhat,x0,x00,u0,xref,uref,umin,umax,dumin,dumax,ymin,ymax,dymin,dymax)
% Sets up objective function and constraints for QP problem and solves.

Xdev=Ahat*x0+Bhat*uref-xref;
Xdev0=Ahat*x00+Bhat*uref-xref;

I=eye(length(uref));

duref=uref; %zeros

Lu_min=I; bu_min=umin-uref;
Lu_max=-I; bu_max=-umax+uref;

Ldu_min=I; bdu_min=dumin+u0-duref;
Ldu_max=-I; bdu_max=-dumax-u0+duref;

Lx_min=Hhat*Bhat; bx_min=ymin-Hhat*(Xdev+xref);
Lx_max=-Hhat*Bhat; bx_max=-ymax+Hhat*(Xdev+xref);

Ldx_min=Hhat*Bhat; bdx_min=dymin + Hhat*(Xdev0+xref)- Hhat*(Xdev+xref);
Ldx_max=-Hhat*Bhat; bdx_max=-dymax - Hhat*(Xdev0+xref)+ Hhat*(Xdev+xref);

L1=-[Lu_min; Lu_max; Ldu_min; Ldu_max; Lx_min; Lx_max; ]; %Ldx_min; Ldx_max
b1=-[bu_min; bu_max; bdu_min; bdu_max; bx_min; bx_max; ]; %bdx_min; bdx_max

H=Bhat'*Qhat*Bhat+Quhat;
f=(Xdev'*Qhat*Bhat);
try
[u,J,iflag]=quadprog(H,f,L1,b1);
catch
% uprava kvoli octave [u,J,iflag]=quadprog(H,f,L1,b1);
f=f';
[u,J,iflag]= qp([], H,f, [], [], [], [], [], L1, b1);
end