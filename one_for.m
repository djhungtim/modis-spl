%% This code is for modis RefSB % GEO location plot

%% load RSB data


%clean up command and workspace
clc
clear 
close

opengl('save', 'hardware')
tic % start time tracker


EV_RSB_dir = dir('D:\SPL\dataAnalysis\springData\MOD021KM*.hdf');


RSB_NUM = length(EV_RSB_dir); % calculate length of RSB data

EV_GEO_dir = dir('D:\SPL\dataAnalysis\springDataGeo\MOD03*.hdf');

%import both Latitude and Longitude
GEO_NUM = 1;%length(EV_GEO_dir); % calculate length of GEO data


%import EV_1km_RefSB filename


EV_1km_RefSB = zeros(2030,1354);
Longitude = zeros(2030,1354);
Latitude = zeros(2030,1354);


for idx = 1:RSB_NUM
    
    EV_1km_RefSB = hdfread([EV_RSB_dir(idx).folder,'\',EV_RSB_dir(idx).name],...
        'MODIS_SWATH_Type_L1B', 'Fields', 'EV_1KM_RefSB', 'Index',{[1  1  1],[1  1  1],[1  2030  1354]});
        
    EV_1km_RefSB(EV_1km_RefSB >= 65500 & EV_1km_RefSB <= 65535) = 0;
    EV_1km_RefSB = double(EV_1km_RefSB);
    
    Longitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Longitude', 'Index',{[1 1],[1 1],[2030 1354]});
    Longitude(Longitude == -999) = 0;
    Longitude = double(Longitude);
    
    Latitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Latitude', 'Index',{[1 1],[1 1],[2030 1354]});
    Latitude(Latitude == -999) = 0;
    Latitude = double(Latitude);
    
%     [xq,yq] = meshgrid(min(Longitude(:,1)):.2:max(Longitude(:,1)), min(Latitude(:,1)):.2:max(Latitude(:,1)));
%     z1 = griddata(Longitude(:,1),Latitude(:,1),EV_1km_RefSB(:,1,1),double(xq),double(yq),'cubic');
%     mesh(xq,yq,z1)

% F = scatteredInterpolant(Longitude(:,1),Latitude(:,1),EV_1km_RefSB(:,1,1));
% [xq,yq] = meshgrid(min(Longitude(:,1)):.5:max(Longitude(:,1)), min(Latitude(:,1)):.5:max(Latitude(:,1)));
% F.Method = 'nearest';
% vq1 = abs(F(xq,yq));
% mesh(xq,yq,vq1)


    hold on
    plot3(Longitude(:,1),Latitude(:,1),EV_1km_RefSB(:,1,1),'r.')
    hold on
    plot3(Longitude(1,:),Latitude(1,:),EV_1km_RefSB(1,:,1),'b.')
  
    clear EV_1km_RefSB
    clear Longitude
    clear Latitude
%     clear xq
%     clear yq


end


%hold on
toc
memory













