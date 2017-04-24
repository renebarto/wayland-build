# - Try to find X11ProtoX
# Once done this will define
#  X11PROTO_X_FOUND - System has X11ProtoX
#  X11PROTO_X_INCLUDE_DIR - The X11ProtoX include directories
#  X11PROTO_X_LIBRARIES - The libraries needed to use X11ProtoX
#  X11PROTO_X_DEFINITIONS - Compiler switches required for using X11ProtoX

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_X QUIET xproto)
set(X11PROTO_X_DEFINITIONS ${PC_X11PROTO_X_CFLAGS_OTHER})

if(PC_X11PROTO_X_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-x  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_X_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_X_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_X_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_X_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_X_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_X_LIBRARIES}")

find_path(X11PROTO_X_INCLUDE_DIRS X11/extensions/Xproto.h
        HINTS ${PC_X11PROTO_X_INCLUDEDIR} ${PC_X11PROTO_X_INCLUDE_DIRS})

set(X11PROTO_X_INCLUDE_DIR ${X11PROTO_X_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_X_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_X DEFAULT_MSG
        X11PROTO_X_INCLUDE_DIR)

if (X11PROTO_X_FOUND)
    message(STATUS "Found x11proto-x")
else()
    message(WARNING "Could not find x11proto-x, please install: sudo apt-get install x11proto-x")
endif()

mark_as_advanced(X11PROTO_X_INCLUDE_DIR)
