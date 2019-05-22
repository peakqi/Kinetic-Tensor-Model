function a16_AntsReg_Seg
'a16_AntsReg_Seg.m'
cd WorkingFolder
fslqf('fslcpgeom struct.nii.gz seg_seg.nii.gz')
fslqf('fslswapdim seg_seg.nii.gz -x y z seg_seg.nii.gz')
cd ..
system('sh a16_AntsReg_Seg.sh')
