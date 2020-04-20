

%% load data

%clean up command and workspace
clc
clear 

%file location 
%dir to your file location
EV_RSB_dir = dir('D:\SPL\dataAnalysis\springData\MOD021KM*.hdf');
EV_RSB_data_folder = EV_RSB_dir.folder;
EV_GEO_dir = dir('D:\SPL\dataAnalysis\springDataGeo\MOD03*.hdf');
EV_GEO_dir_folder = EV_GEO_dir.folder;

%read file info
%fileinfo = hdfinfo("MOD02QKM.A2019080.0005.061.2019080131355.hdf");

%import EV_1km_RefSB
% for idx = 1:14
EV_1km_RefSB = hdfread('D:\SPL\dataAnalysis\springData\MOD021KM.A2019080.0015.061.2019080131349.hdf',...
'MODIS_SWATH_Type_L1B', 'Fields', 'EV_1KM_RefSB', 'Index',{[1  1  1],[1  1  1],[1  2030  1354]});
% end
%data = hdfread(filename,EOSname,param,value,...)
%hdfread(..., 'Index', {start,stride,edge})

%import both Latitude and Longitude
Longitude = hdfread('D:\SPL\dataAnalysis\springDataGeo\MOD03.A2019080.0015.061.2019080065525.hdf',...
    'MODIS_Swath_Type_GEO', 'Fields', 'Longitude', 'Index',{[1 1],[1 1],[2030 1354]});
Latitude = hdfread('D:\SPL\dataAnalysis\springDataGeo\MOD03.A2019080.0015.061.2019080065525.hdf',...
    'MODIS_Swath_Type_GEO', 'Fields', 'Latitude', 'Index',{[1 1],[1 1],[2030 1354]});





%% Set up Data
% 
% x = 1:2030;
% y = 1:1354;
% 
% z = EV_1000_RefSB(1,:,:);

% EV_250_RefSB_x = EV_250_RefSB([], :, []);
% EV_250_RefSB_y = EV_250_RefSB([], [], :);
% EV_250_RefSB_z = EV_250_RefSB(:, [], []);


%% plot data









