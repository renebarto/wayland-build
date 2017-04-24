# - Try to find LibXau
# Once done this will define
#  LIBXAU_FOUND - System has LibXau
#  LIBXAU_INCLUDE_DIR - The LibXau include directories
#  LIBXAU_LIBRARIES - The libraries needed to use LibXau
#  LIBXAU_DEFINITIONS - Compiler switches required for using LibXau

find_package(PkgConfig)
pkg_check_modules(PC_LIBXAU QUIET xau)
set(LIBXAU_DEFINITIONS ${PC_LIBXAU_CFLAGS_OTHER})

if(PC_LIBXAU_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxau         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXAU_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXAU_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXAU_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXAU_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXAU_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXAU_LIBRARIES}")

find_path(LIBXAU_INCLUDE_DIRS X11/Xauth.h
        HINTS ${PC_LIBXAU_INCLUDEDIR} ${PC_LIBXAU_INCLUDE_DIRS})

find_library(LIBXAU_LIBRARY NAMES Xau
        HINTS ${PC_LIBXAU_LIBDIR} ${PC_LIBXAU_LIBRARY_DIRS})

set(LIBXAU_LIBRARIES ${LIBXAU_LIBRARY} )
set(LIBXAU_INCLUDE_DIR ${LIBXAU_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXAU_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXAU DEFAULT_MSG
        LIBXAU_LIBRARY LIBXAU_INCLUDE_DIR)

if (LIBXAU_FOUND)
    if(LIBXAU_REQUIRED_VERSION)
        if (NOT "${LIBXAU_REQUIRED_VERSION}" STREQUAL "${PC_LIBXAU_VERSION}")
            message(WARNING "Incorrect version, please install libxau-${LIBXAU_REQUIRED_VERSION}")
            unset(LIBXAU_FOUND)
        endif()
    else()
        message(STATUS "Found libxau")
    endif()
else()
    message(WARNING "Could not find libxau, please install: sudo apt-get install libxau-dev")
endif()

mark_as_advanced(LIBXAU_INCLUDE_DIR LIBXAU_LIBRARY)
