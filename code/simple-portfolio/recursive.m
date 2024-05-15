function [scenario,pro]=recursive(shuju,N,pro)
%% the algorithm 1 in "Scenario tree reduction methods through clustering nodes" when r=2
tic
scenario=shuju;
n=size(scenario,1);

N1=n;
cluster=cell(1,n);
for i=1:n
    cluster{i}=i;
end

while N1>N
    min_value=100000;  %An arbitrarily chosen and sufficiently large number
    min_j=1;min_k=1;
    for j=1:N1-1
        pro1=pro(j)*pro(j+1:N1)./(pro(j)+pro(j+1:N1));
        scen=sum((repmat(scenario(j,:),N1-j,1)-scenario(j+1:N1,:)).^2,2);
        minvalue=pro1'.*scen;minvalue1=min(minvalue);
        if minvalue1<min_value
            min_value=minvalue1;
            min_j=j;min_k=j+find(minvalue==minvalue1);
        end
        
    end
    scenario(min_j,:)=(pro(min_j)*scenario(min_j,:)+pro(min_k)*scenario(min_k,:))/(pro(min_j)+pro(min_k));
    scenario(min_k,:)=[];
    pro(min_j)=pro(min_j)+pro(min_k);pro(min_k)=[];
    N1=size(scenario,1);
end
toc
