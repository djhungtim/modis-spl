%% This code is for modis RefSB % GEO location plot

%% load RSB data


%clean up command and workspace
clc
clear 
close all 

opengl('save', 'hardware')
tic % start time tracker


EV_RSB_dir = dir('D:\tim_spl\springData\MOD021KM*.hdf');


RSB_NUM = 20;%length(EV_RSB_dir); % calculate length of RSB data

EV_GEO_dir = dir('D:\tim_spl\springDataGeo\MOD03*.hdf');

%import both Latitude and Longitude
GEO_NUM = 10;%length(EV_GEO_dir); % calculate length of GEO data


%import EV_1km_RefSB filename





for idx = 1:RSB_NUM
    
    EV_1km_RefSB = hdfread([EV_RSB_dir(idx).folder,'\',EV_RSB_dir(idx).name],...
        'MODIS_SWATH_Type_L1B', 'Fields', 'EV_1KM_RefSB', 'Index',{[1  1  1],[1  1  1],[1  2030  1354]});

    
EV_1km_RefSB(EV_1km_RefSB >= 65500 & EV_1km_RefSB <= 65535) = NaN;

Longitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
    'MODIS_Swath_Type_GEO', 'Fields', 'Longitude', 'Index',{[1 1],[1 1],[2030 1]});

Latitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
    'MODIS_Swath_Type_GEO', 'Fields', 'Latitude', 'Index',{[1 1],[1 1],[1 1354]});



[Lat_alongTrack,Lon_alongTrack] = meshgrid(Latitude,Longitude);

hold on
contourf(Lat_alongTrack,Lon_alongTrack,EV_1km_RefSB)


clear EV_1km_RefSB
clear Longitude
clear Latitude
clear Lat_alongTrack
clear Lon_alongTrack

end

toc
memory













