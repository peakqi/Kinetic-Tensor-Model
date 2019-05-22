function a38_KI_withHole_flowout_generateConcentrationContour

'a38_KI_withHole_flowout_generateConcentrationContour.m '
addr=pwd;
load('parameter.mat');
if isempty(strfind(pwd,'Documents')) % empty is cluster
    addpath('/vols/Data/km/fengqi/NIfTI');    
    kk=durationFrame
else %found Documents is MAC
    kk=durationFrame
    cd (strcat('/Users/fengqi/Documents/MND_REGISTRATION/',folder));
end

cd ('WorkingFolder/sim_KI_withHole_flowout')
durtionFrame=kk
mov=qf_load('sim_KI_withHole_flowout.nii.gz');
qf_save(mov(:,:,:,durtionFrame),'KI_withHole_flowout_concentration.nii.gz');
cd (addr);