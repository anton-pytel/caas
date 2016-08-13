function [Ahat,Bhat,Qhat,Quhat,Hhat,nx,nu,ny]=mpc_init2(a,b,c,d,Qy,Sy,Qu,Np)

% Compute mapping from present (initial) state, Ahat, and future inputs, Bhat,
% to future states: x_future=Ahat*x0+Bhat*u_future
nx=length(a);[ny,nu]=size(d);

A1 = a;
B1 = b;
C1 = c;
D1 = d;
N1 = Np;
m = nu;

% prepocitanie velkosti matic
sB=size(B1);
sBc=sB(2);
sB=sB(1);

sA=size(A1);
sA=sA(1);

sC=size(C1);
sCr=sC(1);
sC=sC(2);


V=A1^1;
T= A1^(N1-1)* B1;
for k = 2:N1
  V = [V ; A1^k];
  T = [T, A1^(N1-k) * B1];
end

% ulozit si posledny riadok
Ttmp = T;
% vynulovat 1. az predposleny riadok
T = [  zeros(    (N1-1)*sB  ,  N1*sBc   );     T    ];

% Postupne orezany posledny riadok priradit do riadku 1. (0.) az po predposledny(-1) 
for k = 0:N1-2
    T( (k*sB)+1 : (k+1)*sB ,  1 : (k+1)*sBc )    = Ttmp(  :  ,  (N1-k)*sBc - (sBc-1) : N1*sBc);
end

% horizont predikcie 3
% T  =   A^0 B           0          0
%        A^1 B         A^0 B        0
%        A^2 B         A^1 B      A^0 B  
% ak B nie je vektor musime orezat

%Vx = V;
%Tx = T;
     
% Q - vaha minulych stavov
% Qn - vaha posledneho stavu
% R - vaha akcneho zasahu

% Weightings:
% Qx=c'*Qy*c;   % Output weight -> state weight for 1<i<Np-1;
% S=c'*Sy*c;    % Terminal weight at i=N
                % Input weight for 0<i<Np-1
                
% nastavenie vahovych matic
Q = Qy;
Q = C1' * Q * C1;
Qn = Sy; % lebo mame delta akcenho zasahu du
Qn = C1' * Qn * C1;

In = eye(N1-1); 
K1 = kron(In,Q);
[rwsK,clmsK]=size(K1);
[rwsQ,clmsQ]=size(Qn);

% Qv = [ kron (In,Q)    0
%          0            Qn ]
Qv = [K1 zeros(rwsK,clmsQ); zeros(rwsQ,clmsK) Qn];

Rd = Qu;
R = Rd*eye(m); % vahu vynasobime poctom vstupov
Rv = kron(eye(N1),R);

% Hhat <=> Gv
Gv = zeros(sCr*N1, sC*N1);
for k=0:N1-1
    Gv(  (k*sCr)+1 : (k+1)*sCr ,  (k*sC)+1 : (k+1)*sC ) = C1;
end
Hhat = Gv;
Bhat = T;
Ahat = V;
Qhat = Qv;
Quhat = Rv;
% a
% b
% c
% d
% Ahat
% Bhat
% Qhat = Qv
% Quhat = Rv
% Hhat = Gv