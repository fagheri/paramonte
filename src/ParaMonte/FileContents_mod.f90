!**********************************************************************************************************************************
!**********************************************************************************************************************************
!
!  ParaMonte: plain powerful parallel Monte Carlo library.
!
!  Copyright (C) 2012-present, The Computational Data Science Lab
!
!  This file is part of ParaMonte library. 
!
!  ParaMonte is free software: you can redistribute it and/or modify
!  it under the terms of the GNU Lesser General Public License as published by
!  the Free Software Foundation, version 3 of the License.
!
!  ParaMonte is distributed in the hope that it will be useful,
!  but WITHOUT ANY WARRANTY; without even the implied warranty of
!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!  GNU Lesser General Public License for more details.
!
!  You should have received a copy of the GNU Lesser General Public License
!  along with ParaMonte.  If not, see <https://www.gnu.org/licenses/>.
!
!**********************************************************************************************************************************
!**********************************************************************************************************************************

module FileContents_mod

    use JaggedArray_mod, only: CharVec_type
    use Err_mod, only: Err_type
    implicit none

    character(*), parameter                 :: MODULE_NAME = "@FileContents_mod"

    type :: FileContents_type
        integer                             :: numRecord
        type(CharVec_type), allocatable     :: Line(:)
        type(Err_type)                      :: Err
    contains
        procedure, nopass                   :: getNumRecordInFile
        procedure, nopass                   :: getFileContents
    end type FileContents_type

    interface FileContents_type 
        module procedure :: constructFileContents
    end interface FileContents_type 

!***********************************************************************************************************************************
!***********************************************************************************************************************************

contains

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    function constructFileContents(filePath) result(FileContents)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: constructFileContents
#endif
        implicit none
        character(*), intent(in)    :: filePath
        type(FileContents_type)      :: FileContents
        call getFileContents(filePath,FileContents%Line,FileContents%numRecord,FileContents%Err)
        if (FileContents%Err%occurred) FileContents%Err%msg = "@constructFileContents()" // FileContents%Err%msg
    end function constructFileContents

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    ! returns the entire content of a file as an array of strings.
    ! each array element corresponds to one line (record) in the file.
    subroutine getFileContents(path,Contents,numRecord,Err)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: getFileContents
#endif
        use JaggedArray_mod, only: CharVec_type
        use String_mod, only: num2str
        use Err_mod, only: Err_type
        implicit none
        character(len=*), intent(in)                    :: path
        type(CharVec_type), allocatable, intent(out)    :: Contents(:)
        integer, intent(out)                            :: numRecord
        type(Err_type), intent(out)                     :: Err

        character(99999)                                :: record
        integer                                         :: fileUnit, irecord, iostat

        character(*), parameter                         :: PROCEDURE_NAME = "@getFileContents()"

        Err%occurred = .false.
        Err%msg = ""

        call getNumRecordInFile(path,numRecord,Err)
        if (Err%occurred) then
            Err%msg = PROCEDURE_NAME // Err%msg
            return
        end if

        allocate(Contents(numRecord))

        open(newunit=fileUnit,file=path,status="old")
        do irecord = 1,numRecord
            read(fileUnit,"(A)",iostat=Err%stat) record
            if (Err%stat==0) then
                Contents(irecord)%record = trim(adjustl(record))
            elseif (is_iostat_end(iostat)) then
                Err%occurred = .true.
                Err%msg =   PROCEDURE_NAME // ": End-of-file error occurred while expecting " // &
                            num2str(numRecord-irecord+1) // " records in file='" // path // "'."
                return
            elseif (is_iostat_eor(iostat)) then
                Err%occurred = .true.
                Err%msg =   PROCEDURE_NAME // ": End-of-record error occurred while reading line number " // &
                            num2str(irecord) // " from file='" // path // "'."
                return
            else
                Err%occurred = .true.
                Err%msg =   PROCEDURE_NAME // ": Unknown error occurred while reading line number " // &
                            num2str(irecord) // " from file='" // path // "'."
                return
            end if
        end do

        close(fileUnit,iostat=Err%stat)
        if (Err%stat>0) then
            Err%occurred = .true.
            Err%msg = PROCEDURE_NAME // "Error occurred while attempting to close the open file='" // path // "'."
            return
        end if

    end subroutine getFileContents

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    ! returns the number of lines in a file.
    subroutine getNumRecordInFile(filePath,numRecord,Err,exclude)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: getNumRecordInFile
#endif
        use Constants_mod, only: IK
        implicit none
        character(len=*), intent(in)                :: filePath
        integer(IK)     , intent(out)               :: numRecord
        type(Err_type)  , intent(out)               :: Err
        character(*)    , intent(in)    , optional  :: exclude
        character(len=1)                            :: record
        integer                                     :: fileUnit
        logical                                     :: fileExists, fileIsOpen, excludeIsPresent
        integer                                     :: iostat

        character(*), parameter                     :: PROCEDURE_NAME = "@getNumRecordInFile()"

        Err%occurred = .false.
        Err%msg = ""
        excludeIsPresent = present(exclude)

        ! Check if file exists
        inquire( file=filePath, exist=fileExists, opened=fileIsOpen, number=fileUnit, iostat=Err%stat )
        if (Err%stat/=0) then
            Err%occurred = .true.
            Err%msg = PROCEDURE_NAME // ": Error occurred while inquiring the status of file='" // filePath // "'."
            return
        end if
        if (.not.fileExists) then
            Err%occurred = .true.
            Err%msg = PROCEDURE_NAME // ": The input file='" // filePath // "' does not exist."
            return
        end if
        if (fileIsOpen) close(unit=fileUnit,iostat=Err%stat)
        if (Err%stat>0) then
            Err%occurred = .true.
            Err%msg = PROCEDURE_NAME // ": Error occurred while attempting to close the open input file='" // filePath // "'."
            return
        end if

        open(newunit=fileUnit,file=filePath,status="old",iostat=Err%stat)
        if (Err%stat>0) then
            Err%occurred = .true.
            Err%msg = PROCEDURE_NAME // ": Error occurred while opening input file='" // filePath // "'."
            return
        end if

        numRecord = 0_IK
        do
            read(fileUnit,'(A)',iostat=iostat) record
            if(iostat==0) then
                if (excludeIsPresent) then
                    if (trim(adjustl(record))/=exclude) numRecord = numRecord + 1_IK
                else
                    numRecord = numRecord + 1_IK
                end if
                cycle
            elseif(is_iostat_end(iostat)) then
                exit
            else
                Err%occurred = .true.
                Err%stat = iostat
                Err%msg = PROCEDURE_NAME // ": Error occurred while reading input file='" // filePath // "'."
                return
            end if
        end do
        close(fileUnit,iostat=Err%stat)
        if (Err%stat>0) then
            Err%occurred = .true.
            Err%msg =   PROCEDURE_NAME // ": Error occurred while attempting to close the open input file='" // &
                        filePath // "' after counting the number of records in file."
            return
        end if

    end subroutine getNumRecordInFile

!***********************************************************************************************************************************
!***********************************************************************************************************************************

end module FileContents_mod