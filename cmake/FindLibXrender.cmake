# - Try to find LibXrender
# Once done this will define
#  LIBXRENDER_FOUND - System has LibXrender
#  LIBXRENDER_INCLUDE_DIR - The LibXrender include directories
#  LIBXRENDER_LIBRARIES - The libraries needed to use LibXrender
#  LIBXRENDER_DEFINITIONS - Compiler switches required for using LibXrender

find_package(PkgConfig)
pkg_check_modules(PC_LIBXRENDER QUIET xrender)
set(LIBXRENDER_DEFINITIONS ${PC_LIBXRENDER_CFLAGS_OTHER})

if(PC_LIBXRENDER_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxrender     : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXRENDER_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXRENDER_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXRENDER_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXRENDER_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXRENDER_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXRENDER_LIBRARIES}")

find_path(LIBXRENDER_INCLUDE_DIRS X11/extensions/Xrender.h
        HINTS ${PC_LIBXRENDER_INCLUDEDIR} ${PC_LIBXRENDER_INCLUDE_DIRS})

find_library(LIBXRENDER_LIBRARY NAMES Xrender
        HINTS ${PC_LIBXRENDER_LIBDIR} ${PC_LIBXRENDER_LIBRARY_DIRS})

set(LIBXRENDER_LIBRARIES ${LIBXRENDER_LIBRARY} )
set(LIBXRENDER_INCLUDE_DIR ${LIBXRENDER_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXRENDER_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXRENDER DEFAULT_MSG
        LIBXRENDER_LIBRARY LIBXRENDER_INCLUDE_DIR)

if (LIBXRENDER_FOUND)
    if(LIBXRENDER_REQUIRED_VERSION)
        if (NOT "${LIBXRENDER_REQUIRED_VERSION}" STREQUAL "${PC_LIBXRENDER_VERSION}")
            message(WARNING "Incorrect version, please install libxrender-${LIBXRENDER_REQUIRED_VERSION}")
            unset(LIBXRENDER_FOUND)
        endif()
    else()
        message(STATUS "Found libxrender")
    endif()
else()
    message(WARNING "Could not find libxrender, please install: sudo apt-get install libxrender-dev")
endif()

mark_as_advanced(LIBXRENDER_INCLUDE_DIR LIBXRENDER_LIBRARY)
