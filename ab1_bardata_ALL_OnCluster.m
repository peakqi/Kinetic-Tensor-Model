function ab1_bardata_ALL_OnCluster
addpath('/vols/Data/km/fengqi/NIfTI');
%'1=fcL 2=R 3=hdL 4=R 5=lgL 6=R 7=mtr 8=AccL 9=AccR 10=V2L 11=V2R 


% load('MNDHistoresults.mat')
% Data=MNDhistoresults{1:15,:};
[durationFrame,MND_ID]=a_dataframe

Stain{1,2}='MND12';
Stain{1,3}=1;
Stain{2,2}='MND13';
Stain{2,3}=1;
Stain{3,2}='MND14';
Stain{3,3}=3;
Stain{4,2}='MND15';
Stain{4,3}=1;
Stain{5,2}='MND16';
Stain{5,3}=1;
Stain{6,2}='MND17';
Stain{6,3}=1;
Stain{7,2}='MND18';
Stain{7,3}=2;
Stain{8,2}='MND19';
Stain{8,3}=4;
Stain{9,2}='MND20';
Stain{9,3}=1;
Stain{10,2}='MND21';
Stain{10,3}=2;
Stain{11,2}='MND22';
Stain{11,3}=1;
Stain{12,2}='MND23';
Stain{12,3}=2;
Stain{13,2}='MND24';
Stain{13,3}=2;
Stain{14,2}='CTL10';
Stain{14,3}=2;
Stain{15,2}='CTL11';
Stain{15,3}=2;
Stain{16,2}='CTL12';
Stain{16,3}=2;


%'1=fcL 2=R 3=hdL 4=R 5=lgL 6=R 7=mtr 8=AccL 9=AccR 10=V2L 11=V2R 



rt=strcat('/vols/Data/km/fengqi/masks/Motor_cortex/',MND_ID,'/')
MASK{1}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_face_L.nii.gz');
MASK{2}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_face_L_WM.nii.gz');
MASK{3}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_face_R.nii.gz');
MASK{4}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_face_R_WM.nii.gz');
MASK{5}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_hand_L.nii.gz');
MASK{6}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_hand_L_WM.nii.gz');
MASK{7}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_hand_R.nii.gz');
MASK{8}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_hand_R_WM.nii.gz');
MASK{9}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_leg_foot_L.nii.gz');
MASK{10}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_leg_foot_L_WM.nii.gz');
MASK{11}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_leg_foot_R.nii.gz');
MASK{12}=strcat(rt,'thr0pt5_bin_',MND_ID,'_fmedian_BA4_leg_foot_R_WM.nii.gz');


%face_L
aa1=qf_load(MASK{1});
aa2=qf_load(MASK{2});
m{1}= aa1-aa2;


%face_R
aa1=qf_load(MASK{3});
aa2=qf_load(MASK{4});
m{2}= aa1-aa2;

%hand_L
aa1=qf_load(MASK{5});
aa2=qf_load(MASK{6});
m{3}= aa1-aa2;

%hand_R
aa1=qf_load(MASK{7});
aa2=qf_load(MASK{8});
m{4}= aa1-aa2;


%Leg_L
aa1=qf_load(MASK{9});
aa2=qf_load(MASK{10});
m{5}= aa1-aa2;

%Leg_R
aa1=qf_load(MASK{11});
aa2=qf_load(MASK{12});
m{6}= aa1-aa2;



m{7}=m{1}+m{2}+m{3}+m{4}+m{5}+m{6};


rt=strcat('/vols/Data/km/fengqi/masks/ACC_masks/')

MASK{13}=strcat(rt,MND_ID,'/dti_corr_FA_mask_LACC.nii.gz');
m{8}=qf_load(MASK{13});
MASK{14}=strcat(rt,MND_ID,'/dti_corr_FA_mask_RACC.nii.gz');
m{9}=qf_load(MASK{14});

rt=strcat('/vols/Data/km/fengqi/masks/Visual_masks/')
MASK{15}=strcat(rt,MND_ID,'/dti_corr_FA_mask_LVC.nii.gz');
m{10}=qf_load(MASK{15});
MASK{16}=strcat(rt,MND_ID,'/dti_corr_FA_mask_RVC.nii.gz');
m{11}=qf_load(MASK{16});




T{1}=qf_load('WorkingFolder/T2_hasSpike.nii.gz');
T{2}=qf_load('WorkingFolder/T2_nospike.nii.gz');
midname=strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz');
name=strcat('WorkingFolder/sim_KI_NoHole_flowout/',midname)
T{3}=qf_load(name);
name=strcat('WorkingFolder/sim_KI_withHole_flowout/',midname)
T{4}=qf_load(name);
name=strcat('WorkingFolder/sim_KT_withHole_flowout/',midname)
T{5}=qf_load(name);
sz=size(T{1});
len=sz(1)*sz(2)*sz(3);

Msk=qf_load(strcat('WorkingFolder/mask_tot.nii.gz'));
M_flat=reshape(Msk,[len,1]);
G=qf_load(strcat('WorkingFolder/seg_gm.nii.gz'));
G_flat=reshape(G,[len,1]);

for ii=1:11
    m_flat=reshape(m{ii},[len,1]);
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_masked= t_flat.*m_flat.*M_flat;
        ind=find(t2_masked);
        vox_count=sum(m_flat(ind));
        tab(jj,ii)=sum(t2_masked(ind))/vox_count;      
    end
end

M_flat=M_flat.*G_flat;

for ii=1:11
    m_flat=reshape(m{ii},[len,1]);
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_masked= t_flat.*m_flat.*M_flat;
        ind=find(t2_masked);
        vox_count=sum(m_flat(ind));
        tab2(jj,ii)=sum(t2_masked(ind))/vox_count;      
    end
end



save(strcat('../FinalBar_',MND_ID,'.mat'),'tab','tab2')





