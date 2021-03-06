function aa_ab4_GLM_ALL

load('ChaoyueData.mat')


Stain{1,2}='MND12';
Stain{1,3}=1;
Stain{2,2}='MND13';
Stain{2,3}=1;
Stain{3,2}='MND14';
Stain{3,3}=1;
Stain{4,2}='MND15';
Stain{4,3}=1;
Stain{5,2}='MND16';
Stain{5,3}=1;
Stain{6,2}='MND17';
Stain{6,3}=1;
Stain{7,2}='MND18';
Stain{7,3}=0;
Stain{8,2}='MND19';
Stain{8,3}=1;
Stain{9,2}='MND20';
Stain{9,3}=1;
Stain{10,2}='MND21';
Stain{10,3}=0;
Stain{11,2}='MND22';
Stain{11,3}=1;
Stain{12,2}='MND23';
Stain{12,3}=0;
Stain{13,2}='MND24';
Stain{13,3}=0;
Stain{14,2}='CTL10';
Stain{14,3}=0;
Stain{15,2}='CTL11';
Stain{15,3}=0;
Stain{16,2}='CTL12';
Stain{16,3}=0;
data=table2array(Data);
M{1}='EPG-T2';
M{2}='EPG-T2-despike';
M{3}='KI--NoHole-corrected-T2';
M{4}='KI-WithHole-corrected-T2';
M{5}='KT-WithHole-corrected-T2';
for ii=1:16
    if Stain{ii,3}==1
        del=14.50;
    else
        del=0;
    end
    try 
       load(strcat('FinalBar_',Stain{ii,2},'.mat')) ;
       mdl{1}(ii,1:11)=tab(1,:);
       mdl{2}(ii,1:11)=tab(2,:);
       mdl{3}(ii,1:11)=tab(3,:);
       mdl{4}(ii,1:11)=tab(4,:);
       mdl{5}(ii,1:11)=tab(5,:)+del;
    catch
       mdl{1}(ii,1:11)=NaN;
       mdl{2}(ii,1:11)=NaN;
       mdl{3}(ii,1:11)=NaN;
       mdl{4}(ii,1:11)=NaN;
       mdl{5}(ii,1:11)=NaN; 
    end
    
end


%GLM analysis
close all
mdl_ind=5
T2=mdl{mdl_ind};
ind=[1:10,12:16];


AccT2=T2(:,8);AccT2=AccT2(ind);
LegT2=T2(:,5);LegT2=LegT2(ind);
V2T2=T2(:,10);V2T2=V2T2(ind);
t2=[AccT2;LegT2;V2T2];

AccFerr=data(2:17,4);AccFerr=AccFerr(ind);
LegFerr=data(2:17,5);LegFerr=LegFerr(ind);
V2Ferr=data(2:17,6);V2Ferr=V2Ferr(ind);
Ferr=[AccFerr;LegFerr;V2Ferr];


LegPLP=data(2:17,37);LegPLP=LegPLP(ind);
V2PLP=data(2:17,39);V2PLP=V2PLP(ind);
AccPLP=[0.27;0.22;0.18;0.23;0.26;0.18;0.09;0.17;0.25;0.16;0.14;0.7;0.14;0.14;0.20;0.15]
AccPLP=AccPLP(ind)
PLP=[AccPLP;LegPLP;V2PLP];


LegpTDP=data(2:17,21);LegpTDP=LegpTDP(ind);
V2pTDP=data(2:17,23);V2pTDP=V2pTDP(ind);
pTDP=[LegpTDP;V2pTDP];

 

%only leg

X=[LegPLP,LegFerr]
y=LegT2
[b,dev,stats] = glmfit(X,y)
yfit = glmval(b,X,'identity')

Tbl1=[stats.beta,stats.se,stats.t,stats.p]
T = array2table(Tbl1,...
'VariableNames',{'beta','SE','t','p'},...
'RowNames',{'const','PLP','Fe'})


%only V2

X=[V2PLP,V2Ferr]
y=V2T2
[b,dev,stats] = glmfit(X,y)
yfit = glmval(b,X,'identity')

Tbl1=[stats.beta,stats.se,stats.t,stats.p]
T = array2table(Tbl1,...
'VariableNames',{'beta','SE','t','p'},...
'RowNames',{'const','PLP','Fe'})

%only Acc

X=[AccPLP,AccFerr]
y=AccT2
[b,dev,stats] = glmfit(X,y)
yfit = glmval(b,X,'identity')

Tbl1=[stats.beta,stats.se,stats.t,stats.p]
T = array2table(Tbl1,...
'VariableNames',{'beta','SE','t','p'},...
'RowNames',{'const','PLP','Fe'})

%leg V2
X1=[LegPLP;V2PLP;AccPLP]
X2=[LegFerr;V2Ferr;AccFerr]
X=[X1,X2]
y=[LegT2;V2T2;AccT2]
[b,dev,stats] = glmfit(X,y)
yfit = glmval(b,X,'identity')

Tbl1=[stats.beta,stats.se,stats.t,stats.p]
T = array2table(Tbl1,...
'VariableNames',{'beta','SE','t','p'},...
'RowNames',{'const','PLP','Fe'})

aa=1