# - Try to find LibJPEGTurbo
# Once done this will define
#  LIBJPEGTURBO_FOUND - System has LibJPEGTurbo
#  LIBJPEGTURBO_INCLUDE_DIR - The LibJPEGTurbo include directories
#  LIBJPEGTURBO_LIBRARIES - The libraries needed to use LibJPEGTurbo
#  LIBJPEGTURBO_DEFINITIONS - Compiler switches required for using LibJPEGTurbo

find_package(PkgConfig)
pkg_check_modules(PC_LIBJPEGTURBO QUIET libjpeg)
set(LIBJPEGTURBO_DEFINITIONS ${PC_LIBJPEGTURBO_CFLAGS_OTHER})

if(PC_LIBJPEGTURBO_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libjpegturbo   : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBJPEGTURBO_VERSION}")
message(STATUS "  cflags       : ${PC_LIBJPEGTURBO_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBJPEGTURBO_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBJPEGTURBO_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBJPEGTURBO_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBJPEGTURBO_LIBRARIES}")

find_path(LIBJPEGTURBO_INCLUDE_DIRS turbojpeg.h
        HINTS ${PC_LIBJPEGTURBO_INCLUDEDIR} ${PC_LIBJPEGTURBO_INCLUDE_DIRS})

find_library(LIBJPEGTURBO_LIBRARY NAMES turbojpeg
        HINTS ${PC_LIBJPEGTURBO_LIBDIR} ${PC_LIBJPEGTURBO_LIBRARY_DIRS} )

set(LIBJPEGTURBO_LIBRARIES ${LIBJPEGTURBO_LIBRARY} )
set(LIBJPEGTURBO_INCLUDE_DIR ${LIBJPEGTURBO_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBJPEGTURBO_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LibJPEGTurbo DEFAULT_MSG
        LIBJPEGTURBO_LIBRARY LIBJPEGTURBO_INCLUDE_DIR)

if (LIBJPEGTURBO_FOUND)
    if(LIBJPEGTURBO_REQUIRED_VERSION)
        if (NOT "${LIBJPEGTURBO_REQUIRED_VERSION}" STREQUAL "${PC_LIBJPEGTURBO_VERSION}")
            message(WARNING "Incorrect version, please install libjpegturbo-${LIBJPEGTURBO_REQUIRED_VERSION}")
            unset(LIBJPEGTURBO_FOUND)
        endif()
    else()
        message(STATUS "Found libjpegturbo")
    endif()
else()
    message(WARNING "Could not find libjpegturbo, please install: sudo apt-get install libjpegturbo-dev")
endif()

mark_as_advanced(LIBJPEGTURBO_INCLUDE_DIR LIBJPEGTURBO_LIBRARY)
