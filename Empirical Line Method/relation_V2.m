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

%Channels Valores digitales de los targets obtenidos con fotos de un tiempo de exposición
%fijo de 500 us
% greenC = [201.278	139.844	112.748	91.008	77.237	66.280	55.776	47.139  40.961];
% redC = [200.180	141.397	115.277	93.581	79.493	68.522	57.795	48.670	42.757];
% nirC = [206.122	146.110	118.905	97.483	83.170	71.859	60.991	51.949	45.597];

%Channels Valores digitales de los targets obtenidos con fotos de un tiempo de exposición
%fijo de 1250 us
% greenC = [254.866	217.939	195.816	174.039	151.522	134.467	118.545	100.336	87.061];
% redC =  [246.204	218.171	195.880	174.185	152.886	139.768	119.381	100.953	87.326];
% nirC =  [253.157	223.015	200.843	180.444	159.373	143.023	126.269	108.194	94.574];

%Channels Valores digitales de los targets obtenidos con fotos de un tiempo de exposición
%fijo de 1000 us
greenC = [250.140	202.657	176.774	153.504	131.982	114.813	99.135	83.114	72.220];
redC =  [250.615	203.400	177.687	154.312	133.086	115.698	100.254	84.134	73.513];
nirC =  [249.131	207.735	182.670	160.955	140.019	120.517	106.142	90.227	79.738];

%Channels Valores digitales de los targets obtenidos con fotos de un tiempo de exposición
%fijo de 500 us (cambio sutil)
% greenC = [199.278	139.844	112.748	91.008	77.237	66.280	55.776	47.139  40.961];
% redC = [198.180	141.397	115.277	93.581	79.493	68.522	57.795	48.670	42.757];
% nirC = [204.122	146.110	118.905	97.483	83.170	71.859	60.991	51.949	45.597];


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
axis([(greenC(:,end)-20) 256 0.5 4])
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
axis([(greenC(:,end)-20) 256 0.5 4])
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
axis([(greenC(:,end)-20), 256, 0.5, 4])
xlabel('DN (0-255)')
ylabel('-ln(refl.)')
legend('NIR Channel', 'fitted curve')
xlim=get(gca,'XLim');
ylim=get(gca,'YLim');
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.7*ylim(2),strcat('y=',num2str(fNirL.p1),'x + ',num2str(fNirL.p2)))
text(2*xlim(1)+0.2*xlim(2),0.3*ylim(1)+0.66*ylim(2),strcat('R^2=',num2str(-Rnirl(1,2))))