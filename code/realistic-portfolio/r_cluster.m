%% the algorithm 2 in "Scenario tree reduction methods through clustering nodes" when r=2
function [reduced_scenario,reduced_pro]=r_cluster(shuju,N,pro)
scenario=shuju;
[n,m]=size(scenario);
epsilon=1e-6;
reduced_scenario=scenario(1:N,:);
reduced_pro=zeros(1,N);
cluster_node=cell(1,N);
distance=zeros(N,n);

obj=zeros(1,10000);iid=1;
for i=1:n
    distance(:,i)=sum((reduced_scenario-repmat(scenario(i,:),N,1)).^2,2);
    [md,id]=min(distance(:,i));id=id(1);
    cluster_node{id}=[cluster_node{id},i];
end

[cluster_node,obj_value,reduced_pro]=objcalculate(pro,cluster_node,distance,reduced_pro,N);
obj(iid)=obj_value;iid=iid+1;
while true
    for i=1:N
        reduced_scenario(i,:)=pro(cluster_node{i})*scenario(cluster_node{i},:)/sum(pro(cluster_node{i}));
    end
    
    cluster_node=cell(1,N);
    for i=1:n
        distance(:,i)=sum((reduced_scenario-repmat(scenario(i,:),N,1)).^2,2);
        [md,id]=min(distance(:,i));id=id(1);
        cluster_node{id}=[cluster_node{id},i];
    end
    
    [cluster_node,obj_value1,reduced_pro]=objcalculate(pro,cluster_node,distance,reduced_pro,N);
    obj(iid)=obj_value1;iid=iid+1;
    if abs(obj_value1-obj_value)<epsilon
        break
    else
        obj_value=obj_value1;
    end
end