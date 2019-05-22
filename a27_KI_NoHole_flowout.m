function a27_KI_NoHole_flowout

'a27_KI_NoHole_flowout.m '

holeflag=0 %??  
KIKT=0 %1KT        


addr=pwd;
if isempty(strfind(pwd,'Documents')) % empty is cluster
    addpath('/vols/Data/km/fengqi/NIfTI');
    addpath(addr)
else %found Documents is MAC
    
end



load('parameter.mat');
cd ('WorkingFolder')

try
days=flowout_days
pic=flowout_pic
catch ee
    days=2
     pic=20
     tau=86.4
flowout_days=2
flowout_pic=20
secondsPday=86400 
end


iteration=round(secondsPday*days/tau)
interval=round(iteration/pic)


img=load_nii('nopt_L1.nii.gz');
L1=img.img;
img=load_nii('nopt_L2.nii.gz');
L2=img.img;
img=load_nii('nopt_L3.nii.gz');
L3=img.img;

img=load_nii('dti_V1.nii.gz');
V1=img.img;
img=load_nii('dti_V2.nii.gz');
V2=img.img;
img=load_nii('dti_V3.nii.gz');
V3=img.img;

img=load_nii('mask_dti.nii.gz');
maskhole=img.img;

mkdir sim_KI_NoHole_flowout
cd sim_KI_NoHole_flowout


if holeflag==1
    mask=maskhole;
else
   a_FillHole
   mask=qf_load('mask_holefilled.nii.gz');
end


dif=single(mask)-single(maskhole);


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


d= tau;%tau for time interval, unit second
D= 1; %spatial interval unit mm.


if KIKT==1
    dti{1,1}=V1(:,:,:,1).*L1(:,:,:).*V1(:,:,:,1)+V2(:,:,:,1).*L2(:,:,:).*V2(:,:,:,1)+V3(:,:,:,1).*L3(:,:,:).*V3(:,:,:,1);
    dti{1,2}=V1(:,:,:,1).*L1(:,:,:).*V1(:,:,:,2)+V2(:,:,:,1).*L2(:,:,:).*V2(:,:,:,2)+V3(:,:,:,1).*L3(:,:,:).*V3(:,:,:,2);
    dti{1,3}=V1(:,:,:,1).*L1(:,:,:).*V1(:,:,:,3)+V2(:,:,:,1).*L2(:,:,:).*V2(:,:,:,3)+V3(:,:,:,1).*L3(:,:,:).*V3(:,:,:,3);
    dti{2,1}=V1(:,:,:,2).*L1(:,:,:).*V1(:,:,:,1)+V2(:,:,:,2).*L2(:,:,:).*V2(:,:,:,1)+V3(:,:,:,2).*L3(:,:,:).*V3(:,:,:,1);
    dti{2,2}=V1(:,:,:,2).*L1(:,:,:).*V1(:,:,:,2)+V2(:,:,:,2).*L2(:,:,:).*V2(:,:,:,2)+V3(:,:,:,2).*L3(:,:,:).*V3(:,:,:,2);
    dti{2,3}=V1(:,:,:,2).*L1(:,:,:).*V1(:,:,:,3)+V2(:,:,:,2).*L2(:,:,:).*V2(:,:,:,3)+V3(:,:,:,2).*L3(:,:,:).*V3(:,:,:,3);
    dti{3,1}=V1(:,:,:,3).*L1(:,:,:).*V1(:,:,:,1)+V2(:,:,:,3).*L2(:,:,:).*V2(:,:,:,1)+V3(:,:,:,3).*L3(:,:,:).*V3(:,:,:,1);
    dti{3,2}=V1(:,:,:,3).*L1(:,:,:).*V1(:,:,:,2)+V2(:,:,:,3).*L2(:,:,:).*V2(:,:,:,2)+V3(:,:,:,3).*L3(:,:,:).*V3(:,:,:,2);
    dti{3,3}=V1(:,:,:,3).*L1(:,:,:).*V1(:,:,:,3)+V2(:,:,:,3).*L2(:,:,:).*V2(:,:,:,3)+V3(:,:,:,3).*L3(:,:,:).*V3(:,:,:,3);
    szd=size(dif);
    ran1=0.003+0.00005*rand(szd);
    dti{1,1}(dif==1)=ran1(dif==1);
    ran1=0.003+0.00005*rand(szd);
    dti{2,2}(dif==1)=ran1(dif==1);
    ran1=0.003+0.00005*rand(szd);
    dti{3,3}(dif==1)=ran1(dif==1);
   
