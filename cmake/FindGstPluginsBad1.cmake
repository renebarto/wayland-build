# - Try to find GstPluginsBad1
# Once done this will define
#  GST_PLUGINS_BAD_FOUND - System has GstPluginsBad1
#  GST_PLUGINS_BAD_INCLUDE_DIR - The GstPluginsBad1 include directories
#  GST_PLUGINS_BAD_LIBRARIES - The libraries needed to use GstPluginsBad1
#  GST_PLUGINS_BAD_DEFINITIONS - Compiler switches required for using GstPluginsBad1

find_library(GST_PLUGINS_BAD_LIBRARY NAMES gstwaylandsink
        HINTS ${CMAKE_INSTALL_PREFIX}/lib/gstreamer-1.0)

set(GST_PLUGINS_BAD_LIBRARIES ${GST_PLUGINS_BAD_LIBRARY} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set GST_PLUGINS_BAD_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GST_PLUGINS_BAD DEFAULT_MSG
    GST_PLUGINS_BAD_LIBRARY)

if(GST_PLUGINS_BAD_FOUND)
    set(FOUND_TEXT_GST_PLUGINS_BAD "Found")
else()
    set(FOUND_TEXT_GST_PLUGINS_BAD "Not found")
endif()

message(STATUS "libgst-plugins-bad1.0: ${FOUND_TEXT_GST_PLUGINS_BAD}")
message(STATUS "  libs         : ${GST_PLUGINS_BAD_LIBRARIES}")

if (GST_PLUGINS_BAD_FOUND)
    message(STATUS "Found libgst-plugins-bad-1.0")
else()
    message(WARNING "Could not find libgst-plugins-bad-1.0, please install: sudo apt-get install gstreamer1.0-plugins-bad")
endif()

mark_as_advanced(
    GST_PLUGINS_BAD_LIBRARY)
