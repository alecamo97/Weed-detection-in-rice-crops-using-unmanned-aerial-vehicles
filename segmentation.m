%% Read in image
clear all

filename = 'Imagen_NDVI_40m.tif';

[A,R]=geotiffread(filename);
info=geotiffinfo(filename);
A(:,:,4) = [];



%% Convert to grayscale

Igray = rgb2gray(A);
imshow(Igray)

%% Problem: illumination dooesn't allow for easy segmentation

level = 0.5;                   
%level = graythresh(Igray); %<- metodo Otsu
Ithresh = im2bw(Igray, level);
figure, imshow(Ithresh);
geotiffwrite('Segmentado_40m',double(Ithresh),R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)