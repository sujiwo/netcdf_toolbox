classdef ncdouble < netcdf4.nctype
    methods
        function self = ncdouble(varargin)
            self@netcdf4.nctype('NC_DOUBLE', varargin);
        end
    end
end

                