# - Try to find X11ProtoXExt
# Once done this will define
#  X11PROTO_XEXT_FOUND - System has X11ProtoXExt
#  X11PROTO_XEXT_INCLUDE_DIR - The X11ProtoXExt include directories
#  X11PROTO_XEXT_LIBRARIES - The libraries needed to use X11ProtoXExt
#  X11PROTO_XEXT_DEFINITIONS - Compiler switches required for using X11ProtoXExt

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_XEXT QUIET xextproto)
set(X11PROTO_XEXT_DEFINITIONS ${PC_X11PROTO_XEXT_CFLAGS_OTHER})

if(PC_X11PROTO_XEXT_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-xext  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_XEXT_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_XEXT_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_XEXT_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_XEXT_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_XEXT_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_XEXT_LIBRARIES}")

find_path(X11PROTO_XEXT_INCLUDE_DIRS X11/extensions/xtestproto.h
        HINTS ${PC_X11PROTO_XEXT_INCLUDEDIR} ${PC_X11PROTO_XEXT_INCLUDE_DIRS})

set(X11PROTO_XEXT_INCLUDE_DIR ${X11PROTO_XEXT_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_XEXT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_XEXT DEFAULT_MSG
        X11PROTO_XEXT_INCLUDE_DIR)

if (X11PROTO_XEXT_FOUND)
    message(STATUS "Found x11proto-xext")
else()
    message(WARNING "Could not find x11proto-xext, please install: sudo apt-get install x11proto-xext")
endif()

mark_as_advanced(X11PROTO_XEXT_INCLUDE_DIR)
