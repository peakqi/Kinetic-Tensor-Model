function [x,y]= a_comp_fit_fullfit(concentration,bin,ra,mask,para)

xx=0:bin:100; 
xx=xx/100;
sz=size(xx);

if ra(2)>1
ra=ra/100;
else
end

ind1=(concentration<ra(2)&concentration>ra(1) &(mask>0)); 
Tj=ind1.*para;
y=Tj(find(Tj));
x=concentration(find(Tj));


