function a39_KT_withHole_flowout_generateConcentrationContour

'a39_KT_withHole_flowout_generateConcentrationContour.m'
addr=pwd;
load('parameter.mat');
if isempty(strfind(pwd,'Documents')) % empty is cluster
    addpath('/vols/Data/km/fengqi/NIfTI');    
    kk=durationFrame
else %found Documents is MAC   
    cd (strcat('/Users/fengqi/Documents/MND_REGISTRATION/',folder));
    kk=durationFrame
end

cd ('WorkingFolder/sim_KT_withHole_flowout')
mov=qf_load('sim_KT_withHole_flowout.nii.gz');
durationFrame=kk;
qf_save(mov(:,:,:,durationFrame),'KT_withHole_flowout_concentration.nii.gz');
cd (addr);
