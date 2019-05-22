function [durationFrame,MND_ID]=a_dataframe

dataframe{1}=5;
dataframe{2}=6;
dataframe{3}=5;
dataframe{4}=3;%MND15
dataframe{5}=NaN;
dataframe{6}=4;%MND16
dataframe{7}=NaN;
dataframe{8}=4;%MND17
dataframe{9}=NaN;
dataframe{10}=4;%MND18
dataframe{11}=4;%MND19
dataframe{12}=NaN;
dataframe{13}=5;%MND20
dataframe{14}=6;%MND21
dataframe{15}=5;%MND22
dataframe{16}=4;%MND23
dataframe{17}=5;%CTL10
dataframe{18}=5;%CTL11
dataframe{19}=5;%CTL12
dataframe{20}=4;%MND24
dataframe{21}=4;%CTL05
dataframe{22}=4;%CTL07




addpath('/vols/Data/km/fengqi/NIfTI');
folder_KTmodel{1}=strcat('/vols/Data/km/fengqi/KTmodel/','MND12');
folder_KTmodel{2}=strcat('/vols/Data/km/fengqi/KTmodel/','MND13');
folder_KTmodel{3}=strcat('/vols/Data/km/fengqi/KTmodel/','MND14');
folder_KTmodel{4}=strcat('/vols/Data/km/fengqi/KTmodel/','MND15');
folder_KTmodel{5}=strcat('/vols/Data/km/fengqi/KTmodel/','MND15_unused');
folder_KTmodel{6}=strcat('/vols/Data/km/fengqi/KTmodel/','MND16');
folder_KTmodel{7}=strcat('/vols/Data/km/fengqi/KTmodel/','MND16_unused');
folder_KTmodel{8}=strcat('/vols/Data/km/fengqi/KTmodel/','MND17');
folder_KTmodel{9}=strcat('/vols/Data/km/fengqi/KTmodel/','MND18_unused');
folder_KTmodel{10}=strcat('/vols/Data/km/fengqi/KTmodel/','MND18');
folder_KTmodel{11}=strcat('/vols/Data/km/fengqi/KTmodel/','MND19');
folder_KTmodel{12}=strcat('/vols/Data/km/fengqi/KTmodel/','MND19_unused');
folder_KTmodel{13}=strcat('/vols/Data/km/fengqi/KTmodel/','MND20');
folder_KTmodel{14}=strcat('/vols/Data/km/fengqi/KTmodel/','MND21');
folder_KTmodel{15}=strcat('/vols/Data/km/fengqi/KTmodel/','MND22');
folder_KTmodel{16}=strcat('/vols/Data/km/fengqi/KTmodel/','MND23');
folder_KTmodel{17}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL10');
folder_KTmodel{18}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL11');
folder_KTmodel{19}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL12');
folder_KTmodel{20}=strcat('/vols/Data/km/fengqi/KTmodel/','MND24');
folder_KTmodel{21}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL05');
folder_KTmodel{22}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL07');



ind=0;
for ii=1:numel(folder_KTmodel)

    if strcmp(pwd,folder_KTmodel{ii})
       ind=ii;
       durationFrame=dataframe{ii}
       MND_ID=folder_KTmodel{ii}(end-4:end)
     
    end
end





%     folder_KTmodel{1}=strcat('/vols/Data/km/fengqi/KTmodel/','MND12');
%         folder_KTmodel{2}=strcat('/vols/Data/km/fengqi/KTmodel/','MND13');
%         folder_KTmodel{3}=strcat('/vols/Data/km/fengqi/KTmodel/','MND14');
%         folder_KTmodel{4}=strcat('/vols/Data/km/fengqi/KTmodel/','MND15');
%         folder_KTmodel{5}=strcat('/vols/Data/km/fengqi/KTmodel/','MND15_unused');
%         folder_KTmodel{6}=strcat('/vols/Data/km/fengqi/KTmodel/','MND16');
%         folder_KTmodel{7}=strcat('/vols/Data/km/fengqi/KTmodel/','MND16_unused');
%         folder_KTmodel{8}=strcat('/vols/Data/km/fengqi/KTmodel/','MND17');
%         folder_KTmodel{9}=strcat('/vols/Data/km/fengqi/KTmodel/','MND18_unused');
%         folder_KTmodel{10}=strcat('/vols/Data/km/fengqi/KTmodel/','MND18');
%         folder_KTmodel{11}=strcat('/vols/Data/km/fengqi/KTmodel/','MND19');
%         folder_KTmodel{12}=strcat('/vols/Data/km/fengqi/KTmodel/','MND19_unused');
%         folder_KTmodel{13}=strcat('/vols/Data/km/fengqi/KTmodel/','MND20');
%         folder_KTmodel{14}=strcat('/vols/Data/km/fengqi/KTmodel/','MND21');
%         folder_KTmodel{15}=strcat('/vols/Data/km/fengqi/KTmodel/','MND22');
%         folder_KTmodel{16}=strcat('/vols/Data/km/fengqi/KTmodel/','MND23');
%         folder_KTmodel{17}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL10');
%         folder_KTmodel{18}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL11');
%         folder_KTmodel{19}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL12');
%         folder_KTmodel{20}=strcat('/vols/Data/km/fengqi/KTmodel/','MND24');
%         folder_KTmodel{21}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL05');
%         folder_KTmodel{22}=strcat('/vols/Data/km/fengqi/KTmodel/','CTL07');