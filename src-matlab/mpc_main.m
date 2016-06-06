function yJson=mpc_main(xJson,funcType)

switch funcType
    case '0'
        yJson = xJson; %save the init state and others will be completed next
        %T=5; % sampling time
        T = xJson.ctlSys.samplingTime; %0.1;
        Delay = xJson.ctlSys.inputDelay;

        if isfield(xJson.ctlSys, 'ss')
            % state space
            a=xJson.ctlSys.ss.sysA.val;
            b=xJson.ctlSys.ss.sysB.val;
            c=xJson.ctlSys.ss.sysC.val;
            d=xJson.ctlSys.ss.sysD.val;
        else
            % transfer function
            switch xJson.ctlSys.tfcn.sysType
                case 'zspace'
                    z=tf('z',T);
                    % '(0.000272 + 0.000272*z^-1 + 0.000272*z^-2)/(1 - 2.918*z^-1 + 2.884*z^-2 - 0.9655*z^-3)'
                    G = eval(xJson.ctlSys.tfcn.sysString);
                case 'sspace'
                    s=tf('s');
                    G = eval(xJson.ctlSys.tfcn.sysString);
                case 'numden'
                    for i=1:length(xJson.ctlSys.tfcn.sysNum)
                       row=xJson.ctlSys.tfcn.sysNum{i};
                       for j=1: length(row)
                           num{i,j}=row{j}.val;
                       end 
                    end
                    for i=1:length(xJson.ctlSys.tfcn.sysDen)
                       row=xJson.ctlSys.tfcn.sysDen{i};
                       for j=1: length(row)
                           den{i,j}=row{j}.val;
                       end 
                    end            
                    %G = tf( {1.467 -0.7322; -0.4399 1.19 },{[1.029 1] [1.161 1]; [1.404 1] [0.5369 1]});
                    G= tf(num, den);
            end
            [inp_del,a,b,c,d]=mpc_system(T,Delay,G);
            %nech mame ulozeny state space
            yJson.ctlSys.ss.sysA.val=a;
            yJson.ctlSys.ss.sysB.val=b;
            yJson.ctlSys.ss.sysC.val=c;
            yJson.ctlSys.ss.sysD.val=d;
        end

        % Weightings:
        Qy = xJson.ctlParam.qy; %1;
        Sy = xJson.ctlParam.sy; %1;
        Qu = xJson.ctlParam.qu; %0.01;

        % Horizon is Np (both for objective function and for constraints);
        Np = xJson.ctlParam.predictHorizon;  %20 iteration

        [Ahat,Bhat,Qhat,Quhat,Hhat,nx,nu,ny]=mpc_init2(a,b,c,d,Qy,Sy,Qu,Np);
        yJson.ctlCptParam.aHat.val=Ahat;
        yJson.ctlCptParam.bHat.val=Bhat;
        yJson.ctlCptParam.qHat.val=Qhat;
        yJson.ctlCptParam.quHat.val=Quhat;
        yJson.ctlCptParam.hHat.val=Hhat;
        yJson.ctlCptParam.nx=nx;
        yJson.ctlCptParam.nu=nu;
        yJson.ctlCptParam.ny=ny;
        return;
    otherwise 
        Np = xJson.ctlParam.predictHorizon;  %20 iteration
        a = xJson.ctlSys.ss.sysA.val;
        b = xJson.ctlSys.ss.sysB.val;
        c = xJson.ctlSys.ss.sysC.val;
        d = xJson.ctlSys.ss.sysD.val;
        Ahat = xJson.ctlCptParam.aHat.val;
        Bhat = xJson.ctlCptParam.bHat.val;
        Qhat = xJson.ctlCptParam.qHat.val;
        Quhat = xJson.ctlCptParam.quHat.val;
        Hhat = xJson.ctlCptParam.hHat.val;
        nx = xJson.ctlCptParam.nx;
        nu = xJson.ctlCptParam.nu;
        ny = xJson.ctlCptParam.ny;
        Qy = xJson.ctlParam.qy; %1;
        Sy = xJson.ctlParam.sy; %1;
        Qu = xJson.ctlParam.qu;
        
%         umin=[-10;-10];
%         umax=[10;10];
%         dumin=[-20;-20];
%         dumax=[20;20];
%         ymin=[-10;-10];
%         ymax=[10;10];
%         dymin=[-20;-20];
%         dymax=[20;20];
        isfound = false;
        i=1;
        while ~isfound
          if (xJson.ctlStep{i}.stepid == str2double(funcType))
              ljson = xJson.ctlStep{i};
