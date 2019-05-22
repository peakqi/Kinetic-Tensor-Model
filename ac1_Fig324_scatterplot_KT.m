function ac1_Fig324_scatterplot_KT
%run on cluster

addpath('/vols/Data/km/fengqi/NIfTI');

[durationFrame,MND_ID]=a_dataframe

T{1}=qf_load('WorkingFolder/T2_hasSpike.nii.gz');
T{2}=qf_load('WorkingFolder/T2_nospike.nii.gz');
midname=strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz');
name=strcat('WorkingFolder/sim_KI_NoHole_flowout/',midname)
T{3}=qf_load(name);
name=strcat('WorkingFolder/sim_KI_withHole_flowout/',midname)
                           
T{4}=qf_load(name);
name=strcat('WorkingFolder/sim_KT_withHole_flowout/',midname)
T{5}=qf_load(name);

name=strcat('WorkingFolder/seg_gm.nii.gz');
GM=qf_load(name);


name=strcat('WorkingFolder/seg_wm.nii.gz');
WM=qf_load(name);



for ii=1:5
   mn(1,ii)=mean(nonzeros(T{ii}));
   mn(2,ii)=mean(nonzeros(T{ii}.*GM));
   mn(3,ii)=mean(nonzeros(T{ii}.*WM));
   sd(1,ii)=std(nonzeros(T{ii}));
   sd(2,ii)=std(nonzeros(T{ii}.*GM));
   sd(3,ii)=std(nonzeros(T{ii}.*WM));
end


save(strcat('../T2_mean_std_',MND_ID,'.mat'),'mn','sd')



% cd /vols/Data/km/fengqi/KTmodel/MND12
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND13
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND14
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND15
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND16
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND17
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND18
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND19
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND20
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND21
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND22
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND23
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/MND24
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/CTL10
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/CTL11
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 
% 
% 
% cd /vols/Data/km/fengqi/KTmodel/CTL12
% cp ../ac1_Fig324_scatterplot_KT.m .
% fsl_sub -q veryshort.q matlab -r -nodisplay ac1_Fig324_scatterplot_KT
% 



