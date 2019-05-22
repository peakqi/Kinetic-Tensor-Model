#!/bin/sh
export ANTSPATH=/home/fs0/shurley/Software/ANTs/bin
cd WorkingFolder
$ANTSPATH/antsRegistrationSyNQuick.sh -d 3 -f ../../Ants.nii.gz -m struct.nii.gz -o struct2template
cd ..

