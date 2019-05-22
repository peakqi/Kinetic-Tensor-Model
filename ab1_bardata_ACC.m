function ab1_bardata_ACC
addpath('/vols/Data/km/fengqi/NIfTI');

[durationFrame,MND_ID]=a_dataframe

temp='dti_corr_FA_mask_LACC.nii.gz';
temp=strcat('WorkingFolder/',temp);
m{1}=qf_load(temp);

temp='dti_corr_FA_mask_RACC.nii.gz';
temp=strcat('WorkingFolder/',temp);
m{2}=qf_load(temp);


m{3}=m{1}+m{2};

T{1}=qf_load('WorkingFolder/T2_hasSpike.nii.gz');
T{2}=qf_load('WorkingFolder/T2_nospike.nii.gz');
midname=strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz');
name=strcat('WorkingFolder/sim_KI_NoHole_flowout/',midname);
T{3}=qf_load(name);
name=strcat('WorkingFolder/sim_KI_withHole_flowout/',midname);
T{4}=qf_load(name);
name=strcat('WorkingFolder/sim_KT_withHole_flowout/',midname);
T{5}=qf_load(name);
sz=size(T{1});
len=sz(1)*sz(2)*sz(3);

V=qf_load(strcat('WorkingFolder/ROImasks/',MND_ID,'_V2_MASK_clean.nii.gz'));
Msk=qf_load(strcat('WorkingFolder/mask_tot.nii.gz'));
M_flat=reshape(Msk,[len,1]);
G=qf_load(strcat('WorkingFolder/seg_gm.nii.gz'));

% avg T2 in ACC
for ii=1:3
    m_flat=reshape(m{ii},[len,1]);
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);  %t_flat correctedT2 mask  %m_flat ACC   %M_flat mask_tot
        t2_masked= t_flat.*m_flat.*M_flat;
        ind=find(t2_masked);
        vox_count=sum(m_flat(ind));
        tab(jj,ii)=sum(t2_masked(ind))/vox_count;      
    end
end

% avg T2/avg V2
v_flat=reshape(V,[len,1]); %V is V2
for ii=1:3
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_v2= t_flat.*v_flat.*M_flat;
        ind=find(t2_v2);
        vox_count=sum(v_flat(ind));
        vv=sum(t2_v2(ind))/vox_count;  
        tab_v2(jj,ii)=tab(jj,ii)/vv;
    end
end


% avg T2/avg all
for ii=1:3
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_v2= t_flat.*M_flat;
        ind=find(t2_v2);
        vox_count=sum(v_flat(ind));
        vv=sum(t2_v2(ind))/vox_count;  
        tab_v3(jj,ii)=tab(jj,ii)/vv;
    end
end

% avg T2 with grey matter mask
g_flat=reshape(G,[len,1]);
for ii=1:3
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_v2= t_flat.*g_flat.*M_flat;
        ind=find(t2_v2);
        vox_count=sum(g_flat(ind));
        vv=sum(t2_v2(ind))/vox_count;  
        tab_v4(jj,ii)=vv;
    end
end


% avgT2/avgV2 with grey matter mask
v_flat=reshape(V,[len,1]); %V is V2
for ii=1:3
    for jj =1:5
        t_flat=reshape(T{jj},[len,1]);
        t2_v2= t_flat.*v_flat.*M_flat.*g_flat;
        ind=find(t2_v2);
        vox_count=sum(v_flat(ind));
        vv=sum(t2_v2(ind))/vox_count;  
        tab_v5(jj,ii)=tab_v4(jj,ii)/vv;
    end
end


save(strcat('../',MND_ID,'_ACC_FinalBar.mat'),'tab','tab_v2','tab_v3','tab_v4','tab_v5')





