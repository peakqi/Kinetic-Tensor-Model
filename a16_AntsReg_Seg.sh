#!/bin/sh
export ANTSPATH=/home/fs0/shurley/Software/ANTs/bin
cd WorkingFolder
$ANTSPATH/antsApplyTransforms -i seg_seg.nii.gz -o seg_deformed.nii.gz -r Ants.nii.gz -t  struct2template1Warp.nii.gz -t struct2template0GenericAffine.mat
cd ..


