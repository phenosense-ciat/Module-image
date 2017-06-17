close all
clear all
x=325:1:1075;
load('05-mean.mat')
figure('units','normalized','outerposition',[0 0 1 1])
plot(x,mean)
hold on
load('20-mean.mat')
plot(x,mean,'r')
hold on
load('30-mean.mat')
plot(x,mean,'k')
load('40-mean.mat')
hold on
plot(x,mean,'g')
hold on
load('50-mean.mat')
plot(x,mean,'m')
hold on
load('60-mean.mat')
plot(x,mean,'c')
hold on
load('70-mean.mat')
plot(x,mean,'b')
hold on
load('80-mean.mat')
plot(x,mean,'r-')
hold on
load('90-mean.mat')
plot(x,mean,'k.')
hold on
axis([500 900 0 0.6])
xlabel('Wavelenght (nm)')
ylabel('Reflectance')
title('Medians')
legend('5% gray','20% gray','30% gray','40% gray','50% gray','60% gray','70% gray','80% gray','90% gray')