% Test create netcdf files
ncfd = netcdf4.netcdf4.create('/tmp/A.nc');
redef(ncfd);
ncfd.title = 'Test NetCDF4 file';
ncfd.year = 2024;
ncfd('lonT') = 300;         
ncfd('latT') = 299;
ncfd('time') = 25;
ncfd('depth') = -1;

%ncfd{'time'} = netcdf4.ncfloat('time', 'lonT', 'latT');

endef(ncfd);   
close(ncfd);
