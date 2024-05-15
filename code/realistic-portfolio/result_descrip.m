%% the experimental results for IDE metric
for p=2:3
    erro=zeros(3,12);% The mean and standard deviation of IDE obtained by each method in 20 repeated experiments.
    frac=zeros(3,6); % Number of instances where each method has lowest IDE in 20 repeated experiments
    for ind=1:3
        %gap2=zeros(6,20);
        load(['erro-bin',num2str((p-2)*3+ind),'.mat']);
        solution=result{2};
        solution={solution{1},solution{2},solution{3},solution{6},solution{4},solution{5},solution{7}};
        gap=zeros(6,20);
        for i=1:6
            for j=1:20
                gap(i,j)=norm(solution{1}(j,:)-solution{i+1}(j,:));
            end
        end
        erro(ind,1:2:12)=mean(gap');erro(ind,2:2:12)=std(gap');
        
        frac1=zeros(6,20);
        for i=1:20
            idd=find(gap(1:3,i)==min(gap(1:3,i)));
            frac1(idd,i)=1;
            idd=find(gap(4:6,i)==min(gap(4:6,i)));
            frac1(3+idd,i)=1;
        end
        frac(ind,:)=sum(frac1,2);
    end
    erro=roundn(erro,-4);
    erro(:,2:2:12)=roundn(erro(:,2:2:12),-3);
    disp(erro)
    disp(frac)
end




%% the experimental results for OVE metric
for p=2:3
    stat=zeros(3,12);% The mean and standard deviation of OVE obtained by each method in 20 repeated experiments.
    frac=zeros(3,6); % Number of instances where each method has lowest OVE in 20 repeated experiments
    for ind=1:3
        load(['erro-bin',num2str((p-2)*3+ind),'.mat']);
        erro=result{1};
        erro1=erro(1:20,[1,2,7,4,6,8]);
        stat(ind,1:2:12)=mean(erro1);
        stat(ind,2:2:12)=std(erro1);
        frac1=zeros(20,6);
        for i=1:20
            idd=find(erro1(i,1:3)==min(erro1(i,1:3)));
            frac1(i,idd)=1;
            idd=find(erro1(i,4:6)==min(erro1(i,4:6)));
            frac1(i,3+idd)=1;
        end
        frac(ind,:)=sum(frac1);
    end
    stat=roundn(stat,-4);
    stat(:,2:2:12)=roundn(stat(:,2:2:12),-3);
    disp(stat)
    disp(frac)
end

%% The Cardinality of Reduced Scenario Sets
p=2;
num1=zeros(3,20);
num2=zeros(3,20);
for ind=1:3
    load(['erro-bin',num2str((p-2)*3+ind),'.mat']);
    erro=result{1};
    num1(ind,:)=erro(1:20,3)';
    num2(ind,:)=erro(1:20,5)';
end
p=3;
num3=zeros(3,20);
num4=zeros(3,20);
for ind=1:3
    load(['erro-bin',num2str((p-2)*3+ind),'.mat']);
    erro=result{1};
    num3(ind,:)=erro(1:20,3)';
    num4(ind,:)=erro(1:20,5)';
end
figure
plot(num1(1,:),'-ro','linewidth',1.5)
hold on
plot(num1(2,:),'-b*','linewidth',1.5)
plot(num1(3,:),'-kd','linewidth',1.5)
ylabel('Cardinality','fontsize',20);xlabel('Experiment','fontsize',20);
set(gca,'fontsize',20,'linewidth',2)
legend({'|J|=200','|J|=600','|J|=1000'})
title('p=2','fontweight','normal','fontsize',20)

figure
plot(num3(1,:),'-ro','linewidth',1.5)
hold on
plot(num3(2,:),'-b*','linewidth',1.5)
plot(num3(3,:),'-kd','linewidth',1.5)
ylabel('Cardinality','fontsize',20);xlabel('Experiment','fontsize',20);
set(gca,'fontsize',20,'linewidth',2)
legend({'|J|=200','|J|=600','|J|=1000'})
title('p=3','fontweight','normal','fontsize',20)

figure
plot(num2(1,:),'-ro','linewidth',1.5)
hold on
plot(num2(2,:),'-b*','linewidth',1.5)
plot(num2(3,:),'-kd','linewidth',1.5)
ylabel('Cardinality','fontsize',20);xlabel('Experiment','fontsize',20);
ylim([350 700])
set(gca,'fontsize',20,'linewidth',2)
legend({'|J|=200','|J|=600','|J|=1000'})
title('p=2','fontweight','normal','fontsize',20)

figure
plot(num4(1,:),'-ro','linewidth',1.5)
hold on
plot(num4(2,:),'-b*','linewidth',1.5)
plot(num4(3,:),'-kd','linewidth',1.5)
ylabel('Cardinality','fontsize',20);xlabel('Experiment','fontsize',20);
set(gca,'fontsize',20,'linewidth',2)
legend({'|J|=200','|J|=600','|J|=1000'})
title('p=3','fontweight','normal','fontsize',20)


%%  Herfindal index
for p=2:3
    herind=zeros(3,6);
    for ind=1:3
        her=zeros(6,20);
        load(['erro-bin',num2str((p-2)*3+ind),'.mat']);
        solution=result{2};
        solution={solution{2},solution{3},solution{6},solution{4},solution{5},solution{7}};
        for i=1:6
            her(i,:)=sum(solution{i}.^2,2);
        end
        herind(ind,:)=mean(her,2);
    end
    disp(herind)
end