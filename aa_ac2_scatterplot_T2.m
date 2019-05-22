function aa_ac2_scatterplot_T2

%1=10%formalin
%0=10%NBF
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

NM{1}='T2-hasSpike';
NM{2}='T2-NoSpike';
NM{3}='KI-NoHole';
NM{4}='KI-withHole';
NM{5}='KT-withHole';

%kk T2 T2_nospk KI KIhole KThole
%tot,GM,WM
nn=0;ff=0;
kk=5
figure
hold on
for ii=1:16
    ii
    try
        load(strcat('T2_mean_std_',Stain{ii,2},'.mat'))
        if  Stain{ii,3}==0
            ploterr(mn(3,kk),mn(2,kk),sd(3,kk),sd(2,kk),'b') 
            nn=nn+1;
            nbf(nn)=mn(1,kk);
        else
            ploterr(mn(3,kk),mn(2,kk),sd(3,kk),sd(2,kk),'r')
            ff=ff+1;
            fml(ff)=mn(1,kk);
        end

    catch eee
    end
end
title(strcat(NM{kk}))
    



y=[fml,nbf]'
X=[fml*0,nbf*0+1]'
[b,dev,stats] = glmfit(X,y)
yfit = glmval(b,X,'identity')

del=mean(yfit(9:end))-mean(yfit(1:8)); 

figure
hold on
for ii=1:16
    ii
    try
        load(strcat('T2_mean_std_',Stain{ii,2},'.mat'))
        if  Stain{ii,3}==0
            ploterr(mn(3,kk),mn(2,kk),sd(3,kk),sd(2,kk),'b') 
        else
            ploterr(mn(3,kk)+del,mn(2,kk)+del,sd(3,kk),sd(2,kk),'r')
        end

    catch eee
    end
end
title(strcat(NM{kk}))
    

