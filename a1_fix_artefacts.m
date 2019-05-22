function a1_fix_artefacts

  addr=pwd;

 a10_despike_T2;
  cd(addr)
 a11_fix_L1brightring;
  cd(addr)
 a12_fix_blackpoints;
  cd(addr)
 a13_fix_mask0diffusivity;
  cd(addr)
 a14_fast_segmentation;
  cd(addr)
 a15_AntsReg
  cd(addr)
 a16_AntsReg_Seg
   cd(addr)