# - Try to find X11ProtoXF86DRI
# Once done this will define
#  X11PROTO_XF86DRI_FOUND - System has X11ProtoXF86DRI
#  X11PROTO_XF86DRI_INCLUDE_DIR - The X11ProtoXF86DRI include directories
#  X11PROTO_XF86DRI_LIBRARIES - The libraries needed to use X11ProtoXF86DRI
#  X11PROTO_XF86DRI_DEFINITIONS - Compiler switches required for using X11ProtoXF86DRI

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_XF86DRI QUIET xf86driproto)
set(X11PROTO_XF86DRI_DEFINITIONS ${PC_X11PROTO_XF86DRI_CFLAGS_OTHER})

if(PC_X11PROTO_XF86DRI_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-xf86dri: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_XF86DRI_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_XF86DRI_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_XF86DRI_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_XF86DRI_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_XF86DRI_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_XF86DRI_LIBRARIES}")

find_path(X11PROTO_XF86DRI_INCLUDE_DIRS X11/dri/xf86driproto.h
        HINTS ${PC_X11PROTO_XF86DRI_INCLUDEDIR} ${PC_X11PROTO_XF86DRI_INCLUDE_DIRS})

set(X11PROTO_XF86DRI_INCLUDE_DIR ${X11PROTO_XF86DRI_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_XF86DRI_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_XF86DRI DEFAULT_MSG
        X11PROTO_XF86DRI_INCLUDE_DIR)

if (X11PROTO_XF86DRI_FOUND)
    message(STATUS "Found x11proto-xf86dri")
else()
    message(WARNING "Could not find x11proto-xf86dri, please install: sudo apt-get install x11proto-xf86dri")
endif()

mark_as_advanced(X11PROTO_XF86DRI_INCLUDE_DIR)
