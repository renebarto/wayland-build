#.rst:
# FindWaylandProtocols
# -------
#
# Find wayland protocol description files
#
# Try to find wayland protocol files. The following values are defined
#
# ::
#
#   WAYLANDPROTOCOLS_FOUND         - True if wayland protocol files are available
#   WAYLANDPROTOCOLS_PATH          - Path to wayland protocol files
#
#=============================================================================
#
# Copyright (c) 2017 Rene Barto
#
# Based on:
# Copyright (c) 2015 Jari Vetoniemi
#
# Distributed under the OSI-approved BSD License (the "License");
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================

include(FeatureSummary)
set_package_properties(WaylandProtocols PROPERTIES
        URL "https://cgit.freedesktop.org/wayland/wayland-protocols"
        DESCRIPTION "Wayland protocol development")

unset(WAYLAND_PROTOCOLS_PATH)

find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
    execute_process(COMMAND ${PKG_CONFIG_EXECUTABLE} --variable=pkgdatadir wayland-protocols
            OUTPUT_VARIABLE WAYLAND_PROTOCOLS_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
endif ()
pkg_check_modules(PC_WAYLAND_PROTOCOLS QUIET wayland-protocols)

if(PC_WAYLAND_PROTOCOLS_FOUND)
    set(WAYLAND_PROTOCOLS_FOUND_TEXT "Found")
else()
    set(WAYLAND_PROTOCOLS_FOUND_TEXT "Not found")
endif()

message(STATUS "wayland-protocols: ${WAYLAND_PROTOCOLS_FOUND_TEXT}")
message(STATUS "  version      : ${PC_WAYLAND_PROTOCOLS_VERSION}")
message(STATUS "  cflags       : ${PC_WAYLAND_PROTOCOLS_CFLAGS}")
message(STATUS "  cflags other : ${PC_WAYLAND_PROTOCOLS_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_WAYLAND_PROTOCOLS_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_WAYLAND_PROTOCOLS_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_WAYLAND_PROTOCOLS_LIBRARIES}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(WAYLAND_PROTOCOLS DEFAULT_MSG WAYLAND_PROTOCOLS_PATH)

if (WAYLAND_PROTOCOLS_FOUND)
    if(WAYLAND_PROTOCOLS_REQUIRED_VERSION)
        if (NOT "${WAYLAND_PROTOCOLS_REQUIRED_VERSION}" STREQUAL "${PC_WAYLAND_PROTOCOLS_VERSION}")
            message(WARNING "Incorrect version, please install wayland-protocols-${WAYLAND_PROTOCOLS_REQUIRED_VERSION}")
            unset(WAYLAND_PROTOCOLS_FOUND)
        endif()
    else()
        message(STATUS "Found wayland-protocols")
    endif()
else()
    message(WARNING "Could not find wayland-protocols, please install: sudo apt-get install wayland-protocols")
endif()

mark_as_advanced(WAYLAND_PROTOCOLS_PATH)
