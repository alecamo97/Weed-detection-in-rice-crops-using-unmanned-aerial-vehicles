% clear all; clc;

% load('datos_descriptores_tabla.mat')
% load('datos_etiquetado.mat')

%% Numero etiquetas de plantas

disp('ingrese los datos, cuando acabe de ingresar los datos de cada clase, ingrese 0');

i = 1;
weed = 1;
while weed~=0
    weed = input('ingrese la etiqueta de la planta de maleza: ' );
    vec_weed(i) = weed;
    vec_weed = unique(vec_weed);    
    i = i+1;
    
end

j = 1;
rice = 1;
while rice~=0
    rice = input('ingrese la etiqueta de la planta de arroz: ');
    vec_rice(j) = rice;
    vec_rice = unique(vec_rice);
    j = j+1;
end

if length(vec_weed) ~= length(vec_rice)
    disp('el numero de etiquetas de plantas de arroz y malezas no son las mismas');
    
    if length(vec_weed) > length(vec_rice)
        j = length(vec_rice)+1;
        while length(vec_weed) > length(vec_rice)
            rice = input('ingrese la etiqueta de la planta de arroz: ');
            vec_rice(j) = rice;
            vec_rice = unique(vec_rice);
            j = j+1;
        end
    else
        i = length(vec_weed)+1;
        while length(vec_weed) < length(vec_rice)
            weed = input('ingrese la etiqueta de la planta de maleza: ');
            vec_weed(i) = weed;
            vec_weed = unique(vec_weed);
            i = i+1;
        end
    end
end

vec_weed = vec_weed(2:end);
vec_rice = vec_rice(2:end);

save ('datos_base_datos.mat', 'vec_weed', 'vec_rice');

%% Calculo descriptores a las muestras

Tabla_datos_vec = table2array(Tabla_datos);

for i=1:length(vec_weed)
    data_weed(i,:) = Tabla_datos_vec(vec_weed(i),:);
end

Contrast = data_weed(:,1);
Correlation = data_weed(:,2);
Energy = data_weed(:,3);
Homogeneity = data_weed(:,4);
Area = data_weed(:,5);
Major_Axis_Length = data_weed(:,6);
Minor_Axis_Length = data_weed(:,7);
Eccentricity = data_weed(:,8);
Equiv_Diameter= data_weed(:,9);
Solidity = data_weed(:,10);
Extent = data_weed(:,11);
Momento_1 = data_weed(:,12);
Momento_2 = data_weed(:,13);
Momento_3 = data_weed(:,14);
Momento_4 = data_weed(:,15);
Momento_5 = data_weed(:,16);
Momento_6 = data_weed(:,17);
Momento_7 = data_weed(:,18);
NDVI = data_weed(:,19);
id = ones(length(vec_rice), 1);

Tabla_datos_maleza = table(Contrast, Correlation, Energy, Homogeneity, Area, Major_Axis_Length,...
    Minor_Axis_Length, Eccentricity, Equiv_Diameter, Solidity, Extent, Momento_1, Momento_2,...
    Momento_3, Momento_4, Momento_5, Momento_6, Momento_7, NDVI, id);

for i=1:length(vec_rice)
    data_rice(i,:) = Tabla_datos_vec(vec_rice(i),:);
end

Contrast = data_rice(:,1);
Correlation = data_rice(:,2);
Energy = data_rice(:,3);
Homogeneity = data_rice(:,4);
Area = data_rice(:,5);
Major_Axis_Length = data_rice(:,6);
Minor_Axis_Length = data_rice(:,7);
Eccentricity = data_rice(:,8);
Equiv_Diameter= data_rice(:,9);
Solidity = data_rice(:,10);
Extent = data_rice(:,11);
Momento_1 = data_rice(:,12);
Momento_2 = data_rice(:,13);
Momento_3 = data_rice(:,14);
Momento_4 = data_rice(:,15);
Momento_5 = data_rice(:,16);
Momento_6 = data_rice(:,17);
Momento_7 = data_rice(:,18);
NDVI = data_rice(:,19);
id = zeros(length(vec_weed), 1);

Tabla_datos_arroz = table(Contrast, Correlation, Energy, Homogeneity, Area, Major_Axis_Length,...
    Minor_Axis_Length, Eccentricity, Equiv_Diameter, Solidity, Extent, Momento_1, Momento_2,...
    Momento_3, Momento_4, Momento_5, Momento_6, Momento_7, NDVI, id);

save('tabla_datos_09112019.mat', 'Tabla_datos_maleza', 'Tabla_datos_arroz');

