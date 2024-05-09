# Weed detection in rice crops using unmmaned aerial vehicles.

This repository presents the results of an investigation project conducted as part of my Electronic Engineering degree program. Titled 'Detection and Location of Weeds in Rice Crops Based on Analysis of Reflectance and RGB Images from Drones,' the project involves the development of MATLAB codes for predicting weed presence in rice crop images captured from drones flying 40 meters above the ground.

The project workflow includes dataset construction, feature calculations, and predictions using machine learning algorithms. Dataset construction begins with image capture using unmanned aerial vehicles (UAVs) and orthomosaic generation using software such as QGIS or ArcGIS. Subsequently, the images are binarized to distinguish plants from other objects, and relevant objects are labeled. Features related to texture, shape, and reflectance are then calculated for each object.

Various data reduction techniques, including features normalization, Principal Component Analysis (PCA), and sequential feature selection, are explored to reduce the dataset size. Finally, three machine learning algorithms: K-Nearest Neighbors, Support Vector Machine, and Random Forest were developed and evaluated using performance metrics such as F1-Score and Accuracy.

This repository provides access to the MATLAB codes and documentation detailing the project methodology and findings. Additionally, detailed descriptions of the functionality of each file are provided below.

***Segmentaton.m***
This script reads a georeferenced image, removes the alpha layer, and retains only the RGB components. Subsequently, it converts the image to grayscale and applies a threshold value of 0.5 to create a binary image. The resulting binary image is then saved along with the georeferenced information.

***Image labels.m***
This script takes the binarized image generated in the previous step and labels the elements present in the image. It also identifies and stores the pixels corresponding to each labeled object. The labeled image is then saved with the original georeferencing information.

***Features.m***
This script calculates texture, shape, and reflectance features from the labeled image. Specifically, it computes Haralick texture features, Hu invariant moments, shape features (e.g., area, major axis length, minor axis length), and average Normalized Difference Vegetation Index (NDVI) for reflectance analysis. The calculated features are stored in a table alongside the label ID of each object.
Additionally, this script includes a classification component where Support Vector Machine, K-Nearest Neighbors, and Random Forest classifiers are used to predict the class for each object. The predicted objects are then visualized in a new image based on the stored labeling information. 
This second part of the script should be executed after running all other project scripts.

***Database.m***
This script facilitates manual labeling of the identified objects (weed or rice) and updates the feature table accordingly. It also creates separate tables for each class to store the corresponding values.

***Database total.m***
This script consolidates all individual class tables into comprehensive tables for each class. Each feature is stored as an independent array, enabling data analysis such as histogram generation, mean calculation, standard deviation computation, and assessment of normal distribution.
