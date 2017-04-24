# - Try to find X11ProtoDmx
# Once done this will define
#  X11PROTO_DMX_FOUND - System has X11ProtoDmx
#  X11PROTO_DMX_INCLUDE_DIR - The X11ProtoDmx include directories
#  X11PROTO_DMX_LIBRARIES - The libraries needed to use X11ProtoDmx
#  X11PROTO_DMX_DEFINITIONS - Compiler switches required for using X11ProtoDmx

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_DMX QUIET dmxproto)
set(X11PROTO_DMX_DEFINITIONS ${PC_X11PROTO_DMX_CFLAGS_OTHER})

if(PC_X11PROTO_DMX_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-dmx   : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_DMX_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_DMX_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_DMX_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_DMX_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_DMX_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_DMX_LIBRARIES}")

find_path(X11PROTO_DMX_INCLUDE_DIRS X11/extensions/dmxproto.h
        HINTS ${PC_X11PROTO_DMX_INCLUDEDIR} ${PC_X11PROTO_DMX_INCLUDE_DIRS})

set(X11PROTO_DMX_INCLUDE_DIR ${X11PROTO_DMX_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_DMX_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_DMX DEFAULT_MSG
        X11PROTO_DMX_INCLUDE_DIR)

if (X11PROTO_DMX_FOUND)
    message(STATUS "Found x11proto-dmx")
else()
    message(WARNING "Could not find x11proto-dmx, please install: sudo apt-get install x11proto-dmx")
endif()

mark_as_advanced(X11PROTO_DMX_INCLUDE_DIR)
