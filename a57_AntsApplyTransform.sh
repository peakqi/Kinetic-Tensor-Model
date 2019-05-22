#!/bin/sh
export ANTSPATH=/home/fs0/shurley/Software/ANTs/bin
cd WorkingFolder/sim_KI_NoHole_flowout/
$ANTSPATH/antsApplyTransforms -i Corrected-T2_*.nii.gz -o Deformed_Corrected-T2.nii.gz -r ../Ants.nii.gz -t  ../struct2template1Warp.nii.gz -t ../struct2template0GenericAffine.mat
cd ../..