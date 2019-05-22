function a_FillHole

addpath('/vols/Data/km/fengqi/NIfTI');

mask=qf_load('../mask_dti.nii.gz');


sz=size(mask);

for ii=1:sz(1)
    ii
    
    im=squeeze(mask(ii,:,:));
    im=imfill(im,'holes');
    mask(ii,:,:)=im;
    
end


for ii=1:sz(2)
    ii
    
    im=squeeze(mask(:,ii,:));
    im=imfill(im,'holes');
    mask(:,ii,:)=im;
    
end

for ii=1:sz(3)
    ii
    
    im=squeeze(mask(:,:,ii));
    im=imfill(im,'holes');
    mask(:,:,ii)=im;
    
end






qf_save(mask,'mask_holefilled.nii.gz');
