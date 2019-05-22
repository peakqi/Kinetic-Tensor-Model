function [MD_gm,MD_wm,MD_2]=a_Calc_meanDiffusivity

addpath('/vols/Data/km/fengqi/NIfTI');
try
md=qf_load('dti_MD.nii.gz');
gm=qf_load('seg_gm.nii.gz');
wm=qf_load('seg_wm.nii.gz');


nzg = nonzeros(md.*gm);
MD_gm=mean(nzg)
nzw = nonzeros(md.*wm);
MD_wm=mean(nzw)

nz = nonzeros(md);
MD_2=mean(nz)
catch ee
   aa=pwd;
   cd ..
   md=qf_load('dti_MD.nii.gz');
    gm=qf_load('seg_gm.nii.gz');
    wm=qf_load('seg_wm.nii.gz');


    nzg = nonzeros(md.*gm);
    MD_gm=mean(nzg)
    nzw = nonzeros(md.*wm);
    MD_wm=mean(nzw)

    nz = nonzeros(md);
    MD_2=mean(nz)
    cd (aa)

end