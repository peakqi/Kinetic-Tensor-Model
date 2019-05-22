function a00_run
addpath(pwd)
addpath('/vols/Data/km/fengqi/NIfTI');

addr=pwd;
'a0_Para_MND12'
a0_Para_MND12
cd(addr)
'a0_prepare_data'
a0_prepare_data
cd(addr)
'a1_fix_artefacts'
a1_fix_artefacts
cd(addr)
'a6_T2_processing'
a6_T2_processing
cd(addr)
'a7_KI_NoHole'
a7_KI_NoHole
cd(addr)
'a8_KI_withHole'
a8_KI_withHole
cd(addr)
'a9_KT_withHole'
a9_KT_withHole
cd(addr)



ra=[5,95]
for ii=1:10  
    strcat('Now is ',num2str(ii))
    aa0_process_statistics(ii,ra,'exponential')
end
