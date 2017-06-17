clear 
close all
numpre = '05';
pre = '-read'; %Prefijo del nombre del archivo
suf = '.asd.txt'; %Extención del archivo.
begin = 1; %Número inicial donde empieza las medidas espectrales NOTA: puede variarlo a conveniencia.
data = []; %Matriz vacia donde se almacenará la data de medidas espectrales de 325 nm a 1075 nm
miss = []; %Matriz vacia donde se almacenará datos espectrales que están olvidadas en la "data" y pasaron a ser "textdata".
for i = 1:10
    s = importdata(strcat(numpre,pre,num2str(begin+(i-1)),suf)); %Se importa los datos del archivo .asd.txt del ASD en variable matlab
    if(length(s.data(:,2))<751) %Se verifica si la longitud de la matriz de la data es correcta, de lo contrario, indica que hay datos perdidos en la data y están en el textdata.
        num = 751 - length(s.data(:,2)); %Se comprueba cuanta es la cantidad de datos perdidos al inicio (Se encontró que los datos que se omiten en la data y pasan al textdata son los que inician desde 325 nm. Ejemplo, si faltan 3 datos en data quiere decir que en "data" faltan los datos 325, 326 y 327, los cuales estan en "textdata".
        for j = 2:num+1 %Inicialización del ciclo de llenado de la matriz miss, empieza en 2 ya que en la posición inicial de "textdata" están los encabezados de las columnas de "data" que son 'Wavelength' y 'SpectrumXXX.asd' Los cuales no se pueden convertir en valores numericos.
           miss = [miss;str2num(s.textdata{j}(5:end))]; %Se llena o se concatena la matriz miss, donde cada dato perdido se obvia los 4 primero caracteres del string, porque corresponden a la longitud de onda correspondiente y por el momento este dato no es necesario.
        end
        data = [data, [miss;s.data(:,2)]]; %Finalmente la matriz se concatena con la anterior y así sucesivamente.
        miss = [];
    else
        data = [data, [s.data(:,2)]]; %En caso de que la longitud del "data" esté correcto que sea igual que el anterior por tanto se concatena normalmente.   
    end %Fin condicional de la longitud de "data"
end %Fin del ciclo de concatenado de las primeras 10 mediciones espectrales con 10 angulos diferentes para un solo target.
[p,tbl,stats] = anova1(data(77:576,:)); %Se realiza en analiza del ANOVA
% de los datos que se extrayeron. Acotandolos desde 400 nm hasta 900 nm que
% son el index 76 y 576 respectivamente, ya que los datos por encima o por
% debajo de estos son ruido.
% currentpath = cd('..')
cd
stats.means %mostrar estadistica de los datos, para verificar que las medias son parecidas
mean = [];
sum=0;
for i=1:length(data)
    for j =1:10
        sum = sum+data(i,j);
    end
    mean(i)=sum/10;
    sum=0;
end
figure(3)
x=325:1:1075;
plot(x,mean);xlabel('Wavelength (nm)');ylabel('Reflectance'); title(strcat('Target-',numpre,' %'))

figure(4)
for i=1:10
   plot(x,data(:,i), 'color', [0.5 0.5 0.5])
   hold on
end
p1= plot(x,mean,'k','LineWidth',1.5);xlabel('Wavelength (nm)');ylabel('Reflectance'); title(strcat('Target-',numpre,' %'))
axis([400 900 0.2 0.5])
legend(p1,'Mean')

% filename = '20-percent.mat' %Nombre del archivo a guardar. 
filename = strcat(numpre,'-percent-statis.mat') %guardar la estadistica de los datos adquiridos de means.
save(filename) %Guarda todas las variables del workspace en un archivo.mat
save(strcat(numpre,'-mean.mat'),'mean')
% num=10;
% test1 = data(77:576,num);
% x = (test1-stats.means(num))/std(test1);
% h = kstest(x)

%Part of analytics Kruskal Wallis Tests
p = kruskalwallis(data(77:576,:))

figure(7)
%Smoothing of curve
num = 10;
coef = ones(1,num)/num;
signal_out = zeros(751,10);
for i=1:10
    signal_out(:,i) = filter(coef, 1 ,data(:,i));
end

mean_smooth = [];
sum=0;
for i=1:length(signal_out)
    for j =1:10
        sum = sum+signal_out(i,j);
    end
    mean_smooth(i)=sum/10;
    sum=0;
end

for i=1:10
   plot(x,signal_out(:,i), 'color', [0.5 0.5 0.5])
   hold on
end
p1= plot(x,mean_smooth,'k','LineWidth',1.5);xlabel('Wavelength (nm)');ylabel('Reflectance'); title(strcat('Target-',numpre,' %'))
axis([400 900 0.2 0.5])
legend(p1,'Mean signal smooth')

save(strcat(numpre,'-mean_smooth.mat'),'mean');
xlswrite(strcat(numpre,'-data_smooth'),{'Wavelength vs Read Spectral', '1', '2', '3','4','5','6','7','8','9','10'},1,'A1');
xlswrite(strcat(numpre,'-data_smooth'),horzcat([325:1:1075]', signal_out),1,'A2');


