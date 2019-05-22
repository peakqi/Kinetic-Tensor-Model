#!/bin/sh
export  ANTSPATH=~/Documents/ANTS_folder/antsbin/bin
$ANTSPATH/antsRegistrationSyNQuick.sh -d 3 -f Ants.nii.gz -m struct.nii.gz -o struct2Ants