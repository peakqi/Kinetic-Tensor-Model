function aa0_construct_corrected_homogeneity_matrix
nm{1}='date20181109-exponentialCTL10-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{2}='date20181109-exponentialCTL11-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{3}='date20181109-exponentialCTL12-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{4}='date20181109-exponentialMND12-homogeneity.mat';%; 238     0.2KB/s   00:00    
nm{5}='date20181109-exponentialMND13-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{6}='date20181109-exponentialMND14-homogeneity.mat';%; 240     0.2KB/s   00:00    
nm{7}='date20181109-exponentialMND15-homogeneity.mat';%; 238     0.2KB/s   00:00    
nm{8}='date20181109-exponentialMND16-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{9}='date20181109-exponentialMND17-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{10}='date20181109-exponentialMND18-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{11}='date20181109-exponentialMND19-homogeneity.mat';%; 239     0.2KB/s   00:01    
nm{12}='date20181109-exponentialMND20-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{13}='date20181109-exponentialMND21-homogeneity.mat';%; 239     0.2KB/s   00:00    
nm{14}='date20181109-exponentialMND23-homogeneity.mat';%; 237     0.2KB/s   00:00    
nm{15}='date20181109-exponentialMND24-homogeneity.mat';

for ii=1:15
    load(nm{ii})
    if ii==1
    v=cat(2,homogeneity(1,:),homogeneity(2,:));
    else
        temp=cat(2,homogeneity(1,:),homogeneity(2,:))
        v=cat(1,v,temp);
    end
end