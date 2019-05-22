function a36_T2_generateConcentrationContour

'a36_T2_generateConcentrationContour.m '

addr=pwd;
load('parameter.mat');
if isempty(strfind(pwd,'Documents')) % empty is cluster
    addpath('/vols/Data/km/fengqi/NIfTI');    
    kk=durationFrame
else %found Documents is MAC
    
    cd (strcat('/Users/fengqi/Documents/MND_REGISTRATION/',folder));
end



cd ('WorkingFolder')
mkdir sim_T2
cd sim_T2
img1=qf_load('../T2_nospike.nii.gz');


qf_save(img1,'T2_flowout_concentration.nii.gz');

cd (addr)


% 
% v=1:10:120;
% movsz=size(img1);
% for ii=1:movsz(3) % every layer ii
%     
%     ctr=img1(:,:,ii);
%     ctrline=ctr*0;
%     [C,h]=contour(ctr,v);
%     sC=size(C);
%     pt=1;
%     while pt<sC(2)
%         num=C(2,pt);
%         val=C(1,pt);
%         for jj=1:num
%            ctrline(round(C(2,jj+pt)),round(C(1,jj+pt)))=val; 
%         end
%         pt=pt+num+1;
%     end
%     
%     if ii==1
%         ConcentrationContour=ctrline;
%     else
%         ConcentrationContour=cat(3,ConcentrationContour,ctrline(1:210,1:240));
%     end
% end
%qf_save(ConcentrationContour,'T2_flowout_concentrationContour.nii.gz');
