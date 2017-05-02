# - Try to find GStreamer1
# Once done this will define
#  GSTREAMER_FOUND - System has GStreamer1
#  GSTREAMER_INCLUDE_DIR - The GStreamer1 include directories
#  GSTREAMER_LIBRARIES - The libraries needed to use GStreamer1
#  GSTREAMER_DEFINITIONS - Compiler switches required for using GStreamer1

find_package(PkgConfig)
pkg_check_modules(PC_GSTREAMER QUIET gstreamer-1.0)
pkg_check_modules(PC_GSTREAMER_BASE QUIET gstreamer-base-1.0)
pkg_check_modules(PC_GSTREAMER_CHECK QUIET gstreamer-check-1.0)
pkg_check_modules(PC_GSTREAMER_CONTROLLER QUIET gstreamer-controller-1.0)
pkg_check_modules(PC_GSTREAMER_NET QUIET gstreamer-net-1.0)
set(GSTREAMER_DEFINITIONS ${PC_GSTREAMER_CFLAGS_OTHER})
set(GSTREAMER_BASE_DEFINITIONS ${PC_GSTREAMER_BASE_CFLAGS_OTHER})
set(GSTREAMER_CHECK_DEFINITIONS ${PC_GSTREAMER_CHECK_CFLAGS_OTHER})
set(GSTREAMER_CONTROLLER_DEFINITIONS ${PC_GSTREAMER_CONTROLLER_CFLAGS_OTHER})
set(GSTREAMER_NET_DEFINITIONS ${PC_GSTREAMER_NETCFLAGS_OTHER})

if(PC_GSTREAMER_FOUND)
    set(FOUND_TEXT_GSTREAMER "Found")
else()
    set(FOUND_TEXT_GSTREAMER "Not found")
endif()

if(PC_GSTREAMER_BASE_FOUND)
    set(FOUND_TEXT_GSTREAMER_BASE "Found")
else()
    set(FOUND_TEXT_GSTREAMER_BASE "Not found")
endif()

if(PC_GSTREAMER_CHECK_FOUND)
    set(FOUND_TEXT_GSTREAMER_CHECK "Found")
else()
    set(FOUND_TEXT_GSTREAMER_CHECK "Not found")
endif()

if(PC_GSTREAMER_CONTROLLER_FOUND)
    set(FOUND_TEXT_GSTREAMER_CONTROLLER "Found")
else()
    set(FOUND_TEXT_GSTREAMER_CONTROLLER "Not found")
endif()

if(PC_GSTREAMER_NET_FOUND)
    set(FOUND_TEXT_GSTREAMER_NET "Found")
else()
    set(FOUND_TEXT_GSTREAMER_NET "Not found")
endif()

message(STATUS "libgstreamer1.0: ${FOUND_TEXT_GSTREAMER}")
message(STATUS "  version      : ${PC_GSTREAMER_VERSION}")
message(STATUS "  cflags       : ${PC_GSTREAMER_CFLAGS}")
message(STATUS "  cflags other : ${PC_GSTREAMER_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_GSTREAMER_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_GSTREAMER_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_GSTREAMER_LIBRARIES}")

message(STATUS "libgstreamer-base1.0: ${PC_GSTREAMER_BASE_FOUND}")
message(STATUS "  version      : ${PC_GSTREAMER_BASE_VERSION}")
message(STATUS "  cflags       : ${PC_GSTREAMER_BASE_CFLAGS}")
message(STATUS "  cflags other : ${PC_GSTREAMER_BASE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_GSTREAMER_BASE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_GSTREAMER_BASE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_GSTREAMER_BASE_LIBRARIES}")

message(STATUS "libgstreamer-check1.0: ${FOUND_TEXT_GSTREAMER_CHECK}")
message(STATUS "  version      : ${PC_GSTREAMER_CHECK_VERSION}")
message(STATUS "  cflags       : ${PC_GSTREAMER_CHECK_CFLAGS}")
message(STATUS "  cflags other : ${PC_GSTREAMER_CHECK_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_GSTREAMER_CHECK_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_GSTREAMER_CHECK_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_GSTREAMER_CHECK_LIBRARIES}")

message(STATUS "libgstreamer-controller1.0: ${FOUND_TEXT_GSTREAMER_CONTROLLER}")
message(STATUS "  version      : ${PC_GSTREAMER_CONTROLLER_VERSION}")
message(STATUS "  cflags       : ${PC_GSTREAMER_CONTROLLER_CFLAGS}")
message(STATUS "  cflags other : ${PC_GSTREAMER_CONTROLLER_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_GSTREAMER_CONTROLLER_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_GSTREAMER_CONTROLLER_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_GSTREAMER_CONTROLLER_LIBRARIES}")

