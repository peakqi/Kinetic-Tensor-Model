function a0_prepare_data
load('parameter.mat')
[folder_EPG,folder_Ben]=a_Folder_ptr;
%%%% cp data to working folder
WorkingFolder=strcat('WorkingFolder');
mkdir(WorkingFolder);

cd ('WorkingFolder')
addpath('/vols/Data/km/fengqi/NIfTI');
copyfile(strcat(folder_EPG{index},'/struct*'),'.')
copyfile(strcat(folder_Ben{index},'dti_V*.nii.gz'),'.')
try
copyfile(strcat(folder_Ben{index},'/corr/dti_corr_L1.nii.gz'),'dti_L1.nii.gz')
copyfile(strcat(folder_Ben{index},'/corr/dti_corr_L2.nii.gz'),'dti_L2.nii.gz')
copyfile(strcat(folder_Ben{index},'/corr/dti_corr_L3.nii.gz'),'dti_L3.nii.gz')
copyfile(strcat(folder_Ben{index},'/corr/dti_corr_MD.nii.gz'),'dti_MD.nii.gz')
copyfile(strcat(folder_Ben{index},'/corr/dti_corr_FA.nii.gz'),'dti_FA.nii.gz')
catch eee
copyfile(strcat(folder_Ben{index},'/dti_L1.nii.gz'),'dti_L1.nii.gz')
copyfile(strcat(folder_Ben{index},'/dti_L2.nii.gz'),'dti_L2.nii.gz')
copyfile(strcat(folder_Ben{index},'/dti_L3.nii.gz'),'dti_L3.nii.gz')
copyfile(strcat(folder_Ben{index},'/dti_MD.nii.gz'),'dti_MD.nii.gz')
copyfile(strcat(folder_Ben{index},'/dti_FA.nii.gz'),'dti_FA.nii.gz') 
end
copyfile(strcat(folder_EPG{index},'/struct_to_diff.nii.gz'),'struct.nii.gz')
copyfile(strcat(folder_EPG{index},'/struct_to_diff.nii.gz'),'.')
copyfile(strcat(folder_EPG{index},'/masked_step2_T2Z.nii.gz'),'T2_hasSpike.nii.gz')
copyfile(strcat(folder_EPG{index},'/masked_step2_ALP.nii.gz'),'B1.nii.gz')
try
copyfile(strcat(folder_EPG{index},'/FAST/dti_MD_seg.nii.gz'),'seg.nii.gz')
catch eee
copyfile(strcat(folder_EPG{index},'/FAST/EPG_T2_seg.nii.gz'),'seg.nii.gz')   
end
copyfile('../../Ants.nii.gz','Ants.nii.gz')
im=qf_load('T2_hasSpike.nii.gz');
fa=qf_load('dti_MD.nii.gz');
qf_save(single(fa>0),'mask_dti.nii.gz');
qf_save(single(im>0),'mask_epg.nii.gz');
qf_save(single(im>0&fa>0),'mask_tot.nii.gz');

cd ..
