function aa0_plot_correction_fullfit(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,name,seg,wm,gm,durationFrame,fitmethod)
if strcmp(name,'KI-NoHole')
    subplot(2,3,1)
elseif strcmp(name,'KI-withHole')
    subplot(2,3,2)
elseif strcmp(name,'KT-withHole')
     subplot(2,3,3)
else
end
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


% plot(xw,yw,'r*')
% plot(xg,yg,'b*')
% plot(x,y,'k*')
x=0:0.01:1
plot(x,modelfun(beta,x),'g*')

% if strcmp(fitmethod,'linear')
%     plot(x,y-x*beta(2),'ko')
% elseif strcmp(fitmethod,'exponential')
%     plot(x,y-modelfun(beta,x)+beta(2)+beta(1),'ko')
%     
% end



xlabel('concentration')
ylabel('T2 (ms)')
ylim([0,50])
title(strcat(name,'<beta0=',num2str(beta(1)),'>,','<beta1=',num2str(beta(2)),'>',fitmethod))
% saveas(gcf,strcat('date0612',name,'-',num2str(durationFrame),'-',fitmethod,'-correct.jpg'))





