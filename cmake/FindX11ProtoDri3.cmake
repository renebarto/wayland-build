# - Try to find X11ProtoDri3
# Once done this will define
#  X11PROTO_DRI3_FOUND - System has X11ProtoDri3
#  X11PROTO_DRI3_INCLUDE_DIR - The X11ProtoDri3 include directories
#  X11PROTO_DRI3_LIBRARIES - The libraries needed to use X11ProtoDri3
#  X11PROTO_DRI3_DEFINITIONS - Compiler switches required for using X11ProtoDri3

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_DRI3 QUIET dri3proto)
set(X11PROTO_DRI3_DEFINITIONS ${PC_X11PROTO_DRI3_CFLAGS_OTHER})

if(PC_X11PROTO_DRI3_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-dri3  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_DRI3_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_DRI3_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_DRI3_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_DRI3_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_DRI3_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_DRI3_LIBRARIES}")

find_path(X11PROTO_DRI3_INCLUDE_DIRS X11/extensions/dri3proto.h
        HINTS ${PC_X11PROTO_DRI3_INCLUDEDIR} ${PC_X11PROTO_DRI3_INCLUDE_DIRS})

set(X11PROTO_DRI3_INCLUDE_DIR ${X11PROTO_DRI3_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_DRI3_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_DRI3 DEFAULT_MSG
        X11PROTO_DRI3_INCLUDE_DIR)

if (X11PROTO_DRI3_FOUND)
    message(STATUS "Found x11proto-dri3")
else()
    message(WARNING "Could not find x11proto-dri3, please install: sudo apt-get install x11proto-dri3")
endif()

mark_as_advanced(X11PROTO_DRI3_INCLUDE_DIR)
