# - Try to find LibFFI
# Once done this will define
#  MESA_FOUND - System has LibFFI
#  MESA_INCLUDE_DIR - The LibFFI include directories
#  MESA_LIBRARIES - The libraries needed to use LibFFI
#  MESA_DEFINITIONS - Compiler switches required for using LibFFI

find_package(PkgConfig)
pkg_check_modules(PC_MESA QUIET mesa)
set(MESA_DEFINITIONS ${PC_MESA_CFLAGS_OTHER})

if(PC_MESA_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "mesa           : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_LIBRARIES}")

find_path(MESA_INCLUDE_DIRS mesa.h
        HINTS ${PC_MESA_INCLUDEDIR} ${PC_MESA_INCLUDE_DIRS})

find_library(MESA_LIBRARY NAMES z
        HINTS ${PC_MESA_LIBDIR} ${PC_MESA_LIBRARY_DIRS})

set(MESA_LIBRARIES ${MESA_LIBRARY} )
set(MESA_INCLUDE_DIR ${MESA_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set MESA_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(MESA DEFAULT_MSG
        MESA_LIBRARY MESA_INCLUDE_DIR)

if (MESA_FOUND)
    if(MESA_REQUIRED_VERSION)
        if (NOT "${MESA_REQUIRED_VERSION}" STREQUAL "${PC_MESA_VERSION}")
            message(WARNING "Incorrect version, please install libffi-${MESA_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found mesa")
    endif()
else()
    message(WARNING "Could not find mesa, please install: sudo apt-get install mesa-dev")
endif()

mark_as_advanced(MESA_INCLUDE_DIR MESA_LIBRARY)
