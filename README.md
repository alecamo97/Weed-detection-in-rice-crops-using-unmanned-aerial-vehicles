# Weed detection in rice crops using unmmaned aerial vehicles.

This repository presents the results of an investigation project conducted as part of my Electronic Engineering degree program. Titled 'Detection and Location of Weeds in Rice Crops Based on Analysis of Reflectance and RGB Images from Drones,' the project involves the development of MATLAB codes for predicting weed presence in rice crop images captured from drones flying 40 meters above the ground.

The project workflow includes dataset construction, feature calculations, and predictions using machine learning algorithms. Dataset construction begins with image capture using unmanned aerial vehicles (UAVs) and orthomosaic generation using software such as QGIS or ArcGIS. Subsequently, the images are binarized to distinguish plants from other objects, and relevant objects are labeled. Features related to texture, shape, and reflectance are then calculated for each object.

Various data reduction techniques, including features normalization, Principal Component Analysis (PCA), and sequential feature selection, are explored to reduce the dataset size. Finally, three machine learning algorithms: K-Nearest Neighbors, Support Vector Machine, and Random Forest were developed and evaluated using performance metrics such as F1-Score and Accuracy.

This repository provides access to the MATLAB codes and documentation detailing the project methodology and findings. Additionally, detailed descriptions of the functionality of each file are provided below.

