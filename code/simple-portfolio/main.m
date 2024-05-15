for p=2:3 %the moment order of the HMCR measure
    clearvars -except p
    sz=1000;%the number of original scenarios
    prob=ones(1,sz)/sz;
    alpha=0.8;
    redu=[150,250,350];
    asset_num=9;%the number of assets
    
    orisolution=zeros(20,9);oriobj=zeros(20,1);
    for i=1:20
        oriscenario=readtable(['samples_',num2str(i),'.csv']);
        oriscenario=table2array(oriscenario);
        [x,obj,~]=portfolio(oriscenario,prob',p,alpha);
        orisolution(i,:)=x';oriobj(i)=obj;
    end
    
    for j=1:3 %three different reduction levels
        erro=zeros(20,8);
        
        redsolution1=zeros(20,asset_num);redobj1=zeros(20,1);
        redsolution2=zeros(20,asset_num);redobj2=zeros(20,1);
        redsolution3=zeros(20,asset_num);redobj3=zeros(20,1);
        redsolution4=zeros(20,asset_num);redobj4=zeros(20,1);
        redsolution5=zeros(20,asset_num);redobj5=zeros(20,1);
        redsolution6=zeros(20,asset_num);redobj6=zeros(20,1);
        for i=1:20 %20 original scenario sets
            display(['the current iteration is j=',num2str(j),' i=',num2str(i),' p=',num2str(p)]);
            oriscenario=readtable(['samples_',num2str(i),'.csv']);
            oriscenario=table2array(oriscenario);
            x=orisolution(i,:);obj=oriobj(i);
            
            [scenario,pro]=hom(oriscenario,redu(j));
            [x1,obj1,~]=portfolio(scenario,pro,p,alpha);
            erro(i,7)=abs((obj1-obj)/obj);
            redsolution5(i,:)=x1;redobj5(i)=obj1;
            g=-oriscenario*x1;
            fun=@(x) x+1/(1-alpha)*(sum(max(g-x,0).^p.*prob'))^(1/p);
            eta=fminbnd(@(x) fun(x),-10,10);
            ind=g<eta;
            alpha1=1-(1-alpha)/(1-sum(prob(ind==1)))^(1/p);
            probb=prob(ind==0);probb=probb/(1-sum(prob(ind==1)));
            [x2,obj2,~]=portfolio(oriscenario(ind==0,:),probb',p,alpha1);
            erro(i,1)=abs((obj2-obj)/obj);
            redsolution1(i,:)=x2;redobj1(i)=obj2;
            [scenario,pro]=hom(oriscenario,sum(ind==0));
            [x1,obj1,~]=portfolio(scenario,pro,p,alpha);
            erro(i,2)=abs((obj1-obj)/obj);
            redsolution2(i,:)=x1;redobj2(i)=obj1;
            erro(i,3)=sum(ind==0);
            
            [scenario,pro]=recursive(oriscenario,redu(j),prob);
            [x1,obj1,~]=portfolio(scenario,pro',p,alpha);
            erro(i,8)=abs((obj1-obj)/obj);
            redsolution6(i,:)=x1;redobj6(i)=obj1;
            g=-oriscenario*x1;
            fun=@(x) x+1/(1-alpha)*(sum(max(g-x,0).^p.*prob'))^(1/p);
            eta=fminbnd(@(x) fun(x),-10,10);
            ind=g<eta;
            alpha1=1-(1-alpha)/(1-sum(prob(ind==1)))^(1/p);
            probb=prob(ind==0);probb=probb/(1-sum(prob(ind==1)));
            [x2,obj2,~]=portfolio(oriscenario(ind==0,:),probb',p,alpha1);
            erro(i,4)=abs((obj2-obj)/obj);
            redsolution3(i,:)=x2';redobj3(i)=obj2;
            erro(i,5)=sum(ind==0);
            [scenario,pro]=recursive(oriscenario,erro(i,5),prob);
            [x1,obj1,~]=portfolio(scenario,pro',p,alpha);
            erro(i,6)=abs((obj1-obj)/obj);
            redsolution4(i,:)=x1';redobj4(i)=obj1;
            
        end
        solution={orisolution,redsolution1,redsolution2,redsolution3,redsolution4,redsolution5,redsolution6};
        obj={oriobj,redobj1,redobj2,redobj3,redobj4,redobj5,redobj6};
        result={erro,solution,obj};
        save(['erro',num2str((p-2)*3+j),'.mat'],'result');
    end
end


