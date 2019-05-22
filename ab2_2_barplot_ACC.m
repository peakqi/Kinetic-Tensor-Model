function ab2_2_barplot_ACC
close all
ctl{1}='CTL10_ACC_FinalBar.mat';
ctl{2}='CTL11_ACC_FinalBar.mat';
ctl{3}='CTL12_ACC_FinalBar.mat';
pat{1}='MND17_ACC_FinalBar.mat';
pat{2}='MND18_ACC_FinalBar.mat';
pat{3}='MND19_ACC_FinalBar.mat';
pat{4}='MND20_ACC_FinalBar.mat';
pat{5}='MND21_ACC_FinalBar.mat';
pat{6}='MND23_ACC_FinalBar.mat';
pat{7}='MND24_ACC_FinalBar.mat';

mdl{1}='EPG-T2';
mdl{2}='EPG-T2-despike';
mdl{3}='KI--NoHole-corrected-T2';
mdl{4}='KI-WithHole-corrected-T2';
mdl{5}='KT-WithHole-corrected-T2';

% tab  'ACC_L	ACC_R	ACC'
%EPG1
% EPG2
% KI1
% KI2
% KT


%Pa patient
close all
for mdl_ind=1:5
    figure
    for mnd=1:42%MND12
        if mnd>7
            Pa(mnd,:)=NaN
        else
            load(pat{mnd})
            Pa(mnd,:)=tab(mdl_ind,:)  ;
        end
    end
    Pa(1:14,3)=[Pa(1:7,1);Pa(1:7,2);];
    for mnd=1:42%MND12
        if mnd>3
            Ct(mnd,:)=NaN
        else
            load(ctl{mnd})
            Ct(mnd,:)=tab(mdl_ind,:)  ;
        end
    end
    Ct(1:14,3)=[Ct(1:7,1);Ct(1:7,2);];
    
    data=[Pa(:,1:2),Ct(:,1:2),Pa(:,3),Ct(:,3)];

    boxplot(data,'colorgroup',[1,1,2,2,1,2])
    xticklabels({'ACC_L_ALS','ACC_R_ALS','ACC_L_CTL','ACC_R_CTL',...
        'ACC_ALS','ACC_CTL'})
    xtickangle(90)
    ylabel(mdl{mdl_ind})
    
    
    [t_ACC,p_ACC]=ttest2([Pa(:,1);Pa(:,2)],[Ct(:,1);Ct(:,2)],'Tail','left')
       
        title(strcat('p-ACC:',num2str(p_ACC)))
       saveas(gcf,strcat('FinalBar-ACC-',mdl{mdl_ind},'.jpg')) 
end


for mdl_ind=1:5
    figure
    for mnd=1:42%MND12
        if mnd>7
            Pa(mnd,:)=NaN
        else
            load(pat{mnd})
            Pa(mnd,:)=tab_v2(mdl_ind,:)  ;
        end
    end
    Pa(1:14,3)=[Pa(1:7,1);Pa(1:7,2);];
    for mnd=1:42%MND12
        if mnd>3
            Ct(mnd,:)=NaN
        else
            load(ctl{mnd})
            Ct(mnd,:)=tab_v2(mdl_ind,:)  ;
        end
    end
    Ct(1:14,3)=[Ct(1:7,1);Ct(1:7,2);];
    
    data=[Pa(:,1:2),Ct(:,1:2),Pa(:,3),Ct(:,3)];

    boxplot(data,'colorgroup',[1,1,2,2,1,2])
    xticklabels({'ACC_L_ALS','ACC_R_ALS','ACC_L_CTL','ACC_R_CTL',...
        'ACC_ALS','ACC_CTL'})
    xtickangle(90)
    ylabel(mdl{mdl_ind})
    
    
    [t_ACC,p_ACC]=ttest2([Pa(:,1);Pa(:,2)],[Ct(:,1);Ct(:,2)],'Tail','left')
       
        title(strcat('p-ACC:',num2str(p_ACC)))
       saveas(gcf,strcat('FinalBar-ACC-normalised',mdl{mdl_ind},'.jpg')) 
end