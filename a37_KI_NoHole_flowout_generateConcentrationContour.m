function a37_KI_NoHole_flowout_generateConcentrationContour

'a37_KI_NoHole_flowout_generateConcentrationContour.m '
addr=pwd;
load('parameter.mat');
if isempty(strfind(pwd,'Documents')) % empty is cluster
    addpath('/vols/Data/km/fengqi/NIfTI');    
    kk=durationFrame
else %found Documents is MAC
    
    cd (strcat('/Users/fengqi/Documents/MND_REGISTRATION/',folder));
end


cd ('WorkingFolder/sim_KI_NoHole_flowout')
mov=qf_load('sim_KI_NoHole_flowout.nii.gz');
movsz=size(mov);


qf_save(mov(:,:,:,durationFrame),'KI_NoHole_flowout_concentration.nii.gz');
cd(addr)


