# - Try to find X11ProtoDri2
# Once done this will define
#  X11PROTO_DRI2_FOUND - System has X11ProtoDri2
#  X11PROTO_DRI2_INCLUDE_DIR - The X11ProtoDri2 include directories
#  X11PROTO_DRI2_LIBRARIES - The libraries needed to use X11ProtoDri2
#  X11PROTO_DRI2_DEFINITIONS - Compiler switches required for using X11ProtoDri2

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_DRI2 QUIET dri2proto)
set(X11PROTO_DRI2_DEFINITIONS ${PC_X11PROTO_DRI2_CFLAGS_OTHER})

if(PC_X11PROTO_DRI2_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-dri2  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_DRI2_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_DRI2_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_DRI2_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_DRI2_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_DRI2_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_DRI2_LIBRARIES}")

find_path(X11PROTO_DRI2_INCLUDE_DIRS X11/extensions/dri2proto.h
        HINTS ${PC_X11PROTO_DRI2_INCLUDEDIR} ${PC_X11PROTO_DRI2_INCLUDE_DIRS})

set(X11PROTO_DRI2_INCLUDE_DIR ${X11PROTO_DRI2_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_DRI2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_DRI2 DEFAULT_MSG
        X11PROTO_DRI2_INCLUDE_DIR)

if (X11PROTO_DRI2_FOUND)
    message(STATUS "Found x11proto-dri2")
else()
    message(WARNING "Could not find x11proto-dri2, please install: sudo apt-get install x11proto-dri2")
endif()

mark_as_advanced(X11PROTO_DRI2_INCLUDE_DIR)
