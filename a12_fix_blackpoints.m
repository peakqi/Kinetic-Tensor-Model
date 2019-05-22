function a12_fix_blackpoints

'a12_fix_blackpoints.m'
% partial volume and black points in middle
addpath('/vols/Data/km/fengqi/NIfTI');

load('parameter.mat');
cd ('WorkingFolder')


L1=qf_load('noring_L1.nii.gz');
L2=qf_load('noring_L2.nii.gz');
L3=qf_load('noring_L3.nii.gz');
% T2=qf_load('T2_nospike.nii.gz');
% struc=qf_load('struct_to_diff.nii.gz');
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

dk=L1.*mask;
mask_dk=single(dk<0.0001).*mask;
se = strel('square',5);

for zz=1:176
BW1(:,:,zz) = single(edge(mask(:,:,zz),'Canny'));
end

for zz=1:176
    ia=single(BW1(:,:,zz));
    if sum(sum(ia))>0
       BW2(:,:,zz) = imdilate(BW1(:,:,zz),se);
    else
        BW2(:,:,zz)=BW1(:,:,zz);
    end
end
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
nodarkring=var.*single(1-mask_dk)+vmax.*mask_dk;
nodark=nodarkring.*BW2+var.*(1-BW2);
qf_save(nodark,'nodark_L1.nii.gz')



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
nodarkring=var.*single(1-mask_dk)+vmax.*mask_dk;
nodark=nodarkring.*BW2+var.*(1-BW2);
qf_save(nodark,'nodark_L2.nii.gz')



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
nodarkring=var.*single(1-mask_dk)+vmax.*mask_dk;
nodark=nodarkring.*BW2+var.*(1-BW2);

qf_save(nodark,'nodark_L3.nii.gz')
cd ..