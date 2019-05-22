function a40_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,name,seg,wm,gm)
figure 
hold on

cc=reshape(concentration,210*176*240,1);
pp=reshape(para,210*176*240,1);
ss=reshape(seg,210*176*240,1);

IND=((cc~=0) &(cc~=1)&(pp>5));
interval=200;
ind_wm=IND&(ss==wm);
indwmnonzero=find(ind_wm);
scatter(cc(indwmnonzero(1:interval:end)),pp(indwmnonzero(1:interval:end)),'r.');
ind_wm=IND&(ss==gm);
indwmnonzero=find(ind_wm);
scatter(cc(indwmnonzero(1:interval:end)),pp(indwmnonzero(1:interval:end)),'b.');


plot(xw,yw,'r*')
plot(xg,yg,'b*')
plot(x,modelfun(beta,x),'g*')
plot(x,y-x*beta(2),'ko')
plot(x,y,'k*')

xlabel('concentration')
ylabel('T2 (ms)')
title(strcat(name,'<beta0=',num2str(beta(1)),'>,','<beta1=',num2str(beta(2)),'>'))
saveas(gcf,strcat('/Users/fengqi/Documents/MND_REGISTRATION/MND21_code/',name,'-correct.jpeg'))
