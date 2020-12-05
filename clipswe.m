function clipswe = clipswe(filepath,year)
    filename = strcat(filepath,'/SN_SWE_WY',string(year),'.h5');

    lat = h5read(filename,'/lat');
    lon = h5read(filename,'/lon');

    latmin = 37.015;
    latmax = 37.075;
    lonmin = -119.2;
    lonmax = -119.1;

    latmin_idx = find(lat<latmin,1);
    latmax_idx = find(lat<latmax,1);
    lonmin_idx = find(lon>lonmin,1);
    lonmax_idx = find(lon>lonmax,1);
    
    latlim = [latmin,latmax];
    lonlim = [lonmin, lonmax];
    
    latsave = lat(latmax_idx:latmin_idx-1);
    lonsave = lon(lonmin_idx:lonmax_idx-1);
    
    startLoc = [latmax_idx,lonmin_idx,1]; 
    count  = [latmin_idx-latmax_idx,lonmax_idx-lonmin_idx,365]; 
    stride = [1,1,1];
    SWE  = h5read(filename,'/SWE',startLoc,count,stride);
    of = strcat('SWE_clip_',string(year));
    R = georefcells(latlim,lonlim,size(SWE));
    geotiffwrite(of,SWE,R)
    save(of,'SWE','latsave','lonsave');
end
