function a0_Para_MND17


name='MND17'



index=8
durationFrame=4


thr_BrightRing=0.0004;
thr_dark=0.0001;
flowin_days=178
tau=86.4
flowout_days=2
flowout_pic=20
secondsPday=86400  


t=datetime;
DateNum=datenum(t);
concentrationRegressionRange=[5,95]
WorkingFolder=strcat('WorkingFolder');
mkdir(WorkingFolder);
save('parameter.mat')
save(strcat('../parameter-',name,'.mat'))




