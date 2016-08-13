clc;
% system
A = [1 0 ; 1 1];
B = [1; 0.5];
C = [0 1];
D = 0;

A = [     0     1     0     0
          0     0     0     0
          0     0     0     1
          0     0     0     0
     ];
B=[       0         0
     1.2300         0
          0         0
          0    2.8800
   ];
C= [    1.0000         0         0         0
             0         0   57.2900         0
   ];
D= [     0     0
         0     0
    ];


% inicializacia
ut = zeros(size(B,2),1); % akcny zasah v case 0 + definicia velkosti akcneho zasahu
yt = zeros(size(C,1),1); % vystup v case 0 

y = yt';
u = ut';


% referencia
r = [4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 
     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  1  1  1  1  1  1
    ]; 

x0 = [C\yt; ut; r(:,1) ]; %x mnozina stavov bude vzdy vektor 
X0 = x0;
% nacitanie velkosti matic
m=size(ut); % ak je viacero vstupov tak m je ich pocet
m=m(1);
ny=size(yt); % ak je viacero vystupov tak ny je ich pocet
ny=ny(1);
sB=size(B);
sBc=sB(2);
sB=sB(1);
sA=size(A);
sA=sA(1);

% Upraveny system
% x(k+1)     A   B   0     x(k)       B 
% u(k)   =   0   Im  0     u(k-1)  +  Im   du = Am x(k) + Bm du(k)
% r(k+1)     0   0   Iny   r(k)       0

% e(k) = [C 0 -Iny] * x(k) = Cm * x(k)

% uprava matic so zahrnutim referencie
A1 = [     A         B      zeros(sB,ny)
      zeros(m,sA)  eye(m)   zeros(m,ny)
      zeros(m,sA) zeros(m)  eye(m,ny)
     ]

B1 = [   B
       eye(m)
      zeros(m)
     ]
 
C1 = [C  zeros(ny) -eye(ny)]

% A1 = [1 0 ; 1 1];
% B1 = [1; 0.5];
% C1 = [0 1];
% D1 = 0;
% m=1;

% horizont
N1 = 3;


% A1 = [     0     1     0     0
%           0     0     0     0
%           0     0     0     1
%           0     0     0     0
%      ];
% B1=[       0         0
%      1.2300         0
%           0         0
%           0    2.8800
%    ];
% C1= [    1.0000         0         0         0
%              0         0   57.2900         0
%    ];
% D1= [     0     0
%          0     0
%     ];

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


V;
Tx=T;
     
% Q - vaha minulych stavov
% Qn - vaha posledneho stavu
% R - vaha akcneho zasahu

% nastavenie vahovych matic
Q = 1;
Q = C1' * Q * C1;
Qn = 0; % lebo mame delta akcenho zasahu du
Qn = C1' * Qn * C1;

In = eye(N1-1); 
K1 = kron(In,Q);
[rwsK,clmsK]=size(K1);
[rwsQ,clmsQ]=size(Qn);


% Qv = [ kron (In,Q)    0
%          0            Qn ]

Qv = [K1 zeros(rwsK,clmsQ); zeros(rwsQ,clmsK) Qn];

Rd = 1;
R = Rd*eye(m); % vahu vynasobime poctom vstupov
Rv = kron(eye(N1),R);

% Bhat <=> T
% Ahat <=> V
% Qhat <=> Qv 
% Quhat <=> Rv
% H = Bhat' * Qhat * Bhat + Quhat
H = T'*Qv*T + Rv;

%%%%%%%%%%%%%%%%%
% MPC standardne optimalizuje k 0 a preto Bhat*uref - xref 
% posunie pomyselnu "0" do referencneho stavu xref
% pretoze uref chceme mat minimalnu teda ju nastavime na [0,...,0] vektor

% Xdev = Ahat*x0 + Bhat*uref - xref
% f = Xdev' * Qhat*Bhat
% => u nas x0' * F  <=> f v mpc_calc
F = V'*Qv*T;
Y = V'*Qv*V;


%Pridanie obmedzeni
umin = -2;
umax = 2;
% ak je minimalne vacsie ako maximalne
if umin > umax
    utmp = umax;
    umax = umin;
    umin = utmp;
end

ymin = -4.1;
ymax = 4.1;
if ymin > ymax
    ytmp = ymax;
    ymax = ymin;
    ymin = ytmp;
end

% Hhat <=> Gv
Gv = zeros(sCr*N1, sC*N1);
for k=0:N1-1
    Gv(  (k*sCr)+1 : (k+1)*sCr ,  (k*sC)+1 : (k+1)*sC ) = C1;
end


% Samotny algoritmus

for i = 1:60
%     Ec
%     As = Ec*x0 + Gc* ut;
%     bs = mv;
    utl = ut;
    [szx,tr] =size(x0);
    x0=x0(1:szx-(m+ny),:);

    %ut = -inv(H)*F'*[x0; utl; r(i)]; % terajsi akcny zasah "du" vektor
    
    ut = quadprog(H, [x0; utl; r(:,i)]'*F,[],[],[],[],umin,umax)
    ut = ut(1:m)+utl;   % Kedze vysledok bol delta u, tak musime prirat minulu hodnotu
    et = C1 * [x0; utl; r(:,i)]; % odchylka
    x0 = A1*[x0; utl; r(:,i)] + B1*(ut-utl); % novy stav
    X0=[X0;x0];
    yt = et + r(:,i); % vystup je odchylka + referencia e = y - r
    y =[y; yt'];
    u = [u; ut'];
end

X0
figure
plot(y)
figure
plot(u)
