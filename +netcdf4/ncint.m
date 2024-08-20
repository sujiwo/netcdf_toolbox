classdef ncint < netcdf4.nctype
    methods
        function self = ncint(varargin)
            self@netcdf4.nctype('NC_INT', varargin);
        end
    end
end

                