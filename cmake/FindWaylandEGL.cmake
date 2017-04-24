# - Try to Find Wayland EGL
#
# Copyright (C) 2017 Rene Barto
#
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#
# Will be defined:
# WAYLAND_EGL_FOUND
# WAYLAND_EGL_INCLUDE_DIR
# WAYLAND_EGL_LIBRARIES
#

find_package(PkgConfig)
pkg_check_modules(PC_WAYLAND_EGL QUIET wayland-egl)

if(PC_WAYLAND_EGL_FOUND)
    set(WAYLAND_EGL_FOUND_TEXT "Found")
else()
    set(WAYLAND_EGL_FOUND_TEXT "Not found")
endif()

message(STATUS "wayland-egl    : ${WAYLAND_EGL_FOUND_TEXT}")
message(STATUS "  version      : ${PC_WAYLAND_EGL_VERSION}")
message(STATUS "  cflags       : ${PC_WAYLAND_EGL_CFLAGS}")
message(STATUS "  cflags other : ${PC_WAYLAND_EGL_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_WAYLAND_EGL_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_WAYLAND_EGL_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_WAYLAND_EGL_LIBRARIES}")

# find include paths
find_path(WAYLAND_EGL_INCLUDE_DIR wayland-egl.h ${PC_WAYLAND_SERVER_INCLUDE_DIRS})

# find libs
find_library(WAYLAND_EGL_LIBRARIES NAMES wayland-client PATHS ${PC_WAYLAND_EGL_LIBRARY_DIRS})
find_library(WAYLAND_SERVER_LIBRARIES NAMES wayland-server PATHS ${PC_WAYLAND_SERVER_LIBRARY_DIRS})
find_library(WAYLAND_CURSOR_LIBRARIES NAMES wayland-cursor PATHS ${PC_WAYLAND_CURSOR_LIBRARY_DIRS})
#find_library(WAYLAND_EGL_LIBRARIES NAMES wayland-egl PATHS ${PC_WAYLAND_EGL_LIBRARY_DIRS})

# set _FOUND vars
if (NOT ${WAYLAND_EGL_INCLUDE_DIR} STREQUAL "" AND NOT ${WAYLAND_EGL_LIBRARIES} STREQUAL "")
    set(WAYLAND_EGL_FOUND TRUE)
endif()
if (NOT ${WAYLAND_SERVER_INCLUDE_DIR} STREQUAL "" AND NOT ${WAYLAND_SERVER_LIBRARIES} STREQUAL "")
    set(WAYLAND_SERVER_FOUND TRUE)
endif()
if (NOT ${WAYLAND_CURSOR_INCLUDE_DIR} STREQUAL "" AND NOT ${WAYLAND_CURSOR_LIBRARIES} STREQUAL "")
    set(WAYLAND_CURSOR_FOUND TRUE)
endif()
#if (NOT ${WAYLAND_EGL_INCLUDE_DIR} STREQUAL "" AND NOT ${WAYLAND_EGL_LIBRARIES} STREQUAL "")
#set(WAYLAND_EGL_FOUND TRUE)
#endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(WAYLAND DEFAULT_MSG
        WAYLAND_EGL_INCLUDE_DIR WAYLAND_EGL_LIBRARIES
        WAYLAND_SERVER_INCLUDE_DIR WAYLAND_SERVER_LIBRARIES
        WAYLAND_CURSOR_INCLUDE_DIR WAYLAND_CURSOR_LIBRARIES)
#        WAYLAND_EGL_INCLUDE_DIR WAYLAND_EGL_LIBRARIES)

if (WAYLAND_FOUND)
    if (WAYLAND_REQUIRED_VERSION)
        if (NOT "${WAYLAND_REQUIRED_VERSION}" STREQUAL "${PC_WAYLAND_EGL_VERSION}")
            message(WARNING "Incorrect version, please install wayland-${WAYLAND_REQUIRED_VERSION}")
            unset(WAYLAND_EGL_FOUND)
            unset(WAYLAND_SERVER_FOUND)
            unset(WAYLAND_CURSOR_FOUND)
            unset(WAYLAND_FOUND)
        endif()
    else()
        message(STATUS "Found wayland")
    endif()
else()
    message(WARNING "Could not find wayland, please install: sudo apt-get install libwayland-dev")
endif()

mark_as_advanced(
        WAYLAND_EGL_INCLUDE_DIR WAYLAND_EGL_LIBRARIES
        WAYLAND_SERVER_INCLUDE_DIR WAYLAND_SERVER_LIBRARIES
        WAYLAND_CURSOR_INCLUDE_DIR WAYLAND_CURSOR_LIBRARIES)
#        WAYLAND_EGL_INCLUDE_DIR WAYLAND_EGL_LIBRARIES)
