# - Try to find X11ProtoXF86VidMode
# Once done this will define
#  X11PROTO_XF86VIDMODE_FOUND - System has X11ProtoXF86VidMode
#  X11PROTO_XF86VIDMODE_INCLUDE_DIR - The X11ProtoXF86VidMode include directories
#  X11PROTO_XF86VIDMODE_LIBRARIES - The libraries needed to use X11ProtoXF86VidMode
#  X11PROTO_XF86VIDMODE_DEFINITIONS - Compiler switches required for using X11ProtoXF86VidMode

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_XF86VIDMODE QUIET xf86vidmodeproto)
set(X11PROTO_XF86VIDMODE_DEFINITIONS ${PC_X11PROTO_XF86VIDMODE_CFLAGS_OTHER})

if(PC_X11PROTO_XF86VIDMODE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-xf86vidmode  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_XF86VIDMODE_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_XF86VIDMODE_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_XF86VIDMODE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_XF86VIDMODE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_XF86VIDMODE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_XF86VIDMODE_LIBRARIES}")

find_path(X11PROTO_XF86VIDMODE_INCLUDE_DIRS X11/extensions/xf86vmproto.h
        HINTS ${PC_X11PROTO_XF86VIDMODE_INCLUDEDIR} ${PC_X11PROTO_XF86VIDMODE_INCLUDE_DIRS})

set(X11PROTO_XF86VIDMODE_INCLUDE_DIR ${X11PROTO_XF86VIDMODE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_XF86VIDMODE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_XF86VIDMODE DEFAULT_MSG
        X11PROTO_XF86VIDMODE_INCLUDE_DIR)

if (X11PROTO_XF86VIDMODE_FOUND)
    message(STATUS "Found x11proto-xf86vidmode")
else()
    message(WARNING "Could not find x11proto-xf86vidmode, please install: sudo apt-get install x11proto-xf86vidmode")
endif()

mark_as_advanced(X11PROTO_XF86VIDMODE_INCLUDE_DIR)
