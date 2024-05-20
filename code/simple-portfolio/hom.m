function [scenario,pro]=hom(shuju,N)

scenario=shuju;
[n1,m]=size(scenario);
one_moment=mean(scenario);
two_moment=cov(scenario)*(n1-1)/n1;   
three_moment=skewness(scenario).*((sqrt(diag(two_moment))).^3)';
four_moment=kurtosis(scenario).*((sqrt(diag(two_moment))).^4)';

prob=ones(1,1000)/1000;
[scenario,~]=recursive(scenario,N,prob);
[n,m]=size(scenario);

A=zeros(3*m+(1+m)*m/2+1,n+4*m+(1+m)*m);B=ones(3*m+(1+m)*m/2+1,1);
A(1:m,1:n)=scenario'./repmat(one_moment',1,n);
i1=0;
for ii=1:m
    for j=ii:m
        i1=i1+1;
        A(m+i1,1:n)=((scenario(:,ii)'-one_moment(ii)).*(scenario(:,j)'-one_moment(j)))/two_moment(ii,j);
        A(m+i1,n+i1)=1;A(m+i1,n+m*(m+1)/2+i1)=-1;
    end
end
A(m+m*(m+1)/2+(1:m),(1:n))=((scenario'-repmat(one_moment',1,n)).^3)./repmat(three_moment',1,n);
A(m+m*(m+1)/2+(1:m),n+m*(1+m)+(1:m))=diag(ones(1,m));A(m+m*(m+1)/2+(1:m),n+m*(1+m)+m+(1:m))=-diag(ones(1,m));
A(2*m+m*(m+1)/2+(1:m),1:n)=((scenario'-repmat(one_moment',1,n)).^4)./repmat(four_moment',1,n);
A(2*m+m*(m+1)/2+(1:m),n+m*(1+m)+2*m+(1:m))=diag(ones(1,m));A(2*m+m*(m+1)/2+(1:m),n+m*(1+m)+3*m+(1:m))=-diag(ones(1,m));
A(3*m+(1+m)*m/2+1,1:n)=ones(1,n);

lambda1=1;lambda2=1;lambda3=1;
f=zeros(1,n+4*m+(1+m)*m);%f(n+(1:2*m))=1;
f(n+(1:(1+m)*m))=lambda1*2/((1+m)*m);f(n+(1+m)*m+(1:2*m))=lambda2*1/m;f(n+(1+m)*m+2*m+(1:2*m))=lambda3*1/m;
f(n+(1:(1+m)*m))=lambda1;f(n+(1+m)*m+(1:2*m))=lambda2;f(n+(1+m)*m+2*m+(1:2*m))=lambda3;


x=sdpvar(n+4*m+(1+m)*m,1);
con_opt=[x>=0];
con_opt=[con_opt,A*x==B];
obj=f*x;
options_sub = sdpsettings('verbose',1,'solver','cplex');
sol = optimize(con_opt,obj,options_sub);
if sol.problem==0
    x=value(x);
    pro=x(1:n);
else
    error('the hom method is wrong')
end