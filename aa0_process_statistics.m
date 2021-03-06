function aa0_process_statistics
'aa0_process_statistics(durationFrame,ra,fitmethod)'

addpath(pwd)
addpath('/vols/Data/km/fengqi/NIfTI'); 
if strcmp(pwd,'/Users/fengqi/Documents/MND_REGISTRATION/KTmodel/KT_codes')
    durationFrame=5;MND_ID='MND_ID';
else
[durationFrame,MND_ID]=a_dataframe
end
ra=[5,95];fitmethod='exponential';

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

    
cd(addr)
cd ('WorkingFolder/sim_KI_NoHole_flowout')
mov=qf_load('test_flowout.nii.gz');
qf_save(mov(:,:,:,durationFrame),strcat('dF_',num2str(durationFrame),'concentration.nii.gz'));
concentration=mov(:,:,:,durationFrame);
xx=1:100;ind=ra(1):ra(2);sz=size(ind);
for jj=1:100
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1);
end
x = xx(ind)/100;
y = Tmean(ind);
y_shadow=Tstd(ind);

for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==wm)&(WMfromMNI_BW==1)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);  
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xw = xx(ind)/100;
yw = Tmean(ind);
yw_shadow=Tstd(ind);
for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==gm)&(GMfromMNI_BW==1)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj); 
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xg = xx(ind)/100;
yg = Tmean(ind);
yg_shadow=Tstd(ind);


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
    beta = nlinfit(xw,yw,modelfun,beta0)
    T2_revised=para-modelfun(beta, concentration)+beta(1)+beta(2);
    yw_revised=yw-modelfun(beta, xw)+beta(1)+beta(2);
    yg_revised=yw-modelfun(beta, xg)+beta(1)+beta(2);
    y_revised=yw-modelfun(beta, x)+beta(1)+beta(2);
end
qf_save(T2_revised,strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'))
aa0_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,'KI-NoHole',seg,wm,gm,durationFrame,fitmethod,...
    y_shadow,yw_shadow,yg_shadow,y_revised,yw_revised,yg_revised,MND_ID)

cd(addr)




%%%%%%%%%%%%%%%%%%%%%%%%%
cd ('WorkingFolder/sim_KI_withHole_flowout')
mov=qf_load('test_flowout.nii.gz');

qf_save(mov(:,:,:,durationFrame),strcat('dF_',num2str(durationFrame),'concentration.nii.gz'));
concentration=mov(:,:,:,durationFrame);

xx=1:100;ind=ra(1):ra(2);sz=size(ind);
for jj=1:100
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1);
end
x = xx(ind)/100;
y = Tmean(ind);
y_shadow=Tstd(ind);

for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==wm)&(WMfromMNI_BW==1)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);  
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xw = xx(ind)/100;
yw = Tmean(ind);
yw_shadow=Tstd(ind);
for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==gm)&(GMfromMNI_BW==1)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj); 
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xg = xx(ind)/100;
yg = Tmean(ind);
yg_shadow=Tstd(ind);



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
     yw_revised=yw-modelfun(beta, xw)+beta(1)+beta(2);
    yg_revised=yw-modelfun(beta, xg)+beta(1)+beta(2);
    y_revised=yw-modelfun(beta, x)+beta(1)+beta(2);
end
qf_save(T2_revised,strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'))
aa0_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,'KI-withHole',seg,wm,gm,durationFrame,fitmethod,...
    y_shadow,yw_shadow,yg_shadow,y_revised,yw_revised,yg_revised,MND_ID)


cd(addr)



%%%%%%%%%%%%%%%%%%%%%%%%%
cd ('WorkingFolder/sim_KT_withHole_flowout')
mov=qf_load('test_flowout.nii.gz');

qf_save(mov(:,:,:,durationFrame),strcat('dF_',num2str(durationFrame),'concentration.nii.gz'));
concentration=mov(:,:,:,durationFrame);

xx=1:100;ind=ra(1):ra(2);sz=size(ind);
for jj=1:100
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1);
end
x = xx(ind)/100;
y = Tmean(ind);
y_shadow=Tstd(ind);

for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==wm)&(WMfromMNI_BW==1)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);  
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xw = xx(ind)/100;
yw = Tmean(ind);
yw_shadow=Tstd(ind);
for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==gm)&(GMfromMNI_BW==1)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj); 
        Tstd(jj)=std(nzTj); 
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xg = xx(ind)/100;
yg = Tmean(ind);
yg_shadow=Tstd(ind);

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
    yw_revised=yw-modelfun(beta, xw)+beta(1)+beta(2);
    yg_revised=yw-modelfun(beta, xg)+beta(1)+beta(2);
    y_revised=yw-modelfun(beta, x)+beta(1)+beta(2);
end
qf_save(T2_revised,strcat('dF_',num2str(durationFrame),'Corrected-T2.nii.gz'))
aa0_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,'KT-withHole',seg,wm,gm,durationFrame,fitmethod,...
    y_shadow,yw_shadow,yg_shadow,y_revised,yw_revised,yg_revised,MND_ID)

cd(addr)
saveas(gcf,strcat('../date20181109','-',num2str(durationFrame),'-',fitmethod,MND_ID,'-correct.jpg'))

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

title(MND_ID)
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
    if nn==1
    homogeneity=[s(nn,1)/m(nn,1);s(nn,2)/m(nn,2);s(nn,3)/m(nn,3)]
    else
        temp=[s(nn,1)/m(nn,1);s(nn,2)/m(nn,2);s(nn,3)/m(nn,3)]
        homogeneity=cat(2,homogeneity,temp)
    end
    qf_save(grey,strcat('dF_',num2str(durationFrame),'CorrectedT2_grey.nii.gz'))
    qf_save(white,strcat('dF_',num2str(durationFrame),'CorrectedT2_white.nii.gz'))
        
end

cd (addr)
saveas(gcf,strcat('../date20181109-',num2str(durationFrame),'-',fitmethod,MND_ID,'-result.png'))
save(strcat('../date20181109-',fitmethod,MND_ID,'-homogeneity.mat'),'homogeneity')