else
    [MD_gm,MD_wm,MD_2]=a_Calc_meanDiffusivity;
    diffusivity=MD_2;
    dti{1,1}=mask*diffusivity;
    dti{1,2}=mask*0;
    dti{1,3}=mask*0;
    dti{2,1}=mask*0;
    dti{2,2}=mask*diffusivity;
    dti{2,3}=mask*0;
    dti{3,1}=mask*0;
    dti{3,2}=mask*0;
    dti{3,3}=mask*diffusivity;
    
end


sourcemask=mask;

for ii=1:3
    cp=dti{1,1}*0;
    for jj=1:3
        cr=circshift(dti{ii,jj},-1,ii); %cr is c(i+1)
        cl=circshift(dti{ii,jj},+1,ii); %cl is c(i-1)
        cp=(cr-cl)/(2*D)+cp;
    end
    Db{ii}=cp;
end
        
        
D11=dti{1,1};
D12=dti{1,2};
D13=dti{1,3};
D21=dti{2,1};
D22=dti{2,2};
D23=dti{2,3};
D31=dti{3,1};
D32=dti{3,2};
D33=dti{3,3};
D11dx=(circshift(D11,-1,1)-circshift(D11,+1,1))/2/D;
D12dx=(circshift(D12,-1,1)-circshift(D12,+1,1))/2/D;
D13dx=(circshift(D13,-1,1)-circshift(D13,+1,1))/2/D;
D21dy=(circshift(D21,-1,2)-circshift(D21,+1,2))/2/D;
D22dy=(circshift(D22,-1,2)-circshift(D22,+1,2))/2/D;
D23dy=(circshift(D23,-1,2)-circshift(D23,+1,2))/2/D;  
D31dz=(circshift(D31,-1,3)-circshift(D31,+1,3))/2/D;
D32dz=(circshift(D32,-1,3)-circshift(D32,+1,3))/2/D;
D33dz=(circshift(D33,-1,3)-circshift(D33,+1,3))/2/D; 
DX=D11dx+D21dy+D31dz;
DY=D12dx+D22dy+D32dz;
DZ=D13dx+D23dy+D33dz;

c=sourcemask;

mov1=[]

DD=D*D;

for tt=1:iteration     
  
   
    c000=c;%1
    cp00=circshift(c,-1,1);%2
    cn00=circshift(c,+1,1);%3
    c0p0=circshift(c,-1,2);%4
    c0n0=circshift(c,+1,2);%5
    c00p=circshift(c,-1,3);%6
    c00n=circshift(c,+1,3); %7   
    cpp0=circshift(cp00,-1,2);%8
    cpn0=circshift(cp00,+1,2);%9
    cnp0=circshift(cn00,-1,2);%10
    cnn0=circshift(cn00,+1,2);%11
    cp0p=circshift(cp00,-1,3);%12
    cp0n=circshift(cp00,+1,3);%13
    cn0p=circshift(cn00,-1,3);%14
    cn0n=circshift(cn00,+1,3);%15
    c0pp=circshift(c0p0,-1,3);%16
    c0pn=circshift(c0p0,+1,3);%17
    c0np=circshift(c0n0,-1,3);%18
    c0nn=circshift(c0n0,+1,3);%19
    
    c=(DX.*(cp00-cn00)/2/D+DY.*(c0p0-c0n0)/2/D+DZ.*(c00p-c00n)/D/2+...
        D11.*(cp00+cn00-2*c000)/DD+D22.*(c0p0+c0n0-2*c000)/DD+D33.*(c00p+c00n-2*c000)/DD+...
        D12.*(cpp0+cnn0-cpn0-cnp0)/2/DD+D13.*(cp0p+cn0n-cp0n-cn0p)/2/DD+D23.*(c0pp+c0nn-c0np-c0pn)/2/DD)*d+c;
    
    c=c.*mask;    
    c(c>1)=1;
    c(c<0)=0;
   
   if rem(tt,interval)==1
        tt
       mov1=cat(4,mov1,c);
       disp(max(max(max(c))))
       disp(min(min(min(c))))
       disp(strcat('step:',num2str(round(tt/interval)) ) )
       mk=make_nii(mov1);
       save_nii(mk,'test_flowout.nii.gz')
   end

end
 
    
img=make_nii(mov1);
save_nii(img,'sim_KI_NoHole_flowout.nii.gz')
cd (addr)
