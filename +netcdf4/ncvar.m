classdef ncvar

  properties
    ncid
    varId
    attributes
    xtype
    dimIds
    numAttrs
  end

  methods
    function s = ncvar(ncId, varId)
       s.ncid = ncId;
       s.varId = varId;
       [vname, s.xtype, s.dimIds, s.numAttrs] = netcdf.inqVar(ncId, varId);

       for i=0:s.numAttrs-1
         s.attributes{i+1} = netcdf.inqAttName(s.ncid, s.varId, i);
       end
    end

    function ct = getValue(self)
       ct = netcdf.getVar(self.ncid, self.varId);
       ct = transpose(ct);
    end

    function s = set(self, val)
        s = 1;
    end

    function dms = dimensions(self)
        for i=1:length(self.dimIds)
          
        end
    end

    function a = getAttr(self, attrName)
       a = netcdf4.ncatt(self.ncid, self.varId, attrName);
    end

    function res = subsasgn(self, typ, val)
        error("Not implemented");
    end

    function res = subsref(self, subs)
        s = subs;
        typ = s(1).type;
        subs = s(1).subs;
        s(1) = [];

        if isa(subs, 'cell'), subs=subs{1}, end
        switch (typ)
            case '()'
                res = self.getValue();
            case '.'
                res = self.getAttr(subs);
            otherwise
                error(["### Illegal syntax: '" typ "'"])
        end
    end
  end

  methods (Static)
      function nvar = create(ncid, name, ntype)
          arguments
              ncid int32
              name string
              ntype netcdf4.nctype
          end

          ndim = length(ntype.dimensions);
          dimids = zeros(1,ndim);
          for i=1:ndim
              dimids(i) = netcdf.inqDimID(ncid, ntype.dimensions{i});
          end
          varid = netcdf.defVar(ncid, name, ntype.type, dimids);
          nvar = netcdf4.ncvar(ncid, varid);
      end
  end
end

