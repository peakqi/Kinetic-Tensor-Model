function [x,y]= a_comp_fit(concentration,bin,ra,mask,para)

xx=0:bin:100; 
xx=xx/100;
sz=size(xx);

if ra(2)>1
ra=ra/100;
else
end



for jj=1:sz(2)-1
   
        ind1=(concentration<=xx(jj+1)&concentration>xx(jj) &(mask>0)); 
        Tj=ind1.*para; 
        nzTj=Tj(find(Tj));
        Tn(jj)=max(size(nzTj));
        Tmean(jj)=mean(nzTj);        
        Tcount{jj}=size(nzTj);    
        TCount(jj)=Tcount{jj}(1);
end

[a1,b1]=min(abs(ra(1)-xx));
[a2,b2]=min(abs(ra(2)-xx));

x = xx(b1:b2);
y = Tmean(b1:b2);
n = Tn(b1:b2)