# - Try to find LibXau
# Once done this will define
#  XTRANS_FOUND - System has LibXau
#  XTRANS_INCLUDE_DIR - The LibXau include directories
#  XTRANS_LIBRARIES - The libraries needed to use LibXau
#  XTRANS_DEFINITIONS - Compiler switches required for using LibXau

find_package(PkgConfig)
pkg_check_modules(PC_XTRANS QUIET xtrans)
set(XTRANS_DEFINITIONS ${PC_XTRANS_CFLAGS_OTHER})

if(PC_XTRANS_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "xtrans         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_XTRANS_VERSION}")
message(STATUS "  cflags       : ${PC_XTRANS_CFLAGS}")
message(STATUS "  cflags other : ${PC_XTRANS_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_XTRANS_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_XTRANS_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_XTRANS_LIBRARIES}")

find_path(XTRANS_INCLUDE_DIRS X11/Xtrans/Xtrans.h
        HINTS ${PC_XTRANS_INCLUDEDIR} ${PC_XTRANS_INCLUDE_DIRS})

set(XTRANS_LIBRARIES ${XTRANS_LIBRARY} )
set(XTRANS_INCLUDE_DIR ${XTRANS_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set XTRANS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(XTRANS DEFAULT_MSG
        XTRANS_INCLUDE_DIR)

if (XTRANS_FOUND)
    if(XTRANS_REQUIRED_VERSION)
        if (NOT "${XTRANS_REQUIRED_VERSION}" STREQUAL "${PC_XTRANS_VERSION}")
            message(WARNING "Incorrect version, please install xtrans-${XTRANS_REQUIRED_VERSION}")
            unset(XTRANS_FOUND)
        endif()
    else()
        message(STATUS "Found xtrans")
    endif()
else()
    message(WARNING "Could not find xtrans, please install: sudo apt-get install xtrans-dev")
endif()

mark_as_advanced(XTRANS_INCLUDE_DIR XTRANS_LIBRARY)
