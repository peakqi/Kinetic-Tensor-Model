function a13_fix_mask0diffusivity

'a13_fix_mask0diffusivity.m '

addpath('/vols/Data/km/fengqi/NIfTI');
load('parameter.mat');
cd ('WorkingFolder')

L1=qf_load('nodark_L1.nii.gz');
L2=qf_load('nodark_L2.nii.gz');
L3=qf_load('nodark_L3.nii.gz');
% T2=qf_load('T2.nii.gz');
% struc=qf_load('struct.nii.gz');
mask=qf_load('mask_dti.nii.gz');
s=size(L1);
X=L1*0;
for ii=1:s(1)
    X(ii,:,:)=X(ii,:,:)*0+ii;
end

s=size(L1);
Y=L1*0;
for ii=1:s(2)
    Y(:,ii,:)=Y(:,ii,:)*0+ii;
end

s=size(L1);
Z=L1*0;
for ii=1:s(3)
    Z(:,:,ii)=Z(:,:,ii)*0+ii;
end


mask_pt0=single((L1.*mask)<=0)-(1-mask);





var=L1;
v=[];
for kk=-1:1
    for ll=-1:1
        for mm=-1:1
            ax=circshift(var,kk,1);
            ay=circshift(ax,ll,2);
            az=circshift(ay,mm,3);
            v=cat(4,v,az);
           
        end
        
    end
end
vmax=max(v,[],4);
nodark=var.*single(1-mask_pt0)+vmax.*mask_pt0;
qf_save(nodark,'nopt_L1.nii.gz')


var=L2;
v=[];
for kk=-1:1
    for ll=-1:1
        for mm=-1:1
            ax=circshift(var,kk,1);
            ay=circshift(ax,ll,2);
            az=circshift(ay,mm,3);
            v=cat(4,v,az);
           
        end
        
    end
end
vmax=max(v,[],4);
nodark=var.*single(1-mask_pt0)+vmax.*mask_pt0;
qf_save(nodark,'nopt_L2.nii.gz')


var=L3;
v=[];
for kk=-1:1
    for ll=-1:1
        for mm=-1:1
            ax=circshift(var,kk,1);
            ay=circshift(ax,ll,2);
            az=circshift(ay,mm,3);
            v=cat(4,v,az);
           
        end
        
    end
end
vmax=max(v,[],4);
nodark=var.*single(1-mask_pt0)+vmax.*mask_pt0;
qf_save(nodark,'nopt_L3.nii.gz')

cd ..
