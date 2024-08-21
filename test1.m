% Test create netcdf files
ncfd = netcdf4.netcdf4.create('/tmp/A.nc');
redef(ncfd);
ncfd.title = 'Test NetCDF4 file';
ncfd.year = 2024;
% The right hand side is the length; -1 means unlimited
ncfd('lonT') = 300;         
ncfd('latT') = 299;
ncfd('time') = 25;
ncfd('depth') = -1;
%mfloat = netcdf4.ncfloat('time', 'lat', 'lon');
ncfd{'temp'} = netcdf4.ncfloat('time', 'lonT', 'latT');

endef(ncfd);   
close(ncfd);
