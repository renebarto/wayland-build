# - Try to find X11ProtoRandr
# Once done this will define
#  X11PROTO_RANDR_FOUND - System has X11ProtoRandr
#  X11PROTO_RANDR_INCLUDE_DIR - The X11ProtoRandr include directories
#  X11PROTO_RANDR_LIBRARIES - The libraries needed to use X11ProtoRandr
#  X11PROTO_RANDR_DEFINITIONS - Compiler switches required for using X11ProtoRandr

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_RANDR QUIET randrproto)
set(X11PROTO_RANDR_DEFINITIONS ${PC_X11PROTO_RANDR_CFLAGS_OTHER})

if(PC_X11PROTO_RANDR_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-randr  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_RANDR_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_RANDR_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_RANDR_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_RANDR_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_RANDR_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_RANDR_LIBRARIES}")

find_path(X11PROTO_RANDR_INCLUDE_DIRS X11/extensions/randrproto.h
        HINTS ${PC_X11PROTO_RANDR_INCLUDEDIR} ${PC_X11PROTO_RANDR_INCLUDE_DIRS})

set(X11PROTO_RANDR_INCLUDE_DIR ${X11PROTO_RANDR_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_RANDR_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_RANDR DEFAULT_MSG
        X11PROTO_RANDR_INCLUDE_DIR)

if (X11PROTO_RANDR_FOUND)
    message(STATUS "Found x11proto-randr")
else()
    message(WARNING "Could not find x11proto-randr, please install: sudo apt-get install x11proto-randr")
endif()

mark_as_advanced(X11PROTO_RANDR_INCLUDE_DIR)
