function ab2_ALL
load('MNDHistoresults.mat')
Data=MNDhistoresults{1:15,:};


Stain{1,2}='MND12';
Stain{1,3}=1;
Stain{2,2}='MND13';
Stain{2,3}=1;
Stain{3,2}='MND14';
Stain{3,3}=3;
Stain{4,2}='MND15';
Stain{4,3}=1;
Stain{5,2}='MND16';
Stain{5,3}=1;
Stain{6,2}='MND17';
Stain{6,3}=1;
Stain{7,2}='MND18';
Stain{7,3}=2;
Stain{8,2}='MND19';
Stain{8,3}=4;
Stain{9,2}='MND20';
Stain{9,3}=1;
Stain{10,2}='MND21';
Stain{10,3}=2;
Stain{11,2}='MND22';
Stain{11,3}=1;
Stain{12,2}='MND23';
Stain{12,3}=2;
Stain{13,2}='MND24';
Stain{13,3}=2;
Stain{14,2}='CTL10';
Stain{14,3}=2;
Stain{15,2}='CTL11';
Stain{15,3}=2;
Stain{16,2}='CTL12';
Stain{16,3}=2;
M{1}='EPG-T2';
M{2}='EPG-T2-despike';
M{3}='KI--NoHole-corrected-T2';
M{4}='KI-WithHole-corrected-T2';
M{5}='KT-WithHole-corrected-T2';

for ii=1:16
    try 
       load(strcat('FinalBar_',Stain{ii,2},'.mat')) ;
       mdl{1}(ii,1:11)=tab(1,:);
       mdl{2}(ii,1:11)=tab(2,:);
       mdl{3}(ii,1:11)=tab(3,:);
       mdl{4}(ii,1:11)=tab(4,:);
       mdl{5}(ii,1:11)=tab(5,:);
    catch
       mdl{1}(ii,1:11)=NaN;
       mdl{2}(ii,1:11)=NaN;
       mdl{3}(ii,1:11)=NaN;
       mdl{4}(ii,1:11)=NaN;
       mdl{5}(ii,1:11)=NaN; 
    end
    
end



for mdl_ind=1:5
    figure

     Ct=NaN(13*6,7); Pa=Ct;
    for ii=1:6
       Pa(1:13,ii)= mdl{mdl_ind}(1:13,ii);
    end
    for ii=1:6
       Ct(1:3,ii)= mdl{mdl_ind}(14:16,ii);
    end
    Pa(:,7)=[mdl{mdl_ind}(1:13,1);mdl{mdl_ind}(1:13,2);mdl{mdl_ind}(1:13,3);mdl{mdl_ind}(1:13,4);mdl{mdl_ind}(1:13,5);mdl{mdl_ind}(1:13,6)]
    Ct(:,7)=[Ct(1:13,1);Ct(1:13,2);Ct(1:13,3);Ct(1:13,4);Ct(1:13,5);Ct(1:13,6)]
    data=[Pa(:,1:2),Ct(:,1:2),Pa(:,3:4),Ct(:,3:4),Pa(:,5:6),Ct(:,5:6),Pa(:,7),Ct(:,7)]

    boxplot(data,'colorgroup',[1,1,2,2,1,1,2,2,1,1,2,2,1,2])
    xticklabels({'face_L_ALS','face_R_ALS','face_L_CTL','face_R_CTL',...
        'hand_L_ALS','hand_R_ALS','hand_L_CTL','hand_R_CTL',...
        'leg_L_ALS','leg_R_ALS','leg_L_CTL','leg_R_CTL','motor_ALS','motor_CTL'})
    xtickangle(90)
    ylabel(mdl{mdl_ind})
    
    
    [t_face,p_face]=ttest2([Pa(:,1);Pa(:,2)],[Ct(:,1);Ct(:,2)])
    [t_hand,p_hand]=ttest2([Pa(:,3);Pa(:,4)],[Ct(:,3);Ct(:,4)])
    [t_leg,p_leg]=ttest2([Pa(:,5);Pa(:,6)],[Ct(:,5);Ct(:,6)])
        [t_mtr,p_mtr]=ttest2([Pa(:,7)],[Ct(:,7)]);%,'Tail','left'
        title(strcat('p-face:',num2str(p_face),';p-hand:',num2str(p_hand),';p-leg:',num2str(p_leg),'p-mtr:',num2str(p_mtr)))
       saveas(gcf,strcat('FinalBar-',M{mdl_ind},'.jpg')) 
end















