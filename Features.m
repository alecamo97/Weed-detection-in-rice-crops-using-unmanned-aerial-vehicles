clear all; 

load('datos_etiquetado.mat');

%% momentos malezas

filename = 'RGB_40m.tif';
[A,R] = geotiffread(filename);
info = geotiffinfo(filename);
A(:,:,4) = [];
Agray = rgb2gray(A);

filename2 = 'Segmentado_40m.tif';
[Abw,R] = geotiffread(filename2);
info = geotiffinfo(filename2);

filename3 = 'NDVI_40m.tif';
[Andvi,R] = geotiffread(filename3);
info = geotiffinfo(filename3);
Andvi = im2double(Andvi);
vec_img_NDVI = reshape(Andvi,r*c,1);

moment = [];
moment_norm_obj = [];
NDVI_obj = [];

for i=1:length(object_pix)
    L_obj=length(object_pix{i});
    obj_pix_mat = [];
    obj_pix_mat_bw = [];
    obj_pix_mat_NDVI = [];
    
    c_k=ceil(object_pix{i}./r);
    r_k=mod(object_pix{i},r);
    P_xy=[c_k' r_k'];
    
    r_k_min=min(P_xy(:,2));
    c_k_min=min(P_xy(:,1));
    
    for k=1:L_obj
        new_r=P_xy(k,2)-r_k_min+1;
        new_c=P_xy(k,1)-c_k_min+1;
        obj_pix_mat(new_r,new_c)= Agray(object_pix{i}(k));
        obj_pix_mat_bw(new_r,new_c) = Abw(object_pix{i}(k)); 
              
    end
    moment = [moment invmoments(obj_pix_mat_bw)'];
    moment_norm_obj = [moment_norm_obj -sign(moment(:,i)).*log10(abs(moment(:,i)))];
    GLCM_obj = graycomatrix(obj_pix_mat);
    Haralick_obj(i,:) = graycoprops(GLCM_obj);  
    shape_obj(i,:) = regionprops('struct', obj_pix_mat_bw, 'Area', ...
        'MajorAxisLength', 'MinorAxisLength','EquivDiameter', 'Extent', 'Eccentricity', 'Solidity');
    NDVI_obj = [NDVI_obj mean(Andvi(object_pix{i}))];
end

Haralick_obj = struct2table(Haralick_obj);
shape_obj = struct2table(shape_obj);
moment_norm_obj = moment_norm_obj';
NDVI_obj = NDVI_obj';

%% Guardar datos    
save('datos_descriptores.mat', 'Haralick_obj', 'shape_obj', 'moment_norm_obj', 'NDVI_obj');

%% ------------------------------------------------- 2nd Part -------------------------------------------------------------
%% creacion tabla con caracteristicas

Contrast = table2array(Haralick_obj(:,1));
Correlation = table2array(Haralick_obj(:,2));
Energy = table2array(Haralick_obj(:,3));
Homogeneity = table2array(Haralick_obj(:,4));
Area = table2array(shape_obj(:,1));
Major_Axis_Length = table2array(shape_obj(:,2));
Minor_Axis_Length = table2array(shape_obj(:,3));
Eccentricity = table2array(shape_obj(:,4));
Equiv_Diameter = table2array(shape_obj(:,5));
Solidity = table2array(shape_obj(:,6));
Extent = table2array(shape_obj(:,7));
Momento_1 = moment_norm_obj(:,1);
Momento_2 = moment_norm_obj(:,2);
Momento_3 = moment_norm_obj(:,3);
Momento_4 = moment_norm_obj(:,4);
Momento_5 = moment_norm_obj(:,5);
Momento_6 = moment_norm_obj(:,6);
Momento_7 = moment_norm_obj(:,7);
NDVI = NDVI_obj(:,1);

Contrast(isnan(Contrast)) = 0;
Correlation(isnan(Correlation)) = 0;
Energy(isnan(Energy)) = 0;
Homogeneity(isnan(Homogeneity)) = 0;
Area(isnan(Area)) = 0;
Major_Axis_Length(isnan(Major_Axis_Length)) = 0;
Minor_Axis_Length(isnan(Minor_Axis_Length)) = 0;
Eccentricity(isnan(Eccentricity)) = 0;
Equiv_Diameter(isnan(Equiv_Diameter)) = 0;
Solidity(isnan(Solidity)) = 0;
Extent(isnan(Extent)) = 0;
Momento_1(isnan(Momento_1)) = 0;
Momento_2(isnan(Momento_2)) = 0;
Momento_3(isnan(Momento_3)) = 0;
Momento_4(isnan(Momento_4)) = 0;
Momento_5(isnan(Momento_5)) = 0;
Momento_6(isnan(Momento_6)) = 0;
Momento_7(isnan(Momento_7)) = 0;
NDVI(isnan(NDVI)) = 0;

Tabla_datos = table(Contrast, Correlation, Energy, Homogeneity, Area, Major_Axis_Length,...
    Minor_Axis_Length, Eccentricity, Equiv_Diameter, Solidity, Extent, Momento_1, Momento_2,...
    Momento_3, Momento_4, Momento_5, Momento_6, Momento_7, NDVI);

save('datos_descriptores_tabla.mat', 'Tabla_datos');

%% prediccion RF
% 
 yfit_RF = predict(RFClassifier_PCA, Tabla_datos{:,RFClassifier_PCA.PredictorNames});
% 
% %% prediccion SVM
% 
% yfit_SVM = predict(SVMClassifier_SFS, Tabla_datos{:,SVMClassifier_SFS.PredictorNames});
% 
% %% Prediccion KNN
% 
% yfit_KNN = predict(KNNClassifier_PCA, Tabla_datos{:,KNNClassifier_PCA.PredictorNames});

%% imagen

label_weed = find(yfit_RF==1);
vec_weed = zeros(r*c,1);
for i=1:length(label_weed)
    for j=1:length(object_pix{label_weed(i)})
        vec_weed(object_pix{label_weed(i)}) = label_weed(i);
    end
end
img_weed = double(reshape(vec_weed,r,c));
geotiffwrite('etiquetado malezas RF PCA',double(img_weed),R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
