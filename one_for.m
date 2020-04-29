%% This code is for modis RefSB % GEO location plot



%% offset & ...

% Precision: uint16 
% long_name: Earth View 1KM Reflective Solar Bands Scaled Integers 
% units: none valid_range: 0 32767 _FillValue: 65535 
% band_names: 8,9,10,11,12,13lo,13hi,14lo,14hi,15,16,17,18,19,26 
% radiance_scales: 0.014609 0.0098922 0.0067036 0.0041269 0.0041293 0.0011476 0.00084672 0.0015389 0.00084736 0.0010593 0.0009385 0.0081613 0.0090462 0.0075468 0.0032984 
% radiance_offsets: 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 radiance_units: Watts/m^2/micrometer/steradian 
% reflectance_scales: 2.6076e-05 1.6191e-05 1.0545e-05 6.825e-06 6.7999e-06 2.3098e-06 1.7042e-06 3.1795e-06 1.7508e-06 2.5493e-06 3.0056e-06 2.7205e-05 3.2263e-05 2.6931e-05 2.8163e-05 
% reflectance_offsets: 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 
% reflectance_units: none corrected_counts_scales: 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 0.12619 
% corrected_counts_offsets: 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 corrected_counts_units: counts

%%
                

%% load RSB data


%clean up command and workspace
clc
clear 
close

opengl('save', 'hardware')
tic % start time tracker


EV_RSB_dir = dir('D:\tim_spl\summerData\MOD021KM*.hdf');


RSB_NUM = 20;%length(EV_RSB_dir); % calculate length of RSB data

EV_GEO_dir = dir('D:\tim_spl\summerDataGeo\MOD03*.hdf');

%import both Latitude and Longitude
GEO_NUM = length(EV_GEO_dir); % calculate length of GEO data


%import EV_1km_RefSB filename


EV_1km_RefSB = zeros(2030,1354);
Longitude = zeros(2030,1354);
Latitude = zeros(2030,1354);
% along_track_Longitude = zeros(2030,1354);
% along_track_Latitude = zeros(2030,1354);
% along_track_EV_1km_RefSB = zeros(2030,1354);

for idx = 1:RSB_NUM
    
    EV_1km_RefSB = hdfread([EV_RSB_dir(idx).folder,'\',EV_RSB_dir(idx).name],...
        'MODIS_SWATH_Type_L1B', 'Fields', 'EV_1KM_RefSB', 'Index',{[1  1  1],[1  1  1],[1  2030  1354]});
        
    EV_1km_RefSB(EV_1km_RefSB >= 65500 & EV_1km_RefSB <= 65535) = NaN;
    EV_1km_RefSB(EV_1km_RefSB > 32767) = NaN;
    EV_1km_RefSB = double(EV_1km_RefSB);
    
    Longitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Longitude', 'Index',{[1 1],[1 1],[2030 1354]});
    Longitude(Longitude == -999) = NaN;
    Longitude = double(Longitude);
    
    Latitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Latitude', 'Index',{[1 1],[1 1],[2030 1354]});
    Latitude(Latitude == -999) = NaN;
    Latitude = double(Latitude);
%     
%     [xq,yq] = meshgrid(min(Longitude(:,1)):.1:max(Longitude(:,1)), min(Latitude(:,1)):.1:max(Latitude(:,1)));
%     z1 = griddata(Longitude(:,1),Latitude(:,1),EV_1km_RefSB(:,1,1),double(xq),double(yq),'cubic');
%     contourf(xq,yq,z1)
%     
%     [xq1,yq1] = meshgrid(min(Longitude(1,:)):.2:max(Longitude(1,:)), min(Latitude(1,:)):.2:max(Latitude(1,:)));
%     z2 = griddata(Longitude(1,:),Latitude(1,:),EV_1km_RefSB(1,:,1),double(xq1),double(yq1),'cubic');
%     mesh(xq1,yq1,z2)

% F = scatteredInterpolant(Longitude(:,1),Latitude(:,1),EV_1km_RefSB(:,1,1));
% [xq,yq] = meshgrid(min(Longitude(:,1)):.1:max(Longitude(:,1)), min(Latitude(:,1)):.1:max(Latitude(:,1)));
% F.Method = 'linear';
% vq1 = abs(F(xq,yq));
% mesh(xq,yq,vq1)
% 
% F2 = scatteredInterpolant(Longitude(1,:)',Latitude(1,:)',EV_1km_RefSB(1,:,1)');
% [xq1,yq1] = meshgrid(min(Longitude(1,:)):.1:max(Latitude(1,:)), min(Latitude(1,:)):.1:max(Latitude(1,:)));
% F2.Method = 'linear';
% vq2 = abs(F(xq1,yq1));
% mesh(xq1,yq1,vq2)

    along_track_Longitude = Longitude(:,1);
    along_track_Latitude = Latitude(:,1);
    along_track_EV_1km_RefSB = EV_1km_RefSB(:,1,1);
    
    writematrix([along_track_Longitude,along_track_Latitude,along_track_EV_1km_RefSB],'data.csv')
    
    

    hold on
    plot3(along_track_Longitude,along_track_Latitude,along_track_EV_1km_RefSB,'r.')
%     ylim([-40 40])
    hold on
    plot3(Longitude(1,:),Latitude(1,:),EV_1km_RefSB(1,:,1),'b.')
%     ylim([-40 40])

%     clear xq
%     clear yq
%   
%     clear EV_1km_RefSB
%     clear Longitude
%     clear Latitude

end


%hold on
toc
memory













