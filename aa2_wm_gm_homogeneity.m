function aa2_wm_gm_homogeneity(durationFrame,ra,fitmethod)
figure
addr=pwd
cd WorkingFolder
    GMfromMNI=qf_load('MNI2Diff/GM02str.nii.gz');
    GMfromMNI_BW=single(GMfromMNI>0);
    WMfromMNI=qf_load('MNI2Diff/WM02str.nii.gz');
    WMfromMNI_BW=single(WMfromMNI>0);
    para=qf_load('T2_nospike.nii.gz');
    mask=qf_load('mask_tot.nii.gz');
    seg_gm=qf_load('seg_gm.nii.gz');
    seg_wm=qf_load('seg_wm.nii.gz');
    seg=seg_gm+seg_wm*3;
    qf_save(seg,'seg_seg.nii.gz')
    wm=3;gm=1;
    mask=single(mask.*(GMfromMNI_BW+WMfromMNI_BW)>0.*(seg>0));

L_GMfromMNI_BW=reshape(GMfromMNI_BW,210*240*176,1);
L_WMfromMNI_BW=reshape(WMfromMNI_BW,210*240*176,1);


seg=qf_load('WorkingFolder/seg_seg.nii.gz');
L_seg=reshape(seg,210*240*176,1);

clear Name
Name{1}='sim_T2';
Name{2}='sim_KI_NoHole_flowout';
Name{3}='sim_KI_withHole_flowout';
Name{4}='sim_KT_withHole_flowout';

titl{1}='T2';
titl{2}='KI-NoHole';
titl{3}='KI-withHole';
titl{4}='KT-withHole';


cd (addr);
cd('WorkingFolder');

mkdir sim_T2
cd sim_T2
copyfile('../T2_nospike.nii.gz',strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'))



for nn=1:4
    
nn
    cd (addr);
    cd('WorkingFolder');
    cd(Name{nn});

    correctedT2=qf_load(strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'));
    L_T2=reshape(correctedT2,210*240*176,1);
    
    
    %white
    L_kk=single(L_seg==3).*L_T2.*L_WMfromMNI_BW;
    NoZeros=L_kk(L_kk~=0);      
    m(nn,1)=mean(NoZeros)
    s(nn,1)=std(NoZeros)
    white=single(seg==3).*correctedT2.*WMfromMNI_BW;   

    %grey
    L_kk=single(L_seg==1).*L_T2.*L_GMfromMNI_BW;
    NoZeros=L_kk(L_kk~=0);      
    m(nn,2)=mean(NoZeros)
    s(nn,2)=std(NoZeros)
    grey=single(seg==1).*correctedT2.*GMfromMNI_BW; 
    
    %grey+white
    L_kk=single(L_seg==1).*L_T2.*L_GMfromMNI_BW+single(L_seg==3).*L_T2.*L_WMfromMNI_BW;
    NoZeros=L_kk(L_kk~=0);      
    m(nn,3)=mean(NoZeros)
    s(nn,3)=std(NoZeros)
    r=s./m
    g_w=grey+white; 
    
        
    subplot(4,5,nn)
    imagesc(correctedT2(:,:,92))
    colormap gray
    caxis([0,100])
    title(titl{nn})
    subplot(4,5,nn+5)
    imagesc(white(:,:,92))
    colormap gray
    caxis([0,100])
    title(num2str(s(nn,1)/m(nn,1)))
    subplot(4,5,nn+10)
    imagesc(grey(:,:,92))
    colormap gray
    caxis([0,100])
    title(num2str(s(nn,2)/m(nn,2)))
    subplot(4,5,nn+15)
    imagesc(g_w(:,:,92))
    colormap gray
    caxis([0,100])
    title(num2str(s(nn,3)/m(nn,3)))

        
    qf_save(grey,strcat('dF_',num2str(durationFrame),'CorrectedT2_grey.nii.gz'))
    qf_save(white,strcat('dF_',num2str(durationFrame),'CorrectedT2_white.nii.gz'))
        
end

cd (addr)
saveas(gcf,strcat('date1010-',num2str(durationFrame),'-',fitmethod,'-result.png'))

