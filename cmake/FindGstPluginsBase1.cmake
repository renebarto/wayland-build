# - Try to find GstPluginsBase1
# Once done this will define
#  GST_PLUGINS_BASE_FOUND - System has GstPluginsBase1
#  GST_PLUGINS_BASE_INCLUDE_DIR - The GstPluginsBase1 include directories
#  GST_PLUGINS_BASE_LIBRARIES - The libraries needed to use GstPluginsBase1
#  GST_PLUGINS_BASE_DEFINITIONS - Compiler switches required for using GstPluginsBase1

find_package(PkgConfig)
pkg_check_modules(PC_GST_PLUGINS_BASE QUIET gstreamer-app-1.0)
set(GST_PLUGINS_BASE_DEFINITIONS ${PC_GST_PLUGINS_BASE_CFLAGS_OTHER})

if(PC_GST_PLUGINS_BASE_FOUND)
    set(FOUND_TEXT_GST_PLUGINS_BASE "Found")
else()
    set(FOUND_TEXT_GST_PLUGINS_BASE "Not found")
endif()

message(STATUS "libgst-plugins-base1.0: ${FOUND_TEXT_GST_PLUGINS_BASE}")
message(STATUS "  version      : ${PC_GST_PLUGINS_BASE_VERSION}")
message(STATUS "  cflags       : ${PC_GST_PLUGINS_BASE_CFLAGS}")
message(STATUS "  cflags other : ${PC_GST_PLUGINS_BASE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_GST_PLUGINS_BASE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_GST_PLUGINS_BASE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_GST_PLUGINS_BASE_LIBRARIES}")

find_path(GST_PLUGINS_BASE_INCLUDE_DIRS gstreamer-1.0/gst/app/app.h
    HINTS ${PC_GST_PLUGINS_BASE_INCLUDEDIR} ${PC_GST_PLUGINS_BASE_INCLUDE_DIRS})

find_library(GST_PLUGINS_BASE_LIBRARY NAMES gstapp-1.0
        HINTS ${PC_GST_PLUGINS_BASE_LIBDIR} ${PC_GST_PLUGINS_BASE_LIBRARY_DIRS})

set(GST_PLUGINS_BASE_LIBRARIES ${GST_PLUGINS_BASE_LIBRARY} )
set(GST_PLUGINS_BASE_INCLUDE_DIR ${GST_PLUGINS_BASE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set GST_PLUGINS_BASE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GST_PLUGINS_BASE DEFAULT_MSG
    GST_PLUGINS_BASE_LIBRARY GST_PLUGINS_BASE_INCLUDE_DIR)

if (GST_PLUGINS_BASE_FOUND)
    if(GST_PLUGINS_BASE_REQUIRED_VERSION)
        if (NOT "${GST_PLUGINS_BASE_REQUIRED_VERSION}" STREQUAL "${PC_GST_PLUGINS_BASE_VERSION}")
            message(WARNING "Incorrect version, please install libgst-plugins-base-${GST_PLUGINS_BASE_REQUIRED_VERSION}")
            unset(GST_PLUGINS_BASE_FOUND)
        endif()
    else()
        message(STATUS "Found libgst-plugins-base-1.0")
    endif()
else()
    message(WARNING "Could not find libgst-plugins-base-1.0, please install: sudo apt-get install gstreamer1.0-plugins-base")
endif()

mark_as_advanced(
    GST_PLUGINS_BASE_INCLUDE_DIR GST_PLUGINS_BASE_LIBRARY)
