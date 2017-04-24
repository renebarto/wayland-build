# - Try to find X11ProtoXcMisc
# Once done this will define
#  X11PROTO_XCMISC_FOUND - System has X11ProtoXcMisc
#  X11PROTO_XCMISC_INCLUDE_DIR - The X11ProtoXcMisc include directories
#  X11PROTO_XCMISC_LIBRARIES - The libraries needed to use X11ProtoXcMisc
#  X11PROTO_XCMISC_DEFINITIONS - Compiler switches required for using X11ProtoXcMisc

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_XCMISC QUIET xcmiscproto)
set(X11PROTO_XCMISC_DEFINITIONS ${PC_X11PROTO_XCMISC_CFLAGS_OTHER})

if(PC_X11PROTO_XCMISC_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-xcmisc  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_XCMISC_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_XCMISC_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_XCMISC_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_XCMISC_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_XCMISC_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_XCMISC_LIBRARIES}")

find_path(X11PROTO_XCMISC_INCLUDE_DIRS X11/extensions/xcmiscproto.h
        HINTS ${PC_X11PROTO_XCMISC_INCLUDEDIR} ${PC_X11PROTO_XCMISC_INCLUDE_DIRS})

set(X11PROTO_XCMISC_INCLUDE_DIR ${X11PROTO_XCMISC_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_XCMISC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_XCMISC DEFAULT_MSG
        X11PROTO_XCMISC_INCLUDE_DIR)

if (X11PROTO_XCMISC_FOUND)
    message(STATUS "Found x11proto-xcmisc")
else()
    message(WARNING "Could not find x11proto-xcmisc, please install: sudo apt-get install x11proto-xcmisc")
endif()

mark_as_advanced(X11PROTO_XCMISC_INCLUDE_DIR)
