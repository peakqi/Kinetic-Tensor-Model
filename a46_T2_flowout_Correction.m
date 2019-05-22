function a46_T2_flowout_Correction

'a46_T2_flowout_Correction.m'

addr=pwd;
load('parameter.mat');
ra=concentrationRegressionRange
if isempty(strfind(pwd,'Documents')) % empty is cluster
    addpath('/vols/Data/km/fengqi/NIfTI');
    addpath(addr)
else %found Documents is MAC
    
    cd (strcat('/Users/fengqi/Documents/MND_REGISTRATION/',folder));
end

cd ('WorkingFolder')
T2=qf_load('T2_nospike.nii.gz');
cd sim_T2

qf_save(T2,strcat('Corrected-T2_T2_flowout_Correction.nii.gz'))
                        
fslqf('fslcpgeom ../struct.nii.gz Corrected-T2_T2_flowout_Correction.nii.gz')
fslqf('fslswapdim Corrected-T2_T2_flowout_Correction.nii.gz -x y z Corrected-T2_T2_flowout_Correction.nii.gz')
cd (addr)
