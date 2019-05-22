function ab3_correlation_Ferritin_ACC
%AnteriorCing,MotorLeg,V2,AC_normalised,MotorLegNormalised
%Acc 3n-2, mtr 3n-1, v2 3n
StainData=[13.49135832	45.75758212	15.27718644	21.842933	32.49753775	22.77311293	11.58289213	21.59825035	5.147344356	15.88526831	37.47309098	10.05910636	23.13833696	26.88012516	20.37113667	8.066007119	36.94415989	11.2633377	15.14368626	16.58796325	13.89888116	7.861377567	21.68220578	7.666503782	13.69063485	43.07541846	14.68488246	17.93915446	51.0357494	8.890694862	19.17937422	50.30480556	15.3690086	16.38955632	53.76177655	16.63928955	12.03804664	40.17749983	3.397441151	12.229788	73.63508538	15.83794906	11.44842059	42.72082205	10.78652219	27.6934194	40.56335089	12.46865731
0.5292742071	0.7277628876	0.7014029006	0.7320631086	0.8044900818	0.8555852623	0.2832224558	0.5796149637	0.6362286606	0.3879205346	0.6987467784	0.5579681921	0.4502988643	0.7095882444	0.5495701525	0.3762217924	0.5562103649	0.5295559678	0.3687879293	0.7147765889	0.7086782425	0.3278921218	0.5041693395	0.6665423783	0.2956978892	0.8406944559	0.4886474641	0.5286530636	0.6917147171	0.4378789826	0.671175408	0.7614372012	0.6648185191	0.3094780711	0.5142895897	0.7306009077	0.3163536336	0.5113202483	0.3048071227	0.5448198011	0.537906418	0.5217162557	0.1907249981	0.44610058	0.4355498293	0.7060127164	0.6310474412	0.4909268103]
Stain{1,1}=[    0.529274207	0.727762888	0.701402901 0.754593696	1.037581805     ];
Stain{1,2}='MND12'
Stain{1,3}=NaN;

Stain{2,1}=[    0.732063109	0.804490082	0.855585262	0.85562847	0.940280434		];
Stain{2,2}='MND13'
Stain{2,3}=NaN;

Stain{3,1}=[	0.283222456	0.579614964	0.636228661 0.445158279	0.911016745		];
Stain{3,2}='MND14';
Stain{3,3}=NaN;

Stain{4,1}=[	0.387920535	0.698746778	0.557968192 0.695237722	1.252305755		];
Stain{4,2}='MND15';
Stain{4,3}=NaN;

Stain{5,1}=[	0.450298864	0.709588244	0.549570153 0.819365576	1.291169546		];
Stain{5,2}='MND16';
Stain{5,3}=NaN;

Stain{6,1}=[	0.376221792	0.556210365	0.529555968 0.710447649	1.050333485		];
Stain{6,2}='MND17';
Stain{6,3}='MND17_ACC_FinalBar.mat';

Stain{7,1}=[	0.368787929	0.714776589	0.708678242 0.52038839	1.00860524		];
Stain{7,2}='MND18';
Stain{7,3}='MND18_ACC_FinalBar.mat';

Stain{8,1}=[	0.327892122	0.504169339	0.666542378 0.491929894	0.756395026		];
Stain{8,2}='MND19';
Stain{8,3}='MND19_ACC_FinalBar.mat';

Stain{9,1}=[	0.295697889	0.840694456	0.488647464 0.605135422	1.720451896		];
Stain{9,2}='MND20';
Stain{9,3}='MND20_ACC_FinalBar.mat';

Stain{10,1}=[	0.528653064	0.691714717	0.437878983 1.207304037	1.579693807		];
Stain{10,2}='MND21';
Stain{10,3}='MND21_ACC_FinalBar.mat';

Stain{11,1}=[	0.671175408	0.761437201	0.664818519 1.009561841	1.145330913		];
Stain{11,2}='MND22';
Stain{11,3}=NaN;

Stain{12,1}=[	0.309478071	0.51428959	0.730600908 0.423593877	0.703926842		];
Stain{12,2}='MND23';
Stain{12,3}='MND23_ACC_FinalBar.mat';

Stain{13,1}=[   0.316353634	0.511320248	0.304807123 1.037881368	1.677520669		];
Stain{13,2}='MND24';
Stain{13,3}='MND24_ACC_FinalBar.mat';

Stain{14,1}=[	0.544819801	0.537906418	0.521716256 1.044283737	1.031032505		];
Stain{14,2}='CTL10';
Stain{14,3}='CTL10_ACC_FinalBar.mat';

Stain{15,1}=[	0.190724998	0.44610058	0.435549829 0.437894783	1.024223981		];
Stain{15,2}='CTL11';
Stain{15,3}='CTL11_ACC_FinalBar.mat';

Stain{16,1}=[	0.706012716	0.631047441	0.49092681 1.438122143	1.285420612		];
Stain{16,2}='CTL12';
Stain{16,3}='CTL12_ACC_FinalBar.mat';


mdl{1}='EPG-T2';
mdl{2}='EPG-T2-despike';
mdl{3}='KI--NoHole-corrected-T2';
mdl{4}='KI-WithHole-corrected-T2';
mdl{5}='KT-WithHole-corrected-T2';

% tab  'Face_L	Face_R	Hand_L	Hand_R	Leg_L	Leg_R	Motor'
%EPG1
% EPG2
% KI1
% KI2
% KT
close all
for mdl_ind=1:5
    kk=1
    for mnd=1:16
        try
        load(Stain{mnd,3})
            PalegT2(kk)=mean(tab(mdl_ind,3) ) ;
            PalegFerr(kk)=StainData(2,3*mnd-2);%Acc 3n-2, mtr 3n-1, v2 3n
            kk=kk+1
        catch
          
        end
    end

   
    figure

    scatter(PalegT2,PalegFerr,'k')
    lsline
    hold on
    scatter(PalegT2(end-2:end),PalegFerr(end-2:end),'r')
    

    [R,PValue] = corr(PalegT2',PalegFerr');
    title(strcat(mdl{mdl_ind},'(R=',num2str(R),';P=',num2str(PValue),')'))
    saveas(gcf,strcat('FinalScatter-ACC-',mdl{mdl_ind},'.jpg'))
end



for mdl_ind=1:5
    kk=1
    for mnd=1:16
        try
        load(Stain{mnd,3})
            PalegT2(kk)=mean(tab_v2(mdl_ind,3) ) ;
            PalegFerr(kk)=StainData(2,3*mnd-2)/StainData(2,3*mnd);
            kk=kk+1
        catch
          
        end
    end

   
    figure

    scatter(PalegT2,PalegFerr,'k')
    lsline
    hold on
    scatter(PalegT2(end-2:end),PalegFerr(end-2:end),'r')
    

    [R,PValue] = corr(PalegT2',PalegFerr');
    title(strcat(mdl{mdl_ind},'-NormalisedV2(R=',num2str(R),';P=',num2str(PValue),')'))
    saveas(gcf,strcat('FinalScatter',mdl{mdl_ind},'-NormalisedV2.jpg'))
end




    