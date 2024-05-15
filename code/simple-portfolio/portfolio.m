function [x,obj,eta]=portfolio(scenario,prob,p,alpha)
[nx,ny]=size(scenario);np=length(prob);
%mu=prob'*scenario;
%tau=mean(mu);
if nx~=np
    error('the number of scenarios is not equal to the number of probability')
end
y=sdpvar(nx,1);
x=sdpvar(ny,1);
eta=sdpvar(1,1);
if  p==2
    z=sdpvar(1,1);
    con_opt=[y>=0];
    con_opt=[con_opt,x>=0];
    con_opt=[con_opt,sum(x)==1];
    %con_opt=[con_opt,mu*x>=tau];
    con_opt=[con_opt,y>=(-scenario*x-eta).*sqrt(prob)];
    con_opt=[con_opt,z>=norm(y,2)];
    obj=eta+1/(1-alpha)*z;
    options_sub = sdpsettings('verbose',0,'solver','cplex');
    sol=optimize(con_opt,obj,options_sub);
    sol.problem
    if sol.problem==0
        x=value(x);
        obj=value(obj);
    else
        error('the portfolio model has no optimal solution')
    end
elseif p==3
    z=sdpvar(1,1);
    con_opt=y>=0;
    con_opt=[con_opt,x>=0];
    con_opt=[con_opt,sum(x)==1];
    %con_opt=[con_opt,mu*x>=tau];
    con_opt=[con_opt,y>=(-scenario*x-eta).*(prob.^(1/3))];
    u=sdpvar(nx,1);
    v=sdpvar(nx,1);
    con_opt=[con_opt,u>=0];
    con_opt=[con_opt,v>=0];
    con_opt=[con_opt,z>=8*sum(u)];
    for i=1:nx
        con_opt=[con_opt,rcone(y(i),z,v(i))];
        con_opt=[con_opt,rcone(v(i),y(i),u(i))];
    end
    obj=eta+1/(1-alpha)*z;
    options_sub = sdpsettings('verbose',0,'solver','mosek');
    sol=optimize(con_opt,obj,options_sub);
    if sol.problem==0
        x=value(x);
        obj=value(obj);
    else
        error('the portfolio model has no optimal solution')
    end
end
