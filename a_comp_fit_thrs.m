function [x,y]= a_comp_fit_thrs(concentration,bin,ra,mask,para,thr)

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

ll=1;nn(ll)=0;in=1;
for ii=b1:b2
    if nn(ll)<thr
        XX{ll}(in)=xx(ii);
        NN{ll}(in)=Tn(ii);
        YY{ll}(in)=Tmean(ii);
        nn(ll)=sum(NN{ll});
        in=in+1;
    else 
        y(ll)=sum(YY{ll}.*NN{ll})/sum(NN{ll});
        x(ll)=sum(XX{ll}.*NN{ll})/sum(NN{ll});
        n(ll)=sum(NN{ll});
        ll=ll+1;
        nn(ll)=0;
        in=1;
    end
end
aaa=1