message(STATUS "libgstreamer-net1.0: ${FOUND_TEXT_GSTREAMER_NET}")
message(STATUS "  version      : ${PC_GSTREAMER_NET_VERSION}")
message(STATUS "  cflags       : ${PC_GSTREAMER_NET_CFLAGS}")
message(STATUS "  cflags other : ${PC_GSTREAMER_NET_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_GSTREAMER_NET_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_GSTREAMER_NET_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_GSTREAMER_NET_LIBRARIES}")

find_path(GSTREAMER_INCLUDE_DIRS gstreamer-1.0/gst/gst.h
    HINTS ${PC_GSTREAMER_INCLUDEDIR} ${PC_GSTREAMER_INCLUDE_DIRS})
find_path(GSTREAMER_BASE_INCLUDE_DIRS gstreamer-1.0/gst/base/base.h
    HINTS ${PC_GSTREAMER_BASE_INCLUDEDIR} ${PC_GSTREAMER_BASE_INCLUDE_DIRS})
find_path(GSTREAMER_CHECK_INCLUDE_DIRS gstreamer-1.0/gst/check/check.h
    HINTS ${PC_GSTREAMER_CHECK_INCLUDEDIR} ${PC_GSTREAMER_CHECK_INCLUDE_DIRS})
find_path(GSTREAMER_CONTROLLER_INCLUDE_DIRS gstreamer-1.0/gst/controller/controller.h
    HINTS ${PC_GSTREAMER_CONTROLLER_INCLUDEDIR} ${PC_GSTREAMER_CONTROLLER_INCLUDE_DIRS})
find_path(GSTREAMER_NET_INCLUDE_DIRS gstreamer-1.0/gst/net/gstnet.h
    HINTS ${PC_GSTREAMER_NET_INCLUDEDIR} ${PC_GSTREAMER_NET_INCLUDE_DIRS})

find_library(GSTREAMER_LIBRARY NAMES gstreamer-1.0
        HINTS ${PC_GSTREAMER_LIBDIR} ${PC_GSTREAMER_LIBRARY_DIRS})
find_library(GSTREAMER_BASE_LIBRARY NAMES gstbase-1.0
    HINTS ${PC_GSTREAMER_BASE_LIBDIR} ${PC_GSTREAMER_BASE_LIBRARY_DIRS})
find_library(GSTREAMER_CHECK_LIBRARY NAMES gstcheck-1.0
    HINTS ${PC_GSTREAMER_CHECK_LIBDIR} ${PC_GSTREAMER_CHECK_LIBRARY_DIRS})
find_library(GSTREAMER_CONTROLLER_LIBRARY NAMES gstcontroller-1.0
    HINTS ${PC_GSTREAMER_CONTROLLER_LIBDIR} ${PC_GSTREAMER_CONTROLLER_LIBRARY_DIRS})
find_library(GSTREAMER_NET_LIBRARY NAMES gstnet-1.0
    HINTS ${PC_GSTREAMER_NET_LIBDIR} ${PC_GSTREAMER_NET_LIBRARY_DIRS})

