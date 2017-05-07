# - Try to find GstPluginsGood1
# Once done this will define
#  GST_PLUGINS_GOOD_FOUND - System has GstPluginsGood1
#  GST_PLUGINS_GOOD_INCLUDE_DIR - The GstPluginsGood1 include directories
#  GST_PLUGINS_GOOD_LIBRARIES - The libraries needed to use GstPluginsGood1
#  GST_PLUGINS_GOOD_DEFINITIONS - Compiler switches required for using GstPluginsGood1

find_library(GST_PLUGINS_GOOD_LIBRARY NAMES gstequalizer
        HINTS ${CMAKE_INSTALL_PREFIX}/lib/gstreamer-1.0)

set(GST_PLUGINS_GOOD_LIBRARIES ${GST_PLUGINS_GOOD_LIBRARY} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set GST_PLUGINS_GOOD_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GST_PLUGINS_GOOD DEFAULT_MSG
    GST_PLUGINS_GOOD_LIBRARY)

if(GST_PLUGINS_GOOD_FOUND)
    set(FOUND_TEXT_GST_PLUGINS_GOOD "Found")
else()
    set(FOUND_TEXT_GST_PLUGINS_GOOD "Not found")
endif()

message(STATUS "libgst-plugins-good1.0: ${FOUND_TEXT_GST_PLUGINS_GOOD}")
message(STATUS "  libs         : ${GST_PLUGINS_GOOD_LIBRARIES}")

if (GST_PLUGINS_GOOD_FOUND)
    message(STATUS "Found libgst-plugins-good-1.0")
else()
    message(WARNING "Could not find libgst-plugins-good-1.0, please install: sudo apt-get install gstreamer1.0-plugins-good")
endif()

mark_as_advanced(
    GST_PLUGINS_GOOD_LIBRARY)
