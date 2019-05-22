function a49_KT_withHole_flowout_Correction(ra,folder)

'a49_KT_withHole_flowout_Correction.m'
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
para=qf_load('T2_nospike.nii.gz');
mask=qf_load('mask_tot.nii.gz');

cd sim_KT_withHole_flowout
concentration=qf_load('KT_withHole_flowout_concentration.nii.gz');
seg_gm=qf_load('../seg_gm.nii.gz');
seg_wm=qf_load('../seg_wm.nii.gz');
seg=seg_gm+seg_wm*3;
qf_save(seg,'../seg_seg.nii.gz')
wm=3;gm=1;
xx=1:100;ind=ra(1):ra(2);sz=size(ind);
for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);        
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1);
    
end
x = xx(ind)/100;
y = Tmean(ind);

for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==wm)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);        
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xw = xx(ind)/100;
yw = Tmean(ind);
for jj=1:100
   
        ind1=(concentration<=jj/100&concentration>(jj-1)/100 &(mask>0)&(seg==gm)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tmean(jj)=mean(nzTj);        
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1); 
end
xg = xx(ind)/100;
yg = Tmean(ind);

modelfun = @(b,x)(b(1)+b(2)*x);
beta0 = [100;-50];
y(y>100)=NaN;
beta = nlinfit(x,y,modelfun,beta0)
Tp=Tmean-beta(2)*xx/100;
T2_revised=para-beta(2)*concentration;
qf_save(T2_revised,strcat('Corrected-T2_KT_withHole_flowout_Correction.nii.gz'))
a40_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,'KT-withHole',seg,wm,gm)
    
fslqf('fslcpgeom ../struct.nii.gz Corrected-T2_KT_withHole_flowout_Correction.nii.gz')                   
fslqf('fslswapdim Corrected-T2_KT_withHole_flowout_Correction.nii.gz -x y z Corrected-T2_KT_withHole_flowout_Correction.nii.gz')
cd (addr);