set(GSTREAMER_LIBRARIES ${GSTREAMER_LIBRARY} )
set(GSTREAMER_INCLUDE_DIR ${GSTREAMER_INCLUDE_DIRS} )
set(GSTREAMER_BASE_LIBRARIES ${GSTREAMER_BASE_LIBRARY} )
set(GSTREAMER_BASE_INCLUDE_DIR ${GSTREAMER_BASE_INCLUDE_DIRS} )
set(GSTREAMER_CHECK_LIBRARIES ${GSTREAMER_CHECK_LIBRARY} )
set(GSTREAMER_CHECK_INCLUDE_DIR ${GSTREAMER_CHECK_INCLUDE_DIRS} )
set(GSTREAMER_CONTROLLER_LIBRARIES ${GSTREAMER_CONTROLLER_LIBRARY} )
set(GSTREAMER_CONTROLLER_INCLUDE_DIR ${GSTREAMER_CONTROLLER_INCLUDE_DIRS} )
set(GSTREAMER_NET_LIBRARIES ${GSTREAMER_NET_LIBRARY} )
set(GSTREAMER_NET_INCLUDE_DIR ${GSTREAMER_NET_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set GSTREAMER_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GSTREAMER DEFAULT_MSG
    GSTREAMER_LIBRARY GSTREAMER_INCLUDE_DIR)
find_package_handle_standard_args(GSTREAMER_BASE DEFAULT_MSG
    GSTREAMER_BASE_LIBRARY GSTREAMER_BASE_INCLUDE_DIR)
find_package_handle_standard_args(GSTREAMER_CHECK DEFAULT_MSG
    GSTREAMER_CHECK_LIBRARY GSTREAMER_CHECK_INCLUDE_DIR)
find_package_handle_standard_args(GSTREAMER_CONTROLLER DEFAULT_MSG
    GSTREAMER_CONTROLLER_LIBRARY GSTREAMER_CONTROLLER_INCLUDE_DIR)
find_package_handle_standard_args(GSTREAMER_NET DEFAULT_MSG
    GSTREAMER_NET_LIBRARY GSTREAMER_NET_INCLUDE_DIR)

if (GSTREAMER_REQUIRED_VERSION)
    set(GSTREAMER_BASE_REQUIRED_VERSION ${GSTREAMER_REQUIRED_VERSION})
    set(GSTREAMER_CHECK_REQUIRED_VERSION ${GSTREAMER_REQUIRED_VERSION})
    set(GSTREAMER_CONTROLLER_REQUIRED_VERSION ${GSTREAMER_REQUIRED_VERSION})
    set(GSTREAMER_NET_REQUIRED_VERSION ${GSTREAMER_REQUIRED_VERSION})
endif()

if (GSTREAMER_FOUND)
    if(GSTREAMER_REQUIRED_VERSION)
        if (NOT "${GSTREAMER_REQUIRED_VERSION}" STREQUAL "${PC_GSTREAMER_VERSION}")
            message(WARNING "Incorrect version, please install libgstreamer1.0-${GSTREAMER_REQUIRED_VERSION}")
            unset(GSTREAMER_FOUND)
        endif()
    else()
        message(STATUS "Found libgstreamer1.0")
    endif()
else()
    message(WARNING "Could not find libgstreamer1.0, please install: sudo apt-get install libgstreamer1.0-dev")
endif()

if (GSTREAMER_BASE_FOUND)
    if(GSTREAMER_BASE_REQUIRED_VERSION)
        if (NOT "${GSTREAMER_BASE_REQUIRED_VERSION}" STREQUAL "${PC_GSTREAMER_BASE_VERSION}")
            message(WARNING "Incorrect version, please install libgstreamer1.0-${GSTREAMER_BASE_REQUIRED_VERSION}")
            unset(GSTREAMER_BASE_FOUND)
        endif()
    else()
        message(STATUS "Found libgstbase-1.0")
    endif()
else()
    message(WARNING "Could not find libgstbase-1.0, please install: sudo apt-get install libgstreamer1.0-dev")
endif()

if (GSTREAMER_CHECK_FOUND)
    if(GSTREAMER_CHECK_REQUIRED_VERSION)
        if (NOT "${GSTREAMER_CHECK_REQUIRED_VERSION}" STREQUAL "${PC_GSTREAMER_CHECK_VERSION}")
            message(WARNING "Incorrect version, please install libgstreamer1.0-${GSTREAMER_CHECK_REQUIRED_VERSION}")
            unset(GSTREAMER_CHECK_FOUND)
        endif()
    else()
        message(STATUS "Found libgstcheck-1.0")
    endif()
else()
    message(WARNING "Could not find libgstcheck-1.0, please install: sudo apt-get install libgstreamer1.0-dev")
endif()

if (GSTREAMER_CONTROLLER_FOUND)
    if(GSTREAMER_CONTROLLER_REQUIRED_VERSION)
        if (NOT "${GSTREAMER_CONTROLLER_REQUIRED_VERSION}" STREQUAL "${PC_GSTREAMER_CONTROLLER_VERSION}")
            message(WARNING "Incorrect version, please install libgstreamer1.0-${GSTREAMER_CONTROLLER_REQUIRED_VERSION}")
            unset(GSTREAMER_CONTROLLER_FOUND)
        endif()
    else()
        message(STATUS "Found libgstcontroller-1.0")
    endif()
else()
    message(WARNING "Could not find libgstcontroller-1.0, please install: sudo apt-get install libgstreamer1.0-dev")
endif()

if (GSTREAMER_NET_FOUND)
    if(GSTREAMER_NET_REQUIRED_VERSION)
        if (NOT "${GSTREAMER_NET_REQUIRED_VERSION}" STREQUAL "${PC_GSTREAMER_NET_VERSION}")
            message(WARNING "Incorrect version, please install libgstreamer1.0-${GSTREAMER_NET_REQUIRED_VERSION}")
            unset(GSTREAMER_NET_FOUND)
        endif()
    else()
        message(STATUS "Found libgstnet-1.0")
    endif()
else()
    message(WARNING "Could not find libgstnet-1.0, please install: sudo apt-get install libgstreamer1.0-dev")
endif()

mark_as_advanced(
    GSTREAMER_INCLUDE_DIR GSTREAMER_LIBRARY
    GSTREAMER_BASE_INCLUDE_DIR GSTREAMER_BASE_LIBRARY
    GSTREAMER_CHECK_INCLUDE_DIR GSTREAMER_CHECK_LIBRARY
    GSTREAMER_CONTROLLER_INCLUDE_DIR GSTREAMER_CONTROLLER_LIBRARY
    GSTREAMER_NET_INCLUDE_DIR GSTREAMER_NET_LIBRARY)
