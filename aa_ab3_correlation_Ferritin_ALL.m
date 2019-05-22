function aa_ab3_correlation_Ferritin_ALL
%AnteriorCing,MotorLeg,V2,AC_normalised,MotorLegNormalised
%Acc 3n-2, mtr 3n-1, v2 3n
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


%left leg  T2_VS_ferritinI
close all
for mdl_ind=1:4:5

    %'1=fcL 2=R 3=hdL 4=R 5=lgL 6=R 7=mtr 8=AccL 9=AccR 10=V2L 11=V2R 
    T2=mdl{mdl_ind};
    figure
    PalegT2=T2(:,5);
    PalegFerr=data(2:17,5);
    scatter(PalegT2,PalegFerr,'k')
    lsline
    hold on
    scatter(PalegT2(end-2:end),PalegFerr(end-2:end),'r')
    

    [R,PValue] = corr(PalegT2([1:10,12:end]),PalegFerr([1:10,12:end]));
    xlabel('T2(ms) of left leg')
    ylabel('FerritinFrac of left leg')
    title(strcat(M{mdl_ind},'(R=',num2str(R),';P=',num2str(PValue),')'))
    saveas(gcf,strcat('FinalScatter-LeftLeg-',M{mdl_ind},'.jpg'))
end


%left face  T2_VS_ferritinII

for mdl_ind=1:4:5

    %'1=fcL 2=R 3=hdL 4=R 5=lgL 6=R 7=mtr 8=AccL 9=AccR 10=V2L 11=V2R 
    T2=mdl{mdl_ind};
    figure
    PalegT2=T2(:,1);
    PalegFerr=data(2:17,11);
    scatter(PalegT2,PalegFerr,'k')
    lsline
    hold on
    scatter(PalegT2(end-2:end),PalegFerr(end-2:end),'r')
    

    [R,PValue] = corr(PalegT2([1:10,12:end]),PalegFerr([1:10,12:end]));
    xlabel('T2(ms) of leftFace')
    ylabel('FerritinFrac of leftFace')
    title(strcat(M{mdl_ind},'(R=',num2str(R),';P=',num2str(PValue),')'))
    saveas(gcf,strcat('FinalScatter-LeftFace-Outlier-',M{mdl_ind},'.jpg'))
end

%left leg  T2_VS_ferritinI remove outlier

for mdl_ind=1:4:5

    %'1=fcL 2=R 3=hdL 4=R 5=lgL 6=R 7=mtr 8=AccL 9=AccR 10=V2L 11=V2R 
    T2=mdl{mdl_ind};
    figure
    ind=[1,3:5,7:10,12:16];
    PalegT2=T2(:,1);
    PalegFerr=data(2:17,11);
    scatter(PalegT2(ind),PalegFerr(ind),'k')
    lsline
    hold on
    scatter(PalegT2(end-2:end),PalegFerr(end-2:end),'r')
    

    [R,PValue] = corr(PalegT2(ind),PalegFerr(ind));
    xlabel('T2(ms) of leftFace')
    ylabel('FerritinFrac of leftFace')
    title(strcat(M{mdl_ind},'(R=',num2str(R),';P=',num2str(PValue),')'))
    saveas(gcf,strcat('FinalScatter-LeftFace-nooutlier-',M{mdl_ind},'.jpg'))
end

%ferritinI

for mdl_ind=1:4:5

    %T2    '1=fcL 2=R 3=hdL 4=R 5=lgL 6=R 7=mtr 8=AccL 9=AccR 10=V2L 11=V2R 
    T2=mdl{mdl_ind};
    ind=[1:10,12:16];
   
    figure
    AccT2=T2(:,8);
    LegT2=T2(:,5);
    V2T2=T2(:,10);
    t2=[AccT2(ind);LegT2(ind);V2T2(ind)];
    
    AccFerr=data(2:17,4);
    LegFerr=data(2:17,5);
    V2Ferr=data(2:17,6);
    Ferr=[AccFerr(ind);LegFerr(ind);V2Ferr(ind)];
    [R,PValue] = corr(t2,Ferr);
    scatter(t2,Ferr,'w')
    lsline
    hold on
    scatter(AccT2,AccFerr,'b*')
    scatter(AccT2(end-2:end),AccFerr(end-2:end),'r*')
    scatter(LegT2,LegFerr,'bo')
    scatter(LegT2(end-2:end),LegFerr(end-2:end),'ro')
    scatter(V2T2,V2Ferr,'b^')
    scatter(V2T2(end-2:end),V2Ferr(end-2:end),'r^')
    
    xlabel('T2(ms) ')
    ylabel('FerritinFrac ')
    title(strcat(M{mdl_ind},'(R=',num2str(R),';P=',num2str(PValue),')'))
    saveas(gcf,strcat('FinalScatter-AccLegV2-',M{mdl_ind},'.jpg'))
end
   