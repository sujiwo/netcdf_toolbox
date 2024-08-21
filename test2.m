% Test reading existing netcdf file
ncfd = netcdf4.netcdf4('/Data/Croco/Lombok2t/DATA/mercator_Lombok_HR/raw_mercator_Y2003M1.nc');
lon = ncfd{'longitude'}(:);

close(ncfd);
