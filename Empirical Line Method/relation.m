close all
clear all
greenBand = 552;
redBand = 638;
nirBand = 833;
number = {'05','20','30','40','50','60','70','80','90'};
greenWb = [];
redWb = [];
nirWb = [];

for i = 1:9
    load(strcat(number{i},'-mean.mat'));
    greenWb(i)=mean(greenBand-324);
    redWb(i)=mean(redBand-324);
    nirWb(i)=mean(nirBand-324);
end
num = cell2mat(cellfun(@str2num,number(1:end),'un',0));
plot(num,greenWb, '-dg')
hold on
plot(num,redWb, '-or')
hold on
plot(num,nirWb, '-sk')
hold on
xlabel('Calibration Panel Grayscale (%)'); ylabel('Calibration Panel Reflectance Value');legend('Green', 'Red', 'NIR');

greenRegion = 530:590;
redRegion = 590:680;
nirRegion = 807:867;

%Channels 
greenC = [231.28324	182.61661 157.59558 133.05553 115.64971 102.272485 88.06262 73.56829 65.44131];
redC = [230.30359 184.11275 160.00092 135.93983 118.45786 104.62455 91.12258 76.934258 69.15298];
nirC = [236.344314 191.71033 168.87492 145.984 128.48921 115.07987 101.26735 86.2747 78.31113];

%% Exponential models
figure(2)
fGreen = fit(greenC',greenWb','exp1')
Rg = corrcoef(greenC,greenWb)
plot(fGreen,greenC,greenWb,'*g')
xlabel('DN (0-255)')
ylabel('Reflectance')
legend('Green Channel', 'fitted curve')
xlim=get(gca,'XLim');
ylim=get(gca,'YLim');
text(0.8*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.7*ylim(2),strcat('y=',num2str(fGreen.a),'exp(',num2str(fGreen.b),'x)'))
text(0.8*xlim(1)+0.2*xlim(2),0.25*ylim(1)+0.65*ylim(2),strcat('R^2=',num2str(Rg(1,2))))

figure(3)
fRed = fit(redC',redWb','exp1')
Rr = corrcoef(redC,redWb)
plot(fRed,redC,redWb,'*b')
xlabel('DN (0-255)')
ylabel('Reflectance')
legend('Red Channel', 'fitted curve')
xlim=get(gca,'XLim');
ylim=get(gca,'YLim');
text(0.8*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.7*ylim(2),strcat('y=',num2str(fRed.a),'exp(',num2str(fRed.b),'x)'))
text(0.8*xlim(1)+0.2*xlim(2),0.25*ylim(1)+0.65*ylim(2),strcat('R^2=',num2str(Rr(1,2))))

figure(4)
fNir = fit(nirC',nirWb','exp1')
Rnir = corrcoef(nirC,nirWb)
plot(fNir,nirC,nirWb,'*k')
xlabel('DN (0-255)')
ylabel('Reflectance')
legend('NIR Channel', 'fitted curve')
xlim=get(gca,'XLim');
ylim=get(gca,'YLim');
text(0.8*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.7*ylim(2),strcat('y=',num2str(fNir.a),'exp(',num2str(fNir.b),'x)'))
text(0.8*xlim(1)+0.2*xlim(2),0.25*ylim(1)+0.65*ylim(2),strcat('R^2=',num2str(Rnir(1,2))))

%% Linear transformation
figure(5)
x=greenC;
y = -log(fGreen.a)-fGreen.b*greenC;
y1 = -log(greenWb);
fGreenL = fit(x',y1','poly1')
Rgl = corrcoef(x,y1)
plot(fGreenL,x,y1,'*g')
axis([60 250 0.5 4])
xlabel('DN (0-255)')
ylabel('-ln(refl.)')
legend('Green Channel', 'fitted curve')
xlim=get(gca,'XLim');
ylim=get(gca,'YLim');
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.7*ylim(2),strcat('y=',num2str(fGreenL.p1),'x + ',num2str(fGreenL.p2)))
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.66*ylim(2),strcat('R^2=',num2str(-Rgl(1,2))))

figure(6)
x=redC;
y = -log(fRed.a)-fRed.b*redC;
y1 = -log(redWb);
fRedL = fit(x',y1','poly1')
Rrl = corrcoef(x,y1)
plot(fRedL,x,y1,'*b')
axis([60 250 0.5 4])
xlabel('DN (0-255)')
ylabel('-ln(refl.)')
legend('Red Channel', 'fitted curve')
xlim=get(gca,'XLim');
ylim=get(gca,'YLim');
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.7*ylim(2),strcat('y=',num2str(fRedL.p1),'x + ',num2str(fRedL.p2)))
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.66*ylim(2),strcat('R^2=',num2str(-Rrl(1,2))))


figure(7)
x=nirC;
y = -log(fNir.a)-fNir.b*nirC;
y1 = -log(nirWb);
fNirL = fit(x',y1','poly1')
Rnirl = corrcoef(x,y1)
plot(fNirL,x,y1,'*k')
axis([60 250 0.5 4])
xlabel('DN (0-255)')
ylabel('-ln(refl.)')
legend('NIR Channel', 'fitted curve')
xlim=get(gca,'XLim');
ylim=get(gca,'YLim');
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.7*ylim(2),strcat('y=',num2str(fNirL.p1),'x + ',num2str(fNirL.p2)))
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.66*ylim(2),strcat('R^2=',num2str(-Rnirl(1,2))))