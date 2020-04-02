

%% load data

%clean up command and workspace
clc
clear 

%file location
data_dir = dir('D:\SPL\dataAnalysis\springData\SPLdataAnalysisspringData\MOD02QKM.A2019080.0005.061.2019080131355.hdf');

%read file info
fileinfo = hdfinfo("MOD02QKM.A2019080.0005.061.2019080131355.hdf");

%import EV_250_RefSB
EV_250_RefSB = hdfread('D:\SPL\dataAnalysis\springData\SPLdataAnalysisspringData\MOD02QKM.A2019080.0005.061.2019080131355.hdf', 'MODIS_SWATH_Type_L1B', 'Fields', 'EV_250_RefSB');

%import both Latitude and Longitude
Latitude = hdfread('D:\SPL\dataAnalysis\springData\SPLdataAnalysisspringData\MOD02QKM.A2019080.0005.061.2019080131355.hdf', 'MODIS_SWATH_Type_L1B', 'Fields', 'Latitude');
Longitude = hdfread('D:\SPL\dataAnalysis\springData\SPLdataAnalysisspringData\MOD02QKM.A2019080.0005.061.2019080131355.hdf', 'MODIS_SWATH_Type_L1B', 'Fields', 'Longitude');

%% Set up Data

% for idx = 1:5
% EV_250_RefSB = EV_250_RefSB(1, :, :);

% plot3(Latitude)