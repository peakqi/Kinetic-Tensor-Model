function ab1_bardata_leg_hand_face
addpath('/vols/Data/km/fengqi/NIfTI');

[durationFrame,MND_ID]=a_dataframe
rt='/vols/Data/km/fengqi/Motor_cortex';
thr0pt5_bin_MND12_fmedian_BA4_face_L.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_face_L_WM.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_face_R.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_face_R_WM.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_hand_L.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_hand_L_WM.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_hand_R.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_hand_R_WM.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_leg_foot_L.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_leg_foot_L_WM.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_leg_foot_R.nii.gz
thr0pt5_bin_MND12_fmedian_BA4_leg_foot_R_WM.nii.gz

temp='_M1_MASK_face_L.nii.gz';
temp=strcat('WorkingFolder/ROImasks/',MND_ID,temp);
m{1}=qf_load(temp);

temp='_M1_MASK_face_R.nii.gz';
temp=strcat('WorkingFolder/ROImasks/',MND_ID,temp);
m{2}=qf_load(temp);

temp='_M1_MASK_hand_L.nii.gz';
temp=strcat('WorkingFolder/ROImasks/',MND_ID,temp);
m{3}=qf_load(temp);

temp='_M1_MASK_hand_R.nii.gz';
temp=strcat('WorkingFolder/ROImasks/',MND_ID,temp);
m{4}=qf_load(temp);

temp='_M1_MASK_leg_foot_L.nii.gz';
temp=strcat('WorkingFolder/ROImasks/',MND_ID,temp);
m{5}=qf_load(temp);

temp='_M1_MASK_leg_foot_R.nii.gz';
temp=strcat('WorkingFolder/ROImasks/',MND_ID,temp);
m{6}=qf_load(temp);
 

m{7}=m{1}+m{2}+m{3}+m{4}+m{5}+m{6};

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

V=qf_load(strcat('WorkingFolder/ROImasks/',MND_ID,'_V2_MASK_clean.nii.gz'));
Msk=qf_load(strcat('WorkingFolder/mask_tot.nii.gz'));
M_flat=reshape(Msk,[len,1]);
G=qf_load(strcat('WorkingFolder/seg_gm.nii.gz'));
G_flat=reshape(G,[len,1]);

for ii=1:7
    m_flat=reshape(m{ii},[len,1]);
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_masked= t_flat.*m_flat.*M_flat;
        ind=find(t2_masked);
        vox_count=sum(m_flat(ind));
        tab(jj,ii)=sum(t2_masked(ind))/vox_count;      
    end
end


v_flat=reshape(V,[len,1]);
for ii=1:7
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_v2= t_flat.*v_flat.*M_flat;
        ind=find(t2_v2);
        vox_count=sum(v_flat(ind));
        vv=sum(t2_v2(ind))/vox_count;  
        tab_v2(jj,ii)=tab(jj,ii)/vv;
    end
end



for ii=1:7
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_v2= t_flat.*M_flat;
        ind=find(t2_v2);
        vox_count=sum(v_flat(ind));
        vv=sum(t2_v2(ind))/vox_count;  
        tab_v3(jj,ii)=tab(jj,ii)/vv;
    end
end

g_flat=reshape(G,[len,1]);
for ii=1:7
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_v2= t_flat.*g_flat.*M_flat;
        ind=find(t2_v2);
        vox_count=sum(g_flat(ind));
        vv=sum(t2_v2(ind))/vox_count;  
        tab_v4(jj,ii)=tab(jj,ii)/vv;
    end
end


% 
% % normalise to left 100voxels
% s=size(V);
% Y=V*0;
% for ii=1:s(2)   
%     Y(:,ii,:)=Y(:,ii,:)*0+ii;
% end
% Y=240-Y;
% temp=reshape(Y,[len,1]);
% y_flat=temp.*M_flat;
% [val,ind1]=sort(-y_flat);
% ind=ind1(1:100);
% 
% for ii=1:7
%     for jj =1:5
%         t_flat=reshape(T{jj},[len,1]);
%         t2_v2= t_flat.*M_flat;
%         vox_count=sum(M_flat(ind));
%         vv=sum(t2_v2(ind))/vox_count;  
%         tab_v4(jj,ii)=tab(jj,ii)/vv;
%     end
% end

save(strcat('../',MND_ID,'_FinalBar.mat'),'tab','tab_v2','tab_v3','tab_v4')





