function a11_fix_L1brightring

flag=0
'a11_fix_L1brightring.m '
addpath('/vols/Data/km/fengqi/NIfTI');

load('parameter.mat');
cd ('WorkingFolder')

thr_BrightRing

img=load_nii('struct_to_diff.nii.gz');
struct=img.img;

img=load_nii('dti_L1.nii.gz');
L1=img.img;
szl1=size(L1);
if length(szl1==3)
else
    a110_process_L1doubleframe;
    img=load_nii('dti_L1.nii.gz');
    L1=img.img;
end

img=load_nii('dti_L2.nii.gz');
L2=img.img;
img=load_nii('dti_L3.nii.gz');
L3=img.img;
flag=1
if flag==1
        thr_BrightRing

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

        maskbright=single(L1>thr_BrightRing);
        sum(sum(sum(maskbright)))
        l_L1=reshape(L1,210*240*176,1);
        l_L2=reshape(L2,210*240*176,1);
        l_L3=reshape(L3,210*240*176,1);
        l_X=reshape(X,210*240*176,1);
        l_x=l_X/max(l_X);
        l_Y=reshape(Y,210*240*176,1);
        l_y=l_Y/max(l_Y);
        l_Z=reshape(Z,210*240*176,1);
        l_z=l_Z/max(l_Z);


        l_ST=reshape(struct,210*240*176,1);
        l_st=l_ST/max(l_ST);
        l=single(l_ST>0);


        l_br=reshape(maskbright,210*240*176,1);
        k_br=find(l_br);
        k_gd=find((1-l_br).*l);


        x0=l_st(k_gd);
        x1=l_x(k_gd);
        x2=l_y(k_gd);
        x3=l_z(k_gd);
        x4=l_L1(k_gd);
        x5=l_L2(k_gd);
        x6=l_L3(k_gd);

        y0=l_st(k_br);
        y1=l_x(k_br);
        y2=l_y(k_br);
        y3=l_z(k_br);
        szy=size(y1);
        szy(1)
        for ii=1:szy(1)

            t0=y0(ii);
            t1=y1(ii);
            t2=y2(ii);
            t3=y3(ii);

           d= (t0-x0).^2+(t1-x1).^2+(t2-x2).^2+(t3-x3).^2;
            [a,ind(ii)]=min(d);

        end

        y4=x4(ind);
        y5=x5(ind);
        y6=x6(ind);
        ii=ii-1
        l_L1(k_br(1:ii))=y4(1:ii);
        l_L2(k_br(1:ii))=y5(1:ii);
        l_L3(k_br(1:ii))=y6(1:ii);

        c_L1=reshape(l_L1,210,240,176);
        qf_save(c_L1,'noring_L1.nii.gz')
        c_L2=reshape(l_L2,210,240,176);
        qf_save(c_L2,'noring_L2.nii.gz')
        c_L3=reshape(l_L3,210,240,176);
        qf_save(c_L3,'noring_L3.nii.gz')
        
else
    
        qf_save(L1,'noring_L1.nii.gz')
        qf_save(L2,'noring_L2.nii.gz')
        qf_save(L3,'noring_L3.nii.gz')
    
    
end
cd ..