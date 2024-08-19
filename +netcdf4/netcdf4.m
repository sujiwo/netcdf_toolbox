classdef netcdf4 

  properties
    id = -1;
    filename = '';
    finfo = -1;
    ndims, nvars, dims, vars;
  end       

  methods

    function o = netcdf4(pth, mode)
      if (nargin==1)
        mode = 'NOWRITE';
      end
      if (isa(pth, 'netcdf4'))
        o.id = pth;
        o.filename = pth.filename;
      elseif (ischar(pth))
        o.id = netcdf.open(pth, mode);
        o.filename = pth;
        %o.dimensionIds = netcdf.inqDimIDs(
      end
      % Dimensions
      o.finfo = ncinfo(pth);
      ndims = size(o.finfo.Dimensions(:));
      nvars = size(o.finfo.Variables(:));
      o.ndims = ndims(1);
      o.nvars = nvars(1);
      for i=1:o.ndims
          o.dims{i} = o.finfo.Dimensions(i).Name;
      end
      for i=1:o.ndims
          o.vars{i} = o.finfo.Variables(i).Name;
      end
    end

    function r = close(self)
        netcdf.close(self.id);
        r=1;
    end

    function ds = dimensions(self)
        ds = self.dims;
    end

    function res = subsref(self, v)
      if nargin < 2
        res = 0;
        return
      end
      theType = v.type;
      theSub = char(v.subs);
      switch theType
          case '{}'
              % variable
              res = self.var(theSub);
          case '()'
              % dimension
              res = self.dim(theSub);
          case '.'
              % attribute
              res = self.attribute(theSub);
      end
    end

    function vars = variables(self)
      vars = self.vars;
    end

    function dm = dim(self, dimName)
      dimId = netcdf.inqDimID(self.id, dimName);
      dm = netcdf4.ncdim(self.id, dimId);
    end

    function ret = var(self, varName)
      varId = netcdf.inqVarID(self.id, varName);
      ret = netcdf4.ncvar(self.id, varId);
      %ret = netcdf.getVar(self.id, varId);
    end

    function redef(self)
        netcdf.reDef(self.id);
    end

    function endef(self)
        netcdf.endDef(self.id);
    end

    function a = attribute(self, name)
        a = netcdf4.ncatt(self.id, netcdf.getConstant("NC_GLOBAL"), name);
    end

    function res = subsasgn(self, operator, other)
        type = operator(1).type;
        subs = operator(1).subs;

        switch type
            case '.'
              a = netcdf4.ncatt.create(self.id, subs);
              a.set(other);
            case '{}'
            case '()'
                name = char(subs);
                d = netcdf4.ncdim.create(self.id, name, other);
            otherwise
                warning([' ## Illegal syntax: "' type '"'])
        end

        res = self;
    end

  end

  methods(Static)
      function fileobj = create(path, permission)
          if nargin==1
              permission=netcdf.getConstant('CLOBBER');
          end
          permission = bitand(permission, netcdf.getConstant('NETCDF4'));
          id = netcdf.create(path, permission);
          netcdf.close(id);
          fileobj = netcdf4.netcdf4(path, 'write');
      end
  end


end
