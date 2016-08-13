function [Ahat,Bhat,Qhat,Quhat,Hhat,nx,nu,ny]=mpc_init(a,b,c,d,Qy,Sy,Qu,Np)

% Weightings:
Qx=c'*Qy*c;   % Output weight -> state weight for 1<i<Np-1;
S=c'*Sy*c;    % Terminal weight at i=N
              % Input weight for 0<i<Np-1


%%%%%%%%%%%%% CHANGE PARAMETERS ABOVE THIS LINE.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Compute mapping from present (initial) state, Ahat, and future inputs, Bhat,
% to future states: x_future=Ahat*x0+Bhat*u_future
nx=length(a);[ny,nu]=size(d);
Ahat=a;Bhat=[b zeros(length(b),Np-1)];
for i=2:Np,
    Ahat=[Ahat;a^i];
    for j=1:Np,
        if (i-j)>-1,
            Bhat_n(:,j)=a^(i-j)*b;
        else
            Bhat_n(:,j)=0*b;
        end
    end
    Bhat=[Bhat;Bhat_n];
end

% Stack up state and output weights in block-diagonal matrices to
% replace summing in objective function by matrix multiplication in QP:
Qhat=[Qx zeros(nx,nx*(Np-1))];  
Quhat=[Qu zeros(nu,nu*(Np-1))]; 
for i=2:Np,
    if i==Np,
        % weight on terminal state (1st sample after optimization horizon)
        Qx=S;
    end
    Qhat_n=[zeros(nx,nx*(i-1)) Qx zeros(nx,nx*(Np-i))];
    Quhat_n=[zeros(nu,nu*(i-1)) Qu zeros(nu,nu*(Np-i))];
    Qhat=[Qhat;Qhat_n];
    Quhat=[Quhat;Quhat_n];
end

% Constraints on states in matrix form: y_min<Hhat*x<y_max
H=c;
Hhat=[c zeros(ny,nx*(Np-1))];
for i=2:Np,
Hhat_n=[zeros(ny,nx*(i-1)) H zeros(ny,nx*(Np-i))];
Hhat=[Hhat;Hhat_n];
end
% a
% b
% c
% d
% Ahat
% Bhat
% Qhat = Qv
% Quhat = Rv
% Hhat = Gv
