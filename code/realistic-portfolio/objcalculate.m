function [cluster_node,obj_value,reduced_pro]=objcalculate(pro,cluster_node,distance,reduced_pro,N)
obj_value=0;
for i=1:N
    ifnull=0;
    if length(cluster_node{i})==0
        ifnull=1;
        for iter=i:N
            lenclu=length(cluster_node{iter});
            if lenclu>1
               aa=floor(lenclu/2);
               cluster_node{i}=cluster_node{iter}(1:aa);
               cluster_node{iter}=cluster_node{iter}((aa+1):lenclu);
               ifnull=0;
               break
            end
        end
        if ifnull==1
            for iter=1:i
                lenclu=length(cluster_node{iter});
                if lenclu>1
                    aa=floor(lenclu/2);
                    orcluster=cluster_node{iter};
                    cluster_node{i}=cluster_node{iter}(1:aa);
                    cluster_node{iter}=cluster_node{iter}((aa+1):lenclu);
                end
            end
        end
    end
    if ifnull==0
        obj_value=obj_value+pro(cluster_node{i})*distance(i,cluster_node{i})';
        reduced_pro(i)=sum(pro(cluster_node{i}));
    else
        obj_value=obj_value-pro(orcluster)*distance(i,orcluster)';
        obj_value=obj_value+pro(cluster_node{i})*distance(i,cluster_node{i})'+pro(cluster_node{iter})*distance(i,cluster_node{iter})';
        reduced_pro(i)=sum(pro(cluster_node{i}));
        reduced_pro(iter)=sum(pro(cluster_node{iter}));
    end
end
