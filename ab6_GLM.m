
function ab6_GLM
%AnteriorCing,MotorLeg,V2,AC_normalised,MotorLegNormalised
%Acc 3n-2, mtr 3n-1, v2 3n
%first row: Anterior cingulate ;	Motor cortex - Leg area;	Secondary Visual cortex (V2)
%second row:Anterior cingulate ;	Motor cortex - Facial area	;Secondary Visual cortex (V2)
%third  row PLP: Motor cortex - face area	;  	Motor cortex - leg area	;   Secondary Visual cortex (V2)
%fourth row pTDP43: Motor cortex - face area	 ;	Motor cortex - Leg area	;Secondary Visual cortex (V2)
StainData=[0.529	0.728	0.701	0.732	0.804	0.856	0.283	0.580	0.636	0.388	0.699	0.558	0.450	0.710	0.550	0.376	0.556	0.530	0.369	0.715	0.709	0.328	0.504	0.667	0.296	0.841	0.489	0.529	0.692	0.438	0.671	0.761	0.665	0.309	0.514	0.731	0.316	0.511	0.305	0.545	0.538	0.522	0.191	0.446	0.436	0.706	0.631	0.491
0.024	0.090	0.121	0.027	0.634	0.416	0.021	0.031	0.145	0.042	0.085	0.074	0.033	0.049	0.205	0.019	0.060	0.101	0.013	0.059	0.070	0.011	0.045	0.111	0.022	0.059	0.067	0.017	0.059	0.101	0.014	0.039	0.050	0.018	0.104	0.050	0.016	0.063	0.045	0.015	0.054	0.117	0.024	0.045	0.028	0.030	0.061	0.038
0.579	0.598	0.578	0.611	0.652	0.476	0.591	0.570	0.482	0.548	0.455	0.563	0.424	0.544	0.631	0.436	0.523	0.531	0.332	0.374	0.337	0.364	0.432	0.480	0.559	0.501	0.493	0.332	0.426	0.586	0.299	0.392	0.537	0.269	0.594	0.481	0.145	0.567	0.507	0.515	0.336	0.496	0.303	0.375	0.499	0.483	0.252	0.496
0.001008	0.000410	0.000100	0.000256	0.000198	0.000131	0.000102	0.000048	0.000080	0.000481	0.001591	0.000211	0.000497	0.000807	0.000216	0.013775	0.004635	0.000119	0.001327	0.001849	0.000084	0.000667	0.000956	0.000017	0.001055	0.001786	0.000174	0.002466	0.001666	0.000098	0.004921	0.001479	0.000145	0.001332	0.000664	0.000026	0.001199	0.000429	0.000042	0.000243	0.000739	0.000016	0.000333	0.000059	0.000009	0.000199	0.000190	0.000048
];
%0.400%0.024	0.090	0.121	0.027	0.634	0.416	0.021	0.031	0.145	0.042	0.085	0.074	0.033	0.049	0.205	0.019	0.400	0.101	0.013	0.059	0.070	0.011	0.045	0.111	0.022	0.059	0.067	0.017	0.059	0.101	0.014	0.039	0.050	0.018	0.104	0.050	0.016	0.063	0.045	0.015	0.054	0.117	0.024	0.045	0.028	0.030	0.061	0.038
%0.06%0.024	0.090	0.121	0.027	0.634	0.416	0.021	0.031	0.145	0.042	0.085	0.074	0.033	0.049	0.205	0.019	0.060	0.101	0.013	0.059	0.070	0.011	0.045	0.111	0.022	0.059	0.067	0.017	0.059	0.101	0.014	0.039	0.050	0.018	0.104	0.050	0.016	0.063	0.045	0.015	0.054	0.117	0.024	0.045	0.028	0.030	0.061	0.038

