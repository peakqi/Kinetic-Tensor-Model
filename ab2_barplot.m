function ab2_barplot
close all
ctl{1}='CTL10_FinalBar.mat';
ctl{2}='CTL11_FinalBar.mat';
ctl{3}='CTL12_FinalBar.mat';
pat{1}='MND17_FinalBar.mat';
pat{2}='MND18_FinalBar.mat';
pat{3}='MND19_FinalBar.mat';
pat{4}='MND20_FinalBar.mat';
pat{5}='MND21_FinalBar.mat';
pat{6}='MND23_FinalBar.mat';
pat{7}='MND24_FinalBar.mat';

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

for mdl_ind=1:5
    figure
    for mnd=1:7%MND12
        load(pat{mnd})
        Pa(mnd,:)=tab(mdl_ind,:)  ;
    end

    for mnd=1:7%MND12
        if mnd>3
            Ct(mnd,:)=NaN
        else
            load(ctl{mnd})
            Ct(mnd,:)=tab(mdl_ind,:)  ;
        end
    end

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
        [t_mtr,p_mtr]=ttest2([Pa(:,7)],[Ct(:,7)])
        title(strcat('p-face:',num2str(p_face),';p-hand:',num2str(p_hand),';p-leg:',num2str(p_leg),'p-mtr:',num2str(p_mtr)))
       saveas(gcf,strcat('FinalBar-',mdl{mdl_ind},'.jpg')) 
end




for mdl_ind=1:5
    figure
    for mnd=1:7%MND12
        load(pat{mnd})
        Pa(mnd,:)=tab_v2(mdl_ind,:)  ;
    end

    for mnd=1:7%MND12
        if mnd>3
            Ct(mnd,:)=NaN
        else
            load(ctl{mnd})
            Ct(mnd,:)=tab_v2(mdl_ind,:)  ;
        end
    end

    data=[Pa(:,1:2),Ct(:,1:2),Pa(:,3:4),Ct(:,3:4),Pa(:,5:6),Ct(:,5:6),Pa(:,7),Ct(:,7)]

    boxplot(data,'colorgroup',[1,1,2,2,1,1,2,2,1,1,2,2,1,2])
    xticklabels({'face_L_ALS','face_R_ALS','face_L_CTL','face_R_CTL',...
        'hand_L_ALS','hand_R_ALS','hand_L_CTL','hand_R_CTL',...
        'leg_L_ALS','leg_R_ALS','leg_L_CTL','leg_R_CTL','motor_ALS','motor_CTL'})
    xtickangle(90)
    ylabel(strcat(mdl{mdl_ind},'Normalised by V2'))
        [t_face,p_face]=ttest2([Pa(:,1);Pa(:,2)],[Ct(:,1);Ct(:,2)])
    [t_hand,p_hand]=ttest2([Pa(:,3);Pa(:,4)],[Ct(:,3);Ct(:,4)])
    [t_leg,p_leg]=ttest2([Pa(:,5);Pa(:,6)],[Ct(:,5);Ct(:,6)])
        [t_mtr,p_mtr]=ttest2([Pa(:,7)],[Ct(:,7)])
        title(strcat('p-face:',num2str(p_face),';p-hand:',num2str(p_hand),';p-leg:',num2str(p_leg),'p-mtr:',num2str(p_mtr)))
       
    saveas(gcf,strcat('FinalBar-',mdl{mdl_ind},'normalised.jpg'))
end

