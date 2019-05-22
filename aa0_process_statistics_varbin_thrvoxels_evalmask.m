function aa0_process_statistics_varbin_thrvoxels_evalmask(durationFrame,ra,fitmethod,bin,thr)
'aa0_process_statistics(durationFrame,ra,fitmethod)'

addpath('.')
addpath('/vols/Data/km/fengqi/NIfTI'); 
addr=pwd;
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

figure    
cd(addr)
cd ('WorkingFolder/sim_KI_NoHole_flowout')
mov=qf_load('test_flowout.nii.gz');
qf_save(mov(:,:,:,durationFrame),strcat('dF_',num2str(durationFrame),'concentration.nii.gz'));
concentration=mov(:,:,:,durationFrame);

[x,y]= a_comp_fit_thrs(concentration,bin,ra,mask,para,thr);
[xw,yw]= a_comp_fit_thrs(concentration,bin,ra,(mask>0)&(seg==wm)&(WMfromMNI_BW==1),para,thr);
[xg,yg]= a_comp_fit_thrs(concentration,bin,ra,(mask>0)&(seg==gm)&(GMfromMNI_BW==1),para,thr);


if strcmp(fitmethod,'linear')
    modelfun = @(b,x)(b(1)+b(2)*x);
    beta0 = [100;-50];
    y(y>100)=NaN;
    beta = nlinfit(x,y,modelfun,beta0)
    T2_revised=para-beta(2)*concentration;
elseif strcmp(fitmethod,'exponential')
    modelfun = @(b,x)(b(1)+b(2)*exp(b(3)*x));
    beta0 = [20;10;-2];
    y(y>100)=NaN;
    beta = nlinfit(x,y,modelfun,beta0)
    T2_revised=para-modelfun(beta, concentration)+beta(1)+beta(2);
end
qf_save(T2_revised,strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'))
aa0_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,'KI-NoHole',seg,wm,gm,durationFrame,fitmethod)

cd(addr)




%%%%%%%%%%%%%%%%%%%%%%%%%
cd ('WorkingFolder/sim_KI_withHole_flowout')
mov=qf_load('test_flowout.nii.gz');

qf_save(mov(:,:,:,durationFrame),strcat('dF_',num2str(durationFrame),'concentration.nii.gz'));
concentration=mov(:,:,:,durationFrame);

[x,y]= a_comp_fit_thrs(concentration,bin,ra,mask,para,thr);
[xw,yw]= a_comp_fit_thrs(concentration,bin,ra,(mask>0)&(seg==wm)&(WMfromMNI_BW==1),para,thr);
[xg,yg]= a_comp_fit_thrs(concentration,bin,ra,(mask>0)&(seg==gm)&(GMfromMNI_BW==1),para,thr);


if strcmp(fitmethod,'linear')
    modelfun = @(b,x)(b(1)+b(2)*x);
    beta0 = [100;-50];
    y(y>100)=NaN;
    beta = nlinfit(x,y,modelfun,beta0)
    T2_revised=para-beta(2)*concentration;
elseif strcmp(fitmethod,'exponential')
    modelfun = @(b,x)(b(1)+b(2)*exp(b(3)*x));
    beta0 = [20;10;-2];
    y(y>100)=NaN;
    beta = nlinfit(x,y,modelfun,beta0)
     T2_revised=para-modelfun(beta, concentration)+beta(1)+beta(2);
end
qf_save(T2_revised,strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'))
aa0_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,'KI-withHole',seg,wm,gm,durationFrame,fitmethod)


cd(addr)



%%%%%%%%%%%%%%%%%%%%%%%%%
cd ('WorkingFolder/sim_KT_withHole_flowout')
mov=qf_load('test_flowout.nii.gz');

qf_save(mov(:,:,:,durationFrame),strcat('dF_',num2str(durationFrame),'concentration.nii.gz'));
concentration=mov(:,:,:,durationFrame);
[x,y]= a_comp_fit_thrs(concentration,bin,ra,mask,para,thr);
[xw,yw]= a_comp_fit_thrs(concentration,bin,ra,(mask>0)&(seg==wm)&(WMfromMNI_BW==1),para,thr);
[xg,yg]= a_comp_fit_thrs(concentration,bin,ra,(mask>0)&(seg==gm)&(GMfromMNI_BW==1),para,thr);


if strcmp(fitmethod,'linear')
    modelfun = @(b,x)(b(1)+b(2)*x);
    beta0 = [100;-50];
    y(y>100)=NaN;
    beta = nlinfit(x,y,modelfun,beta0)
    T2_revised=para-beta(2)*concentration;
elseif strcmp(fitmethod,'exponential')
    modelfun = @(b,x)(b(1)+b(2)*exp(b(3)*x));
    beta0 = [20;10;-2];
    y(y>100)=NaN;
    beta = nlinfit(x,y,modelfun,beta0)
    T2_revised=para-modelfun(beta, concentration)+beta(1)+beta(2);
end

qf_save(T2_revised,strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'))
aa0_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,'KT-withHole',seg,wm,gm,durationFrame,fitmethod)

cd(addr)
saveas(gcf,strcat('date0612','-',num2str(durationFrame),'-',fitmethod,'-correct.jpg'))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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



figure


for nn=1:4
    
nn
    cd (addr);
    cd('WorkingFolder');
    cd(Name{nn});
    concentration=qf_load(strcat('dF_',num2str(durationFrame),'concentration.nii.gz'));
    evalmask=single(concentration<ra(2));
    correctedT2=qf_load(strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'));
    correctedT2=correctedT2.*evalmask;
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

