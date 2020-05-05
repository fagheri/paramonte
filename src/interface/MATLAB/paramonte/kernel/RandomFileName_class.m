classdef RandomFileName_class < handle

    properties (Constant)
        CLASS_NAME = "RandomFileName_class"
    end

    properties
        path    = []
        dir     = []
        key     = []
        ext     = []
        Err     = Err_class()
    end

%***********************************************************************************************************************************
%***********************************************************************************************************************************

    methods (Access = public)

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

        % generates unique file path in the requested directory for temporary usage
        function self = RandomFileName_class(dir, key, ext)

            FUNCTION_NAME = self.CLASS_NAME + "@getRandomFileName()";

            DT = DateTime_class();

            if ~isempty(dir), self.dir = dir; else, self.dir = "";                  end
            if ~isempty(key), self.key = key; else, self.key = "RandomFileName";    end
            if ~isempty(ext), self.ext = ext; else, self.ext = ".rfn";              end

            DT.query();

            self.path = self.dir + self.key + '_' + DT.date + '_' + DT.time + '_process_' + num2str(1) + '_' + self.ext;

        end

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

    end

%***********************************************************************************************************************************
%***********************************************************************************************************************************

end