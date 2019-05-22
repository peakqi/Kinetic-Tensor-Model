function ac2_scatterplot_T2

%1=10%Formalin   2=10%NBF 3=20%NBF 4?
Stain{1,2}='MND12';
Stain{1,3}=1;
Stain{2,2}='MND13';
Stain{2,3}=1;
Stain{3,2}='MND14';
Stain{3,3}=3;
Stain{4,2}='MND15';
Stain{4,3}=1;
Stain{5,2}='MND16';
Stain{5,3}=1;
Stain{6,2}='MND17';
Stain{6,3}=1;
Stain{7,2}='MND18';
Stain{7,3}=2;
Stain{8,2}='MND19';
Stain{8,3}=4;
Stain{9,2}='MND20';
Stain{9,3}=1;
Stain{10,2}='MND21';
Stain{10,3}=2;
Stain{11,2}='MND22';
Stain{11,3}=1;
Stain{12,2}='MND23';
Stain{12,3}=2;
Stain{13,2}='MND24';
Stain{13,3}=2;
Stain{14,2}='CTL10';
Stain{14,3}=2;
Stain{15,2}='CTL11';
Stain{15,3}=2;
Stain{16,2}='CTL12';
Stain{16,3}=2;

NM{1}='T2-hasSpike';
NM{2}='T2-NoSpike';
NM{3}='KI-NoHole';
NM{4}='KI-withHole';
NM{5}='KT-withHole';
%1=10%
%2=10%NBF
%3=20%NBF
%4=?
%kk T2 T2_nospk KI KIhole KThole
%tot,GM,WM

for kk=1
    figure
    hold on
    for ii=1:16
        ii
        try
            load(strcat('T2_mean_std_',Stain{ii,2},'.mat'))
            if Stain{ii,3}==1
              ploterr(mn(3,kk),mn(2,kk),sd(3,kk),sd(2,kk),'r')
            elseif Stain{ii,3}==2
                ploterr(mn(3,kk),mn(2,kk),sd(3,kk),sd(2,kk),'b')       
            elseif Stain{ii,3}==3
                ploterr(mn(3,kk),mn(2,kk),sd(3,kk),sd(2,kk),'g')
            elseif Stain{ii,3}==4
                ploterr(mn(3,kk),mn(2,kk),sd(3,kk),sd(2,kk),'k')
            end
            
        catch eee
        end
    end
    title(strcat(NM{kk}))
    
    aa=1
end