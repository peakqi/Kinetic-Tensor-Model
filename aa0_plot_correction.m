function aa0_plot_correction(x,y,xw,yw,xg,yg,modelfun,beta,concentration,para,name,seg,wm,gm,durationFrame,fitmethod,y_shadow,yw_shadow,yg_shadow,y_revised,yw_revised,yg_revised,MND_ID)
if strcmp(name,'KI-NoHole')
    subplot(4,3,1)
elseif strcmp(name,'KI-withHole')
    subplot(4,3,2)
elseif strcmp(name,'KT-withHole')
     subplot(4,3,3)
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


plot(xw,yw,'r*')
plot(xg,yg,'b*')
plot(x,y,'k*')
plot(xw,modelfun(beta,xw),'g*')

if strcmp(fitmethod,'linear')
    plot(x,y-x*beta(2),'ko')
elseif strcmp(fitmethod,'exponential')
    plot(x,y-modelfun(beta,x)+beta(2)+beta(1),'ko')
    
end



xlabel('concentration')
ylabel('T2 (ms)')
ylim([0,50])
title(strcat(MND_ID))
% saveas(gcf,strcat('date0612',name,'-',num2str(durationFrame),'-',fitmethod,'-correct.jpg'))

if strcmp(name,'KI-NoHole')
    subplot(4,3,4)
elseif strcmp(name,'KI-withHole')
    subplot(4,3,5)
elseif strcmp(name,'KT-withHole')
     subplot(4,3,6)
else
end


a_shadedplot(xw, yw_revised-yw_shadow, yw_revised+yw_shadow)
hold on
plot(xw,yw_revised,'r')


if strcmp(name,'KI-NoHole')
    subplot(4,3,7)
elseif strcmp(name,'KI-withHole')
    subplot(4,3,8)
elseif strcmp(name,'KT-withHole')
     subplot(4,3,9)
else
end

a_shadedplot(xg, yg_revised-yg_shadow, yg_revised+yg_shadow)
hold on
plot(xg,yg_revised,'b')


if strcmp(name,'KI-NoHole')
    subplot(4,3,10)
elseif strcmp(name,'KI-withHole')
    subplot(4,3,11)
elseif strcmp(name,'KT-withHole')
     subplot(4,3,12)
else
end
hold on
v=0:0.1:1;
contour(concentration(:,:,88),v)
colormap hot