%               if i>1 
%                   bjson = xJson.ctlStep{i-1}.ctrlStateNew;
%               else
%                   bjson =xJson.ctlSys.ctrlStateNew;
%               end
              isfound = true;
          end
          i = i +1;
        end
        umin=ljson.ctrlConstr.uMin.val';
        umax=ljson.ctrlConstr.uMax.val';
        dumin=ljson.ctrlConstr.duMin.val';
        dumax=ljson.ctrlConstr.duMax.val';
        ymin=ljson.ctrlConstr.yMin.val';
        ymax=ljson.ctrlConstr.yMax.val';
        dymin=ljson.ctrlConstr.dyMin.val';
        dymax=ljson.ctrlConstr.dyMax.val';
        
        %y0=zeros(ny,1); % Actual output - can be measured
        y0 = ljson.ctrlStateLast.y0.val';
        
        x0=c\y0;         % state value is according to actual output
        %x0 = ljson.ctrlStateLast.x1.val';
        
        %x00=zeros(nx,1); % initialize previous state
        x00 = ljson.ctrlStateLast.x0.val';
        
        %u0=zeros(nu,1);  % Prvy akcny zasah
        u0= ljson.ctrlStateLast.u0.val';

        
        % v kazdom kroku je potrebne mat tu istu hodnotu, lebo v kazdom kroku
        % overujem danu podmienku
        umin = repmat(umin,Np,1);
        umax = repmat(umax,Np,1);
        ymin = repmat(ymin,Np,1);
        ymax = repmat(ymax,Np,1);
        dumin = repmat(dumin,Np,1);
        dumax = repmat(dumax,Np,1);
        dymin = repmat(dymin,Np,1);
        dymax = repmat(dymax,Np,1);

        %simulation_time = 10;
        %NN=ceil(simulation_time/T); % Simulate NN samples:

        warning('off');% Turn off warnings from quadprog:

        % signal reference handling
        %yreff = [0;0];
        %yref_signal = eval('[0, 2; 5, 0]'); 
        yref_signal=ljson.refSig;
        [yref,xref,uref] = mpc_get_ref(Np,c,ny,nu, yref_signal);

        u0 = repmat(u0,Np,1);
        [u,exitflag]=mpc_calc(Ahat,Bhat,Qhat,Quhat,Hhat,x0,x00,u0,xref,uref,umin,umax,...
                              dumin,dumax,ymin,ymax,dymin,dymax);
        try
		if exitflag<0 
            disp('WARNING: infeasible QP problem')
        end;
		catch
		end
        % Implement present state:
        x=a*x0+b*u(1:nu);
        u0 = u(1:nu);
        % save last state
        x00=x0;
        % New initial state for next sample
        x0=x;
        y=c*x;
        yJson.y0.val=y';
        yJson.x0.val=x00';
        yJson.x1.val=x0';
        yJson.u0.val=u0';
        return;
end        

% Test controlling different system, than identified
% z=tf('z',0.25);
% G1 = eval('((z^-1*(1.04 + 0.23 * z^-1)))/((1-0.99*z^-1)*(1-5.1e-3*z^-1))'); %start up
% G1 = eval('((z^-1*(1.29 + 0.28 * z^-1)))/((1-0.99*z^-1)*(1-4.6e-3*z^-1))'); % idle
% G1 = eval('((z^-1*(1.68 + 0.1 * z^-1)))/((1-0.99*z^-1)*(1-4.3e-3*z^-1))'); % max
% 
% [a1,b1,c1,d1]=ssdata(G1);



for kk=1:NN,
% Calculate future Np inputs:

if  smax ~= 1
    if ceil(yref_signal(sidx,1)/T) == kk 
      [yref,xref,uref] = mpc_get_ref(Np,c,ny,nu,yref_signal(sidx,2));    
      if sidx < smax 
        sidx = sidx + 1;
      end
    end
end 
yreff = [ yreff; yref(1)];

u0 = repmat(u0,Np,1);
[u,exitflag]=mpc_calc(Ahat,Bhat,Qhat,Quhat,Hhat,x0,x00,u0,xref,uref,umin,umax,...
                      dumin,dumax,ymin,ymax,dymin,dymax);
if exitflag<0,disp('WARNING: infeasible QP problem'),pause(0.1),end;
% Implement present input:
x=a*x0+b*u(1:nu);
% Save states and input for plotting
U(:,kk)=u(1:nu);
u0 = u(1:nu);
X(kk,:)=x';
% save last state
x00=x0;
% New initial state for next sample
x0=x;
end

% prepare data to plot
t=0:T:NN*T;t_f=t(length(t));t=[-1 t];
y=[ zeros(ny,2)  c*X'];
U=[zeros(nu,1) U U(:,length(U))];
dU = zeros(nu,1);
for uu = 2: size(U,2)
    dU(:,uu) = U(:,uu)-U(:,uu-1);
end

%%%%%%%%%%%%%%%%% plot time history %%%%%%%%%%%%%%%%%%%%%%%%
% separate plot

figure;
for ii = 1:size(y,1)
    subplot(ny+2*nu,1,ii),
    % plot(t,y,[-1 0],[0 0],'r:',[0 0],[0 yreff(1)],'r:',[0 t_f],[yreff(1) yreff(1)],...
    %        'r:',[-1 t_f],[ymax ymax],'g--')
    plot(t,y(ii,:),[-1 t_f],[ymax ymax],'r--',[-1 t_f],[ymin ymin],'r--')
    hold on
    stairs(t,yreff, 'g:')
    hold off
    % show +-10 percent of y
    ytmp=y(ii,:);
    axis([-1 t_f min(ytmp)-0.1*abs(min(ytmp)) max(ytmp)+0.1*abs(max(ytmp))])
    ylabel(strcat('output y ',num2str(ii)))
end

% show +-10 percent of u
for ii = 1:size(U,1)
    subplot(ny+2*nu,1,ny+ii),
    plot([-1 t_f],[umax umax],'r--',[-1 t_f],[umin umin],'r--')
    Utmp=U(ii,:);
    hold on
    stairs(t,Utmp)
    hold off
    axis([-1 t_f min(Utmp)-0.1*abs(min(Utmp)) max(Utmp)+0.1*abs(max(Utmp))]) 
    ylabel(strcat('input u ',num2str(ii)))
end

for ii = 1:size(dU,1)
    subplot(ny+2*nu,1,ny+nu+ii),
    plot([-1 t_f],[dumax dumax],'r--',[-1 t_f],[dumin dumin],'r--')
    hold on

    dUtmp=dU(ii,:);
    stairs(t,dUtmp)
    % axis([-1 t_f dumin-0.2*abs(dumin) dumax+0.2*abs(dumax)])
    axis([-1 t_f min(dUtmp)-0.1*abs(min(dUtmp)) max(dUtmp)+0.1*abs(max(dUtmp))])
    ylabel(strcat('input du ',num2str(ii)))
end
hold off
xlabel('time [s]')

figure;
subplot(311),
% plot(t,y,[-1 0],[0 0],'r:',[0 0],[0 yreff(1)],'r:',[0 t_f],[yreff(1) yreff(1)],...
%        'r:',[-1 t_f],[ymax ymax],'g--')
plot(t,y,[-1 t_f],[ymax ymax],'r--',[-1 t_f],[ymin ymin],'r--')
hold on
stairs(t,yreff, 'g:')
hold off
ylabel('output y')
% show +-10 percent of y
for ii = 1:size(y,1)
    ytmp=y(ii,:);
    axis([-1 t_f min(ytmp)-0.1*abs(min(ytmp)) max(ytmp)+0.1*abs(max(ytmp))])
end


subplot(312)
plot([-1 t_f],[umax umax],'r--',[-1 t_f],[umin umin],'r--')
hold on
% show +-10 percent of u
for ii = 1:size(U,1)
    Utmp=U(ii,:);
    stairs(t,Utmp)
    axis([-1 t_f min(Utmp)-0.1*abs(min(Utmp)) max(Utmp)+0.1*abs(max(Utmp))]) 
end
hold off
ylabel('input u')


subplot(313);
plot([-1 t_f],[dumax dumax],'r--',[-1 t_f],[dumin dumin],'r--')
hold on
for ii = 1:size(dU,1)
    dUtmp=dU(ii,:);
    stairs(t,dUtmp)
    % axis([-1 t_f dumin-0.2*abs(dumin) dumax+0.2*abs(dumax)])
    axis([-1 t_f min(dUtmp)-0.1*abs(min(dUtmp)) max(dUtmp)+0.1*abs(max(dUtmp))])
end
hold off

ylabel('input du')
xlabel('time [s]')

%%%%% finish
disp('finished');

 