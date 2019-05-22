function a14_fast_segmentation
'a14_fast_segmentation'


addpath('/vols/Data/km/fengqi/NIfTI');
cd WorkingFolder
seg=qf_load('seg.nii.gz');
qf_save(single(seg>2),'seg_gm.nii.gz');
qf_save(single(seg==2|seg==1),'seg_wm.nii.gz')
seg_gm=qf_load('seg_gm.nii.gz');
seg_wm=qf_load('seg_wm.nii.gz');
seg=seg_gm+seg_wm*3;
qf_save(seg,'seg_seg.nii.gz')
cd ..
