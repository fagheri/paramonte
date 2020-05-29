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
classdef Constants < handle

    properties (Constant)

        PI              = 3.141592653589793238462643383279502884197     % = acos(-1.) : The irrational number Pi.
        TWOPI           = 6.283185307179586476925286766559005768394     % 2*PI
        LN2             = log(2.)                                       % Natural Log of 2 (= 0.693147180559945).
        INVLN2          = 1. / Constants.LN2                            % Inverse of the natural Log of 2 (= 0.693147180559945).
        LN10            = log(1.e1)                                     % Natural Log of 10 (= 2.302585092994046).
        LN2PI           = log(2.*Constants.PI)                          % ln(2pi) (= 1.837877066409345)
        SQRT2           = sqrt(2.)                                      % Square root of 2.
        NAPIER          = exp(1.)                                       % Napier number e.
        SQRTPI          = sqrt(Constants.PI)                            % Square root of Pi.
        SQRT2PI         = sqrt(2.*acos(-1.))                            % Square root of 2Pi.
        HALFLN2PI       = 0.5*Constants.LN2PI                           % ln(sqrt(2pi))
        INVSQRT2PI      = 1. / Constants.SQRT2PI                        % 1/sqrt(2*Pi) (= 0.398942280401432)
        LOGINVSQRT2PI   = log(Constants.INVSQRT2PI)                     % Log(1/sqrt(2Pi)), used in Gaussian distribution.
        SQRT_HALF_PI    = sqrt(0.5*Constants.PI)                        % Square root of PI/2 (= 1.2533141373155)
        LOG10NAPIER     = log10(Constants.NAPIER)                       % Log10 of Napier constant (= 0.434294481903259).
        EPS             = eps                                           % the smallest representable real increment (highest precision) by the machine
        HUGE_IK         = intmax                                        % largest number of kind RK
        HUGE_RK         = realmax                                       % largest number of kind RK
        TINY_RK         = realmin                                       % tiniest number of kind RK
        LOGHUGE_RK      = log(Constants.HUGE_RK)                        % log of the largest number of kind RK
        LOGTINY_RK      = log(Constants.TINY_RK)                        % log of the largest number of kind RK
        POSINF_RK       =  Constants.HUGE_RK / 1.e1                     % the division is done to avoid overflow in output
        POSINF_IK       =  Constants.HUGE_IK / 2                        % the division is done to avoid overflow in output
        NEGINF_RK       = -Constants.POSINF_RK
        NEGINF_IK       = -Constants.POSINF_IK
        NULL_RK         = -Constants.HUGE_RK
        NULL_IK         = -Constants.HUGE_IK
        NULL_SK         = char(30)                                      % This must remain a single character as it is assumed in multiple routines: Record separator
        NLC             = convertCharsToStrings(newline)                                       % new line character
        CARRIAGE_RETURN = char(13)
        ESCAPE          = char(27)
        CLOCK_TICK      = '|/-\';
        FILE_TYPE       = struct('binary', "binary", 'matlab', 'MATLAB', 'python', "Python", 'julia', "Julia", 'ascii', "ASCII", 'rlang', "R");
        FILE_EXT        = struct('binary', ".bin", 'matlab', ".m", 'python', ".py", 'julia', ".jl", 'ascii', ".txt", 'r', ".R" );
        PMSM            = struct('count', "4", 'ParaDRAM', "ParaDRAM", 'ParaHDMC', "ParaHDMC", 'ParaTemp', "ParaTemp", 'ParaNest', "ParaNest");

    end

end