Stain{1,2}='MND12';
Stain{1,3}=NaN;
Stain{2,2}='MND13';
Stain{2,3}=NaN;
Stain{3,2}='MND14';
Stain{3,3}=NaN;
Stain{4,2}='MND15';
Stain{4,3}=NaN;
Stain{5,2}='MND16';
Stain{5,3}=NaN;
Stain{6,2}='MND17';
Stain{6,3}='MND17_ACC_FinalBar.mat';
Stain{7,2}='MND18';
Stain{7,3}='MND18_ACC_FinalBar.mat';
Stain{8,2}='MND19';
Stain{8,3}='MND19_ACC_FinalBar.mat';
Stain{9,2}='MND20';
Stain{9,3}='MND20_ACC_FinalBar.mat';
Stain{10,2}='MND21';
Stain{10,3}='MND21_ACC_FinalBar.mat';
Stain{11,2}='MND22';
Stain{11,3}=NaN;
Stain{12,2}='MND23';
Stain{12,3}='MND23_ACC_FinalBar.mat';
Stain{13,2}='MND24';
Stain{13,3}='MND24_ACC_FinalBar.mat';
Stain{14,2}='CTL10';
Stain{14,3}='CTL10_ACC_FinalBar.mat';
Stain{15,2}='CTL11';
Stain{15,3}='CTL11_ACC_FinalBar.mat';
Stain{16,2}='CTL12';
Stain{16,3}='CTL12_ACC_FinalBar.mat';


mdl{1}='EPG-T2';
mdl{2}='EPG-T2-despike';
mdl{3}='KI--NoHole-corrected-T2';
mdl{4}='KI-WithHole-corrected-T2';
mdl{5}='KT-WithHole-corrected-T2';

% tab  'Face_L	Face_R	Hand_L	Hand_R	Leg_L	Leg_R	Motor'
%EPG1
% EPG2
% KI1
% KI2
% KT






close all
for mdl_ind=1:5
        kk=1
    for mnd=1:16
        try
            
            load(strcat(Stain{mnd,2},'_FinalBar.mat'))
            T2_Mtr(kk)=mean(tab(mdl_ind,7) ) ;
            T2_Leg(kk)=mean(tab(mdl_ind,5) ) ;
            T2_Fc(kk) =mean(tab(mdl_ind,1) ) ;
            Fe_Leg(kk)=StainData(1,3*mnd-1);%1st: Acc 3n-2, leg  3n-1, v2 3n
            Fe_Fc(kk) =StainData(2,3*mnd-1);%2nd: Acc 3n-2, face 3n-1, v2 3n
            PLP_Leg(kk)=StainData(3,3*mnd-1);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_Leg(kk)=StainData(4,3*mnd-1);%4th: 0 3n-2, leg 3n-1, v2 3n
            PLP_Fc(kk)=StainData(3,3*mnd-2);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_Fc(kk)=StainData(4,3*mnd-2);%4th: 0 3n-2, leg 3n-1, v2 3n
            
            load(strcat(Stain{mnd,2},'_ACC_FinalBar.mat'))
            T2_ACC(kk)=mean(tab(mdl_ind,3) ) ;%3 indicate left and right ACC
            Fe_ACC1(kk)=StainData(1,3*mnd-2);%Acc 3n-2, mtr 3n-1, v2 3n
            Fe_ACC2(kk)=StainData(2,3*mnd-2);
            
            load(strcat(Stain{mnd,2},'_V2_FinalBar.mat'))
            T2_V2(kk)=mean(tab(mdl_ind,3) ) ;
            Fe_V21(kk)=StainData(1,3*mnd);%Acc 3n-2, mtr 3n-1, v2 3n
            Fe_V22(kk)=StainData(2,3*mnd);
            PLP_V2(kk)=StainData(3,3*mnd);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_V2(kk)=StainData(4,3*mnd);%4th: 0 3n-2, leg 3n-1, v2 3n
            
            kk=kk+1
        catch
          
        end
    end

    figure
    hold on
    scatter([T2_Leg]',[PLP_Leg]','w')
    lsline
    
    scatter(T2_Leg,PLP_Leg,'ko')
    scatter(T2_Leg(end-2:end),PLP_Leg(end-2:end),'ro')
    

    
    [R,PValue] = corr([T2_Leg]',[PLP_Leg]')
    title(strcat(mdl{mdl_ind},'(R=',num2str(R),';P=',num2str(PValue),')'))
    saveas(gcf,strcat('FinalScatter-PLP_leg',mdl{mdl_ind},'.jpg'))
  
    
end


%GLM analysis
close all
for mdl_ind=1:5
    kk=1
    for mnd=1:16
        try
            
            load(strcat(Stain{mnd,2},'_FinalBar.mat'))
            T2_Mtr(kk)=mean(tab(mdl_ind,7) ) ;
            T2_Leg(kk)=mean(tab(mdl_ind,5) ) ;
            T2_Fc(kk) =mean(tab(mdl_ind,1) ) ;
            Fe_Leg(kk)=StainData(1,3*mnd-1);%1st: Acc 3n-2, leg  3n-1, v2 3n
            Fe_Fc(kk) =StainData(2,3*mnd-1);%2nd: Acc 3n-2, face 3n-1, v2 3n
            PLP_Leg(kk)=StainData(3,3*mnd-1);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_Leg(kk)=StainData(4,3*mnd-1);%4th: 0 3n-2, leg 3n-1, v2 3n
            PLP_Fc(kk)=StainData(3,3*mnd-2);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_Fc(kk)=StainData(4,3*mnd-2);%4th: 0 3n-2, leg 3n-1, v2 3n
            
            load(strcat(Stain{mnd,2},'_ACC_FinalBar.mat'))
            T2_ACC(kk)=mean(tab(mdl_ind,3) ) ;%3 indicate left and right ACC
            Fe_ACC1(kk)=StainData(1,3*mnd-2);%Acc 3n-2, mtr 3n-1, v2 3n
            Fe_ACC2(kk)=StainData(2,3*mnd-2);
            
            load(strcat(Stain{mnd,2},'_V2_FinalBar.mat'))
            T2_V2(kk)=mean(tab(mdl_ind,3) ) ;
            Fe_V21(kk)=StainData(1,3*mnd);%Acc 3n-2, mtr 3n-1, v2 3n
            Fe_V22(kk)=StainData(2,3*mnd);
            PLP_V2(kk)=StainData(3,3*mnd);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_V2(kk)=StainData(4,3*mnd);%4th: 0 3n-2, leg 3n-1, v2 3n
            
            kk=kk+1
        catch
          
        end
    end
%only leg
    figure
    hold on
    X=[PLP_Leg;Fe_Leg]'
    y=T2_Leg'
    [b,dev,stats] = glmfit(X,y)
    yfit = glmval(b,X,'identity')
    scatter3(X(:,1), X(:,2),y,'o')
    scatter3(X(:,1), X(:,2),yfit,'*')
    
    Tbl1=[stats.beta,stats.se,stats.t,stats.p]
    T = array2table(Tbl1,...
    'VariableNames',{'beta','SE','t','p'},...
    'RowNames',{'const','PLP','Fe'})

    
%only Face
    figure
    hold on
    X=[PLP_Fc;Fe_Fc]'
    y=T2_Fc'
    [b,dev,stats] = glmfit(X,y)
    yfit = glmval(b,X,'identity')
    scatter3(X(:,1), X(:,2),y,'o')
    scatter3(X(:,1), X(:,2),yfit,'*')
    
    Tbl1=[stats.beta,stats.se,stats.t,stats.p]
    T = array2table(Tbl1,...
    'VariableNames',{'beta','SE','t','p'},...
    'RowNames',{'const','PLP','Fe'})
%add LegFc indicator
    figure
    hold on
    X=[PLP_Leg',PLP_Fc',Fe_Leg'*0+1;Fe_Leg',Fe_Fc',Fe_Fc'*0]
    y=[T2_Leg';T2_Fc']
    [b,dev,stats] = glmfit(X,y)
    yfit = glmval(b,X,'identity')
    scatter3(X(:,1), X(:,2),y,'o')
    scatter3(X(:,1), X(:,2),yfit,'*')
    
    Tbl1=[stats.beta,stats.se,stats.t,stats.p]
    T = array2table(Tbl1,...
    'VariableNames',{'beta','SE','t','p'},...
    'RowNames',{'const','PLP','Fe','LegFc'})
end

%%%%%%%%%%%GLM analysis ; add CTL/ALS
close all
for mdl_ind=1:5
    kk=1
    for mnd=1:16
        try
            
            load(strcat(Stain{mnd,2},'_FinalBar.mat'))
            T2_Mtr(kk)=mean(tab(mdl_ind,7) ) ;
            T2_Leg(kk)=mean(tab(mdl_ind,5) ) ;
            T2_Fc(kk) =mean(tab(mdl_ind,1) ) ;
            Fe_Leg(kk)=StainData(1,3*mnd-1);%1st: Acc 3n-2, leg  3n-1, v2 3n
            Fe_Fc(kk) =StainData(2,3*mnd-1);%2nd: Acc 3n-2, face 3n-1, v2 3n
            PLP_Leg(kk)=StainData(3,3*mnd-1);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_Leg(kk)=StainData(4,3*mnd-1);%4th: 0 3n-2, leg 3n-1, v2 3n
            PLP_Fc(kk)=StainData(3,3*mnd-2);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_Fc(kk)=StainData(4,3*mnd-2);%4th: 0 3n-2, leg 3n-1, v2 3n
            
            load(strcat(Stain{mnd,2},'_ACC_FinalBar.mat'))
            T2_ACC(kk)=mean(tab(mdl_ind,3) ) ;%3 indicate left and right ACC
            Fe_ACC1(kk)=StainData(1,3*mnd-2);%Acc 3n-2, mtr 3n-1, v2 3n
            Fe_ACC2(kk)=StainData(2,3*mnd-2);
            
            load(strcat(Stain{mnd,2},'_V2_FinalBar.mat'))
            T2_V2(kk)=mean(tab(mdl_ind,3) ) ;
            Fe_V21(kk)=StainData(1,3*mnd);%Acc 3n-2, mtr 3n-1, v2 3n
            Fe_V22(kk)=StainData(2,3*mnd);
            PLP_V2(kk)=StainData(3,3*mnd);%3th: 0 3n-2, leg 3n-1, v2 3n
            pTDP_V2(kk)=StainData(4,3*mnd);%4th: 0 3n-2, leg 3n-1, v2 3n
            
            kk=kk+1
        catch
          
        end
    end


    ALS=[1,1,1,1,1,1,1,0,0,0]
    X=[PLP_Leg',Fe_Leg',ALS']
    y=T2_Leg'
    [b,dev,stats] = glmfit(X,y)
    
    Tbl1=[stats.beta,stats.se,stats.t,stats.p]
    T = array2table(Tbl1,...
    'VariableNames',{'beta','SE','t','p'},...
    'RowNames',{'const','PLP','Fe','ALS/CTL'})

    

    
    X=[PLP_Fc',Fe_Fc',ALS']
    y=T2_Fc'
    [b,dev,stats] = glmfit(X,y)
    
    Tbl1=[stats.beta,stats.se,stats.t,stats.p]
    T = array2table(Tbl1,...
    'VariableNames',{'beta','SE','t','p'},...
    'RowNames',{'const','PLP','Fe','ALS/CTL'})


    X=[PLP_Leg',PLP_Fc',ALS',Fe_Leg'*0+1;Fe_Leg',Fe_Fc',ALS',Fe_Fc'*0]
    y=[T2_Leg';T2_Fc']
    [b,dev,stats] = glmfit(X,y)
    Tbl1=[stats.beta,stats.se,stats.t,stats.p]
    T = array2table(Tbl1,...
    'VariableNames',{'beta','SE','t','p'},...
    'RowNames',{'const','PLP','Fe','ALS/CTL','LegFc'})
end

    

    