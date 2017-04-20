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

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(WaylandProtocols DEFAULT_MSG WAYLAND_PROTOCOLS_PATH)

if (WAYLAND_PROTOCOLS_FOUND)
    message(STATUS "Found wayland-protocols")
else()
    message(WARNING "Could not find wayland-protocols, please install: sudo apt-get install wayland-protocols")
endif()

mark_as_advanced(WAYLAND_PROTOCOLS_PATH)
