 clc;

%% generacion base datos

% load('tabla_datos_09112019.mat')
% load('tabla_datos_07112019.mat')
% load('tabla_datos_11012020.mat')

base_datos_total_arroz = [tabla_datos_arroz_07112019; tabla_datos_arroz_09112019; tabla_datos_arroz_11012020];
base_datos_total_maleza = [tabla_datos_maleza_07112019; tabla_datos_maleza_09112019; tabla_datos_maleza_11012020];

Base_Datos_Total = [base_datos_total_maleza; base_datos_total_arroz];
    
save('datos_base_datos_total.mat', 'base_datos_total');

%% separacion variables

Momento_1 = table2array(Base_Datos_Total(:,1));
Momento_2 = table2array(Base_Datos_Total(:,2));
Momento_3 = table2array(Base_Datos_Total(:,3));
Momento_4 = table2array(Base_Datos_Total(:,4));
Momento_5 = table2array(Base_Datos_Total(:,5));
Momento_6 = table2array(Base_Datos_Total(:,6));
Momento_7 = table2array(Base_Datos_Total(:,7));
Contrast = table2array(Base_Datos_Total(:,8));
Correlation = table2array(Base_Datos_Total(:,9));
Energy = table2array(Base_Datos_Total(:,10));
Homogeneity = table2array(Base_Datos_Total(:,11));
area = table2array(Base_Datos_Total(:,12));

%% graficas

% plot(Momento_1,'b');
% grid on
% hold on
% plot(Momento_2,'r');
% plot(Momento_3,'g');
% plot(Momento_5,'m');
% plot(Momento_6,'k');
% plot(Contrast, 'c');
% legend('Momento 1', 'Momento 2', 'Momento 3', 'Momento 5', 'Momento 6', 'Contrast');
% 
% figure(2)
% grid on
% hold on
% plot(Correlation, 'g');
% plot(Energy, 'm');
% plot(Homogeneity, 'b');
% plot(NDVI, 'k');
% hold off
% 
% legend('Correlation', 'Energy', 'Homogeneity', 'NDVI');

%% distribucion normal

i = 238; %numero de la ultima muestra de maleza
j= i+1; %inicio muestras de arroz

mean_weed = mean(Momento_1(1:i));
mean_rice = mean(Momento_1(j:end));
sigma_weed = std(Momento_1(1:i));
sigma_rice = std(Momento_1(j:end));
norm_weed = normpdf(Momento_1(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Momento_1(j:end), mean_rice, sigma_rice);
figure(3)
stem(Momento_1(1:i), norm_weed, 'filled');
hold on
stem(Momento_1(j:end), norm_rice, 'filled');
ylabel('Momento 1')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Momento_2(1:i));
mean_rice = mean(Momento_2(j:end));
sigma_weed = std(Momento_2(1:i));
sigma_rice = std(Momento_2(j:end));
norm_weed = normpdf(Momento_2(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Momento_2(j:end), mean_rice, sigma_rice);
figure(4)
stem(Momento_2(1:i), norm_weed, 'filled');
hold on
stem(Momento_2(j:end), norm_rice, 'filled');
ylabel('Momento 2')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Momento_3(1:i));
mean_rice = mean(Momento_3(j:end));
sigma_weed = std(Momento_3(1:i));
sigma_rice = std(Momento_3(j:end));
norm_weed = normpdf(Momento_3(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Momento_3(j:end), mean_rice, sigma_rice);
figure(5)
stem(Momento_3(1:i), norm_weed, 'filled');
hold on
stem(Momento_3(j:end), norm_rice, 'filled');
ylabel('Momento 3')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Momento_5(1:i));
mean_rice = mean(Momento_5(j:end));
sigma_weed = std(Momento_5(1:i));
sigma_rice = std(Momento_5(j:end));
norm_weed = normpdf(Momento_5(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Momento_5(j:end), mean_rice, sigma_rice);
figure(6)
stem(Momento_5(1:i), norm_weed, 'filled');
hold on
stem(Momento_5(j:end), norm_rice, 'filled');
ylabel('Momento 5')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Momento_6(1:i));
mean_rice = mean(Momento_6(j:end));
sigma_weed = std(Momento_6(1:i));
sigma_rice = std(Momento_6(j:end));
norm_weed = normpdf(Momento_6(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Momento_6(j:end), mean_rice, sigma_rice);
figure(7)
stem(Momento_6(1:i), norm_weed, 'filled');
hold on
stem(Momento_6(j:end), norm_rice, 'filled');
ylabel('Momento 6')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Momento_7(1:i));
mean_rice = mean(Momento_7(j:end));
sigma_weed = std(Momento_7(1:i));
sigma_rice = std(Momento_7(j:end));
norm_weed = normpdf(Momento_7(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Momento_7(j:end), mean_rice, sigma_rice);
figure(10)
stem(Momento_7(1:i), norm_weed, 'filled');
hold on
stem(Momento_7(j:end), norm_rice, 'filled');
ylabel('NDVI')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Contrast(1:i));
mean_rice = mean(Contrast(j:end));
sigma_weed = std(Contrast(1:i));
sigma_rice = std(Contrast(j:end));
norm_weed = normpdf(Contrast(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Contrast(j:end), mean_rice, sigma_rice);
figure(8)
stem(Contrast(1:i), norm_weed, 'filled');
hold on
stem(Contrast(j:end), norm_rice, 'filled');
ylabel('Contrast')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Correlation(1:i));
mean_rice = mean(Correlation(j:end));
sigma_weed = std(Correlation(1:i));
sigma_rice = std(Correlation(j:end));
norm_weed = normpdf(Correlation(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Correlation(j:end), mean_rice, sigma_rice);
figure(9)
stem(Correlation(1:i), norm_weed, 'filled');
hold on
stem(Correlation(j:end), norm_rice, 'filled');
ylabel('Correlation')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Energy(1:i));
mean_rice = mean(Energy(j:end));
sigma_weed = std(Energy(1:i));
sigma_rice = std(Energy(j:end));
norm_weed = normpdf(Energy(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Energy(j:end), mean_rice, sigma_rice);
figure(10)
stem(Energy(1:i), norm_weed, 'filled');
hold on
stem(Energy(j:end), norm_rice, 'filled');
ylabel('Energy')
legend('maleza', 'arroz')
grid on

mean_weed = mean(Homogeneity(1:i));
mean_rice = mean(Homogeneity(j:end));
sigma_weed = std(Homogeneity(1:i));
sigma_rice = std(Homogeneity(j:end));
norm_weed = normpdf(Homogeneity(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(Homogeneity(j:end), mean_rice, sigma_rice);
figure(10)
stem(Homogeneity(1:i), norm_weed, 'filled');
hold on
stem(Homogeneity(j:end), norm_rice, 'filled');
ylabel('Homogeneity')
legend('maleza', 'arroz')
grid on

mean_weed = mean(area(1:i));
mean_rice = mean(area(j:end));
sigma_weed = std(area(1:i));
sigma_rice = std(area(j:end));
norm_weed = normpdf(area(1:i), mean_weed, sigma_weed);
norm_rice = normpdf(area(j:end), mean_rice, sigma_rice);
figure(10)
stem(area(1:i), norm_weed, 'filled');
hold on
stem(area(j:end), norm_rice, 'filled');
ylabel('area')
legend('maleza', 'arroz')
grid on





