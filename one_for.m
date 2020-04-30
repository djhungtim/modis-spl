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


EV_RSB_dir = dir('D:\SPL\dataAnalysis\springData\MOD021KM*.hdf');


RSB_NUM = length(EV_RSB_dir); % calculate length of RSB data

EV_GEO_dir = dir('D:\SPL\dataAnalysis\springDataGeo\MOD03*.hdf');

%import both Latitude and Longitude
%GEO_NUM = length(EV_GEO_dir); % calculate length of GEO data


%import EV_1km_RefSB filename

along_track_length = 2030;
along_scan_length = 1354;


% EV_1km_RefSB = zeros(along_track_length,along_scan_length);
% Longitude = zeros(along_track_length,along_scan_length);
% Latitude = zeros(along_track_length,along_scan_length);
% along_track_Longitude = zeros(2030,1354);
% along_track_Latitude = zeros(2030,1354);
% along_track_EV_1km_RefSB = zeros(2030,1354);

% grid_long = -180:1:180;
% grid_lat = -90:1:90;
grid_long = randi([-180,180],1,361);
grid_lat = randi([-90,90],1,181);
[meshlon, meshlat]=meshgrid(grid_long ,grid_lat);


for idx = 1:RSB_NUM
    
    EV_1km_RefSB = hdfread([EV_RSB_dir(idx).folder,'\',EV_RSB_dir(idx).name],...
        'MODIS_SWATH_Type_L1B', 'Fields', 'EV_1KM_RefSB', 'Index',{[1  1  1],[1  1  1],[1  along_track_length  along_scan_length]});
        
    

    EV_1km_RefSB(EV_1km_RefSB == uint16(65535)) = 0;
%     EV_1km_RefSB(EV_1km_RefSB == 0) = NaN;
%     %EV_1km_RefSB(EV_1km_RefSB > 32767) = NaN;
    EV_1km_RefSB = double(EV_1km_RefSB);
    
    Longitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Longitude', 'Index',{[1 1],[1 1],[along_track_length along_scan_length]});
    Longitude(Longitude == single(-999)) = 0;
    Longitude = double(Longitude);
    
    Latitude = hdfread([EV_GEO_dir(idx).folder,'\',EV_GEO_dir(idx).name],...
        'MODIS_Swath_Type_GEO', 'Fields', 'Latitude', 'Index',{[1 1],[1 1],[along_track_length along_scan_length]});
    Latitude(Latitude == single(-999)) = 0;
    Latitude = double(Latitude);
   

%     F = scatteredInterpolant(Longitude(:,1),Latitude(:,1),EV_1km_RefSB(:,1,1));
%     [xq,yq] = meshgrid(min(Longitude(:,1)):.1:max(Longitude(:,1)), min(Latitude(:,1)):.1:max(Latitude(:,1)));
%     F.Method = 'linear';
%     vq1 = abs(F(xq,yq));
%     mesh(xq,yq,vq1)
% 

    along_track_Longitude = Longitude(1:2:along_track_length,1);
    along_track_Latitude = Latitude(1:2:along_track_length,1);
    along_track_EV_1km_RefSB = EV_1km_RefSB(1:2:along_track_length,1,1);
    
%     writematrix([along_track_Longitude,along_track_Latitude,along_track_EV_1km_RefSB],'along_data.csv')
    
    along_scan_Longitude = Longitude(1,1:2:along_scan_length);
    along_scan_Latitude = Latitude(1,1:2:along_scan_length);
    along_scan_EV_1km_RefSB = EV_1km_RefSB(1,1:2:along_scan_length,1);
    
    All_Longitude = [along_track_Longitude;along_scan_Longitude'];
    All_Latitude = [along_track_Latitude;along_scan_Latitude'];
    All_EV_1km_RefSB = [along_track_EV_1km_RefSB;along_scan_EV_1km_RefSB'];
    
%     F = scatteredInterpolant(All_Longitude,All_Latitude,All_EV_1km_RefSB);
%     F.Method = 'linear';
%     EV_1km_RefSB_grid = F(meshlon,meshlat);
%     contourf(EV_1km_RefSB_grid)
    

    
%     sort(All_Longitude)
%     sort(All_Latitude)
%     [xq,yq] = meshgrid(min(Longitude(:,1)):.1:max(Longitude(:,1)), min(Latitude(:,1)):.1:max(Latitude(:,1)));
    
    EV_1km_RefSB_grid = griddata(All_Longitude,All_Latitude,All_EV_1km_RefSB,meshlon,meshlat,'linear');
    hold on
    contourf(EV_1km_RefSB_grid)
    colormap jet
    
    load('D:\SPL\dataAnalysis\worldamap\hdcoast.mat');


    set(gca,'XTick',0:60:360)
    set(gca,'YTick',0:45:180)
    set(gca,'xticklabel',{'180^oW','120^oW','60^oW','0^o','60^oE','120^oE','180^oE'});    
    hold on
    plot(hdcoast(:,1)+180,hdcoast(:,2)+90,'k','LineWidth',1)
    set(gca,'yticklabel',{'90^oS','45^oS','0^o','45^oN','90^oN'});
%     title('2018 September Equinox Earth Radiance from MODIS Terra');
     
%     contourf(xq,yq,z1)
%     
%     [xq1,yq1] = meshgrid(min(Longitude(1,:)):.2:max(Longitude(1,:)), min(Latitude(1,:)):.2:max(Latitude(1,:)));
%     z2 = griddata(Longitude(1,:),Latitude(1,:),EV_1km_RefSB(1,:,1),double(xq1),double(yq1),'cubic');
%     mesh(xq1,yq1,z2)

%     hold on
%     plot3(All_Longitude,All_Latitude,All_EV_1km_RefSB,'r.')
%     ylim([-40 40])
%     hold on
%     plot3(along_scan_Longitude,along_scan_Latitude,along_scan_EV_1km_RefSB,'b.')
%     ylim([-40 40])

%     clear xq
%     clear yq
%   
    clear EV_1km_RefSB
    clear Longitude
    clear Latitude
    

end


%hold on
toc
memory













