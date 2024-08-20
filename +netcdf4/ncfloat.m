classdef ncfloat < netcdf4.nctype
    methods
        function self = ncfloat(varargin)
            self@netcdf4.nctype('NC_FLOAT', varargin);
        end
    end
end

