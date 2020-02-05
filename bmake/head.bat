::**********************************************************************************************************************************
::**********************************************************************************************************************************
::
::  ParaMonte: plain powerful parallel Monte Carlo library.
::
::  Copyright (C) 2012-present, The Computational Data Science Lab
::
::  This file is part of ParaMonte library. 
::
::  ParaMonte is free software: you can redistribute it and/or modify
::  it under the terms of the GNU Lesser General Public License as published by
::  the Free Software Foundation, version 3 of the License.
::
::  ParaMonte is distributed in the hope that it will be useful,
::  but WITHOUT ANY WARRANTY; without even the implied warranty of
::  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
::  GNU Lesser General Public License for more details.
::
::  You should have received a copy of the GNU Lesser General Public License
::  along with ParaMonte.  If not, see <https://www.gnu.org/licenses/>.
::
::**********************************************************************************************************************************
::**********************************************************************************************************************************

@echo off

if [%1] == [] goto usage
if [%2] == [] goto usage

call :print_head %1 %2
goto :eof

REM
REM print_head
REM Prints the first non-blank %1 lines in the file %2.
REM
:print_head
setlocal EnableDelayedExpansion
set /a counter=0

for /f ^"usebackq^ eol^=^

^ delims^=^" %%a in (%2) do (
        if "!counter!"=="%1" goto :eof
        echo %%a
        set /a counter+=1
)

goto :eof

:usage
echo Usage: head.bat COUNT FILENAME