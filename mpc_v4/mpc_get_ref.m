function [oyref,oxref,ouref]=mpc_get_ref(xNp,xc,ny,nu,xstep)
    % References for outputs, states and inputs:
    oyref=xstep*ones(xNp,ny);     % Reference for 0<i<Np-1
    oxref=pinv(xc)*oyref(1,:)';  % Translate into state reference:
    for i=2:length(oyref),
        oxref=[oxref;pinv(xc)*oyref(i,:)'];
    end
    ouref=zeros(xNp*nu,1);   