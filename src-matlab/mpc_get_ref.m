function [oyref,oxref,ouref]=mpc_get_ref(xNp,xc,ny,nu,xrefSig)
    oyref=zeros(xNp,ny);
    for i=1:ny % prejdeme vsetky zlozky y (ak viacero vystupov)
        val=0; %default hodnota
        idx=1; % vynulujeme index
        for j=1:xNp % prejdeme vsetky kroky v horizonte predikcie
            try  
                if idx<=length(xrefSig{i}) && xrefSig{i}{idx}.tRef == j-1
                    val= xrefSig{i}{idx}.yRef;
                    idx=idx+1;
                end
            catch
                disp('zly ref. signal')
            end
            oyref(j,i)= val;
        end
    end
    %oyref=xstep*ones(xNp,ny);     % Reference for 0<i<Np-1
    % References for outputs, states and inputs:
    oxref=pinv(xc)*oyref(1,:)';  % Translate into state reference:
    for i=2:length(oyref),
        oxref=[oxref;pinv(xc)*oyref(i,:)'];
    end
    ouref=zeros(xNp*nu,1);   