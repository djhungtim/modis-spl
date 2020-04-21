

%% load RSB data

%clean up command and workspace
clc
clear 

tic

%file location 
%dir to your file location
EV_RSB_dir = dir('D:\SPL\dataAnalysis\springData\MOD021KM*.hdf');
% EV_RSB_data_folder = EV_RSB_dir.folder;
% EV_RSB_data_filename = EV_RSB_dir.name;


RSB_NUM = length(EV_RSB_dir); % calculate length of RSB data
% RSB_NUM_arr = 1:RSB_NUM;

%import EV_1km_RefSB filename

EV_1000_RefSB = uint16(zeros(2030,1354,(162)));
for idx = 1:(RSB_NUM)

    EV_1km_RefSB = hdfread([EV_RSB_dir(idx).folder,'\',EV_RSB_dir(idx).name],...
         'MODIS_SWATH_Type_L1B', 'Fields', 'EV_1KM_RefSB', 'Index',{[1  1  1],[1  1  1],[1  2030  1354]});
    EV_1000_RefSB(:,:,idx) = EV_1km_RefSB;
    
end
%data = hdfread(filename,EOSname,param,value,...)
%hdfread(..., 'Index', {start,stride,edge})
toc

%% load GEO data

%file location 
%dir to your file location
EV_GEO_dir = dir('D:\SPL\dataAnalysis\springDataGeo\MOD03*.hdf');
% EV_GEO_dir_folder = EV_GEO_dir.folder;
% EV_GEO_data_filename = EV_GEO_dir.name;

%import both Latitude and Longitude
GEO_NUM = length(EV_GEO_dir); % calculate length of GEO data

Longitude_GEO = single(zeros(2030,1354,(162)));
for idx = 1:(GEO_NUM)
    
    Longitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Longitude', 'Index',{[1 1],[1 1],[2030 1354]});
    Longitude_GEO(:,:,idx) = Longitude;

end
toc

Latitude_GEO = single(zeros(2030,1354,(162 )));
for idx = 1:(GEO_NUM)
    
    Latitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Latitude', 'Index',{[1 1],[1 1],[2030 1354]});
    Latitude_GEO(:,:,idx) = Latitude;
    
end
toc



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









