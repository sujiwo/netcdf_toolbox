classdef ncatt
    properties
        ncid
        varId
        attrId
        name
    end

    methods
        function s = ncatt(ncId, varId, name)
            s.ncid = ncId;
            s.varId = varId;
            s.attrId = netcdf.inqAttID(ncId, varId, name);
            s.name = name;
        end

        function v = get(self)
            v = netcdf.getAtt(self.ncid, self.varId, self.name);
        end

        function set(self, val)
            netcdf.putAtt(self.ncid, self.varId, self.name, val);
        end

        function delete(self)
            netcdf.delAtt(self.ncid, self.varId, self.name);
        end

        function disp(self)
            disp(self.get())
        end
    end

    methods (Static)
        function r = create(ncid, name, varid)
            if nargin==2
                varid = netcdf.getConstant("NC_GLOBAL");
            end
            netcdf.putAtt(ncid, varid, name, -1);
            r = netcdf4.ncatt(ncid, varid, name);
        end
    end

end                 
