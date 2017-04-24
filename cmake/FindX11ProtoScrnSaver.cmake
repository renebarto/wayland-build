# - Try to find X11ProtoSrcnSaver
# Once done this will define
#  X11PROTO_SCRNSAVER_FOUND - System has X11ProtoSrcnSaver
#  X11PROTO_SCRNSAVER_INCLUDE_DIR - The X11ProtoSrcnSaver include directories
#  X11PROTO_SCRNSAVER_LIBRARIES - The libraries needed to use X11ProtoSrcnSaver
#  X11PROTO_SCRNSAVER_DEFINITIONS - Compiler switches required for using X11ProtoSrcnSaver

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_SCRNSAVER QUIET scrnsaverproto)
set(X11PROTO_SCRNSAVER_DEFINITIONS ${PC_X11PROTO_SCRNSAVER_CFLAGS_OTHER})

if(PC_X11PROTO_SCRNSAVER_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-scrnsaver  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_SCRNSAVER_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_SCRNSAVER_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_SCRNSAVER_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_SCRNSAVER_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_SCRNSAVER_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_SCRNSAVER_LIBRARIES}")

find_path(X11PROTO_SCRNSAVER_INCLUDE_DIRS X11/extensions/saverproto.h
        HINTS ${PC_X11PROTO_SCRNSAVER_INCLUDEDIR} ${PC_X11PROTO_SCRNSAVER_INCLUDE_DIRS})

set(X11PROTO_SCRNSAVER_INCLUDE_DIR ${X11PROTO_SCRNSAVER_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_SCRNSAVER_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_SCRNSAVER DEFAULT_MSG
        X11PROTO_SCRNSAVER_INCLUDE_DIR)

if (X11PROTO_SCRNSAVER_FOUND)
    message(STATUS "Found x11proto-scrnsaver")
else()
    message(WARNING "Could not find x11proto-scrnsaver, please install: sudo apt-get install x11proto-scrnsaver")
endif()

mark_as_advanced(X11PROTO_SCRNSAVER_INCLUDE_DIR)
