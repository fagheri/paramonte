%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   ParaMonte: plain powerful parallel Monte Carlo library.
%
%   Copyright (C) 2012-present, The Computational Data Science Lab
%
%   This file is part of the ParaMonte library.
%
%   ParaMonte is free software: you can redistribute it and/or modify it 
%   under the terms of the GNU Lesser General Public License as published 
%   by the Free Software Foundation, version 3 of the License.
%
%   ParaMonte is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
%   GNU Lesser General Public License for more details.
%
%   You should have received a copy of the GNU Lesser General Public License
%   along with the ParaMonte library. If not, see, 
%
%       https://github.com/cdslaborg/paramonte/blob/master/LICENSE
%
%   ACKNOWLEDGMENT
%
%   As per the ParaMonte library license agreement terms, 
%   if you use any parts of this library for any purposes, 
%   we ask you to acknowledge the use of the ParaMonte library
%   in your work (education/research/industry/development/...)
%   by citing the ParaMonte library as described on this page:
%
%       https://github.com/cdslaborg/paramonte/blob/master/ACKNOWLEDGMENT.md
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef SpecBase_DomainUpperLimitVec_class < handle

    properties (Constant)
        CLASS_NAME  = "@SpecBase_DomainUpperLimitVec_class"
    end

    properties
        Val         = []
        def         = []
        desc        = []
    end

%***********************************************************************************************************************************
%***********************************************************************************************************************************

    methods (Access = public)

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

        function self = SpecBase_DomainUpperLimitVec_class(methodName)
            self.def    = Constants.POSINF_RK;
            self.desc   = "domainUpperLimitVec represents the upper boundaries of the cubical domain of the objective function to be sampled. "         ...
                        + "It is an ndim-dimensional vector of 64-bit real numbers, where ndim is the number of variables of the objective function. "  ...
                        + "It is also possible to assign only select values of domainUpperLimitVec and leave the rest of the components to be assigned "...
                        + "the default value. This is POSSIBLE ONLY when domainUpperLimitVec is defined inside the input file to " + methodName + ". "  ...
                        + "For example," + newline + newline                                                                                            ...
                        + "    domainUpperLimitVec(3:5) = 100" + newline + newline                                                                      ...
                        + "        will only set the upper limits of the third, fourth, and the fifth dimensions to 100, or," + newline + newline       ...
                        + "    domainUpperLimitVec(1) = 100, domainUpperLimitVec(2) = 1.e6 " + newline + newline                                        ...
                        + "        will set the upper limit on the first dimension to 100, and 1.e6 on the second dimension, or," + newline + newline   ...
                        + "    domainUpperLimitVec = 3*2.5e100" + newline + newline                                                                     ...
                        + "        will only set the upper limits on the first, second, and the third dimensions to 2.5*10^100, while the rest of "     ...
                        + "the upper limits for the missing dimensions will be automatically set to the default value." + newline + newline             ...
                        + "The default value for all elements of domainUpperLimitVec is: " + num2str(self.def) + "."                                    ...
                        ;
        end

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

        function set(self, nd, domainUpperLimitVec)
            if isempty(domainUpperLimitVec)
                self.Val(1:nd) = self.def;
            else
                self.Val = domainUpperLimitVec;
            end
        end

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

        function Err = checkForSanity(self, Err, DomainLowerLimitVec)

            FUNCTION_NAME = self.CLASS_NAME + "@checkForSanity()";

            for i = 1 : length(self.Val)
                if self.Val(i) > Constants.POSINF_RK
                Err.occurred    = true;
                Err.msg         = Err.msg                                                                                                   ...
                                + FUNCTION_NAME + ": Error occurred. "                                                                      ...
                                + "The upper limit of the component "                                                                       ...
                                + num2str(i) + " of the variable domainUpperLimitVec (" + num2str(self.Val(i)) + ") "                       ...
                                + "cannot be larger than the largest positive real number representable in the simulation ("                ...
                                + num2str(Constants.POSINF_RK) + ")." + newline + newline                                                   ...
                                ;
                end
                if self.Val(i) <= DomainLowerLimitVec(i)
                Err.occurred    = true;
                Err.msg         = Err.msg                                                                                                   ...
                                + FUNCTION_NAME + ": Error occurred. "                                                                      ...
                                + "The input value for the upper limit of the component "                                                   ...
                                + num2str(i) + " of the variable domainUpperLimitVec cannot be smaller than or equal to the input value "   ...
                                + "for the lower limit of the corresponding dimension as given by DomainLowerLimitVec:" + newline           ...
                                + "    DomainLowerLimitVec(" + num2str(i) + ") = " + num2str(DomainLowerLimitVec(i)) + newline              ...
                                + "    domainUpperLimitVec(" + num2str(i) + ") = " + num2str(self.Val(i)) + newline + newline               ...
                                ;
                end
            end
        end

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

    end

%***********************************************************************************************************************************
%***********************************************************************************************************************************

end