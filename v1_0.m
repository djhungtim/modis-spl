 
clear
clc


bandnum=14; %band from 1 to 14
WL=[412 443 488 531 551 667 667 678 678 748 869 905 936 940]; % each band average


offset=[ 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722...
    316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722 316.9722];


%%%%%%%%%%%%%SCALE NEED TO BE CHANGED FOR　DIFFERENT DAY  %%%%%%%%%%%%%%%%%%%%%%%%
%(spring)
scales=[ 0.014988 0.0098706 0.0064758 0.0040139 0.0039943 0.0011444 0.00084513 0.0015127 0.00083232 0.001052 0.00093825 0.008097 0.0090284 0.0075016];%參考hdf
%(winter)scales=[ 0.014752 0.0099554 0.0066463 0.004109 0.0041047 0.0011485 0.00084666 0.0015344 0.00084514 0.0010583 0.00093732 0.008133 0.0090655 0.0075439];
%(summer)scales=[ 0.014905 0.009903 0.0065398 0.0040476 0.004031 0.0011464 0.00084629 0.0015208 0.00083731 0.0010559 0.00093822 0.0081021 0.0090398 0.0075162];
%(autumn)


% scales=[ 0.014873 0.0099544 0.0065861 0.0040879 0.0040772 0.0011487 0.00084735...
%     0.0015292 0.00084204 0.0010577 0.00093799 0.0081172 0.009058 0.0075396 ];


%%%%%%%%%%%%%%%%%%%%%%%%%dir to file location%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


MOD2=dir('D:\tim_spl\springData\MOD02*.hdf');

MOD3=dir('D:\tim_spl\springDataGeo\MOD03*.hdf'); 


%make some empty array

datanum=10;%length(MOD2);  
Lawdata(2030,1354,bandnum)=0;
daa=0;
lattt=[];
lonnn=[];
dd=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%make world map data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
llat=-90:0.1:90;
llon=-180:0.1:180;
[meshlon, meshlat]=meshgrid(llon,llat);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:datanum     
    for j=1:bandnum
        Lawdata(:,:,j)=hdfread([MOD2(i).folder,'\',MOD2(i).name],...
            '/MODIS_SWATH_Type_L1B/Data Fields/EV_1KM_RefSB', 'Index', {[j  1  1],[1  1  1],[1  2030  1354]});
    end
    lat=hdfread([MOD3(i).folder,'\',MOD3(i).name],...
        '/MODIS_Swath_Type_GEO/Geolocation Fields/Latitude', 'Index', {[1  1],[1  1],[2030  1354]});
    lon=hdfread([MOD3(i).folder,'\',MOD3(i).name],...
        '/MODIS_Swath_Type_GEO/Geolocation Fields/Longitude', 'Index', {[1  1],[1  1],[2030  1354]});
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ppp=0;
    for lll=1:2030
     for ooo=1:1354
         
         
        if sum(Lawdata(lll,ooo,:))>32767*14
            continue;
        elseif (lat(lll,ooo)==-999 ||  lon(lll,ooo)==-999) 
            continue;
        else  
            ppp=ppp+1;
            if (rem(ppp,2000)==0)
                daa=sum((reshape(Lawdata(lll,ooo,:),1,14)-offset).*scales.*WL/1000); %1 pixal 總能 % 1 pixel total energy
                lattt=[lattt lat(lll,ooo)];
                lonnn=[lonnn lon(lll,ooo)];
                dd=[dd daa];
            end

        end
     end
    end
clear  lat lon 
end
 figure 
zz=griddata(double(lonnn),double(lattt),double(dd),meshlon,meshlat);
contourf(zz)
writematrix(zz,'test.csv')
colorbar



load('D:\tim_spl\modis-spl\hdcoast.mat');
hold on
plot(hdcoast(:,1)*10+1800,hdcoast(:,2)*10+900,'k','LineWidth',3)

set(gca,'XTick',[0:600:3600])
set(gca,'YTick',[0:450:1800])
set(gca,'xticklabel',{'180^oW','120^oW','60^oW','0^o','60^oE','120^oE','180^oE'});
set(gca,'yticklabel',{'90^oS','45^oS','0^o','45^oN','90^oN'});
title('2018 September Equinox Earth Radiance from MODIS Terra');
title(colorbar,'Watts/m^2/sr')


