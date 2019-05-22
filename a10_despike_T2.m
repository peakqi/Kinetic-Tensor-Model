function a10_despike_T2
'a10_despike_T2'
addpath('/vols/Data/km/fengqi/NIfTI');
load('parameter.mat');
cd ('WorkingFolder')
T2=qf_load('T2_hasSpike.nii.gz');
struct=qf_load('struct_to_diff.nii.gz');
%mask=qf_load('mask_dti.nii.gz');
thr_Bright=300;
s=size(T2);
X=T2*0;
for ii=1:s(1)
    X(ii,:,:)=X(ii,:,:)*0+ii;
end

s=size(T2);
Y=T2*0;
for ii=1:s(2)
    Y(:,ii,:)=Y(:,ii,:)*0+ii;
end

s=size(T2);
Z=T2*0;
for ii=1:s(3)
    Z(:,:,ii)=Z(:,:,ii)*0+ii;
end

maskbright=single(T2>thr_Bright);
sum(sum(sum(maskbright)))
%l_T2=reshape(T2,210*240*176,1);


l_X=reshape(X,210*240*176,1);
l_x=l_X/max(l_X);
l_Y=reshape(Y,210*240*176,1);
l_y=l_Y/max(l_Y);
l_Z=reshape(Z,210*240*176,1);
l_z=l_Z/max(l_Z);
l_T2=reshape(T2,210*240*176,1);
l_T2=l_T2/max(l_T2);
l_ST=reshape(struct,210*240*176,1);
l_st=l_ST/max(l_ST);
l=single(l_ST>0);


l_br=reshape(maskbright,s(1)*s(2)*s(3),1);
k_br=find(l_br);
k_gd=find((1-l_br).*l);


x0=l_st(k_gd);
x1=l_x(k_gd);
x2=l_y(k_gd);
x3=l_z(k_gd);
x4=l_T2(k_gd);


y0=l_st(k_br);
y1=l_x(k_br);
y2=l_y(k_br);
y3=l_z(k_br);
szy=size(y1);
szy(1)
flag=0
for ii=1:szy(1)
    ii
    flag=1
    t0=y0(ii);
    t1=y1(ii);
    t2=y2(ii);
    t3=y3(ii);

   d= (t0-x0).^2+(t1-x1).^2+(t2-x2).^2+(t3-x3).^2;
    [a,ind(ii)]=min(d);

end

if flag==1 %to avoid ind doesnt exist ie no spike
    y4=x4(ind);

    ii=ii-1
    l_T2(k_br(1:ii))=y4(1:ii);
    L=reshape(T2,s(1)*s(2)*s(3),1);
    c_T2=reshape(l_T2,s(1),s(2),s(3));
    qf_save(c_T2*max(L),'T2_nospike.nii.gz')
else
    qf_save(T2,'T2_nospike.nii.gz')
end



cd ..
