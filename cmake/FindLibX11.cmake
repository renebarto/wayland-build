# - Try to find LibX11
# Once done this will define
#  LIBX11_FOUND - System has LibX11
#  LIBX11_INCLUDE_DIR - The LibX11 include directories
#  LIBX11_LIBRARIES - The libraries needed to use LibX11
#  LIBX11_DEFINITIONS - Compiler switches required for using LibX11

find_package(PkgConfig)
pkg_check_modules(PC_LIBX11 QUIET x11)
set(LIBX11_DEFINITIONS ${PC_LIBX11_CFLAGS_OTHER})

if(PC_LIBX11_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libx11         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBX11_VERSION}")
message(STATUS "  cflags       : ${PC_LIBX11_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBX11_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBX11_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBX11_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBX11_LIBRARIES}")

find_path(LIBX11_INCLUDE_DIRS X11/XlibConf.h X11/Xlib.h
        HINTS ${PC_LIBX11_INCLUDEDIR} ${PC_LIBX11_INCLUDE_DIRS})

find_library(LIBX11_LIBRARY NAMES X11 X11-xcb
        HINTS ${PC_LIBX11_LIBDIR} ${PC_LIBX11_LIBRARY_DIRS})

set(LIBX11_LIBRARIES ${LIBX11_LIBRARY} )
set(LIBX11_INCLUDE_DIR ${LIBX11_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBX11_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBX11 DEFAULT_MSG
        LIBX11_LIBRARY LIBX11_INCLUDE_DIR)

if (LIBX11_FOUND)
    if(LIBX11_REQUIRED_VERSION)
        if (NOT "${LIBX11_REQUIRED_VERSION}" STREQUAL "${PC_LIBX11_VERSION}")
            message(WARNING "Incorrect version, please install libx11-${LIBX11_REQUIRED_VERSION}")
            unset(LIBX11_FOUND)
        endif()
    else()
        message(STATUS "Found libx11")
    endif()
else()
    message(WARNING "Could not find libx11, please install: sudo apt-get install libx11-dev")
endif()

mark_as_advanced(LIBX11_INCLUDE_DIR LIBX11_LIBRARY)
