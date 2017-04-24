# - Try to find X11ProtoBigReqs
# Once done this will define
#  X11PROTO_BIGREQS_FOUND - System has X11ProtoBigReqs
#  X11PROTO_BIGREQS_INCLUDE_DIR - The X11ProtoBigReqs include directories
#  X11PROTO_BIGREQS_LIBRARIES - The libraries needed to use X11ProtoBigReqs
#  X11PROTO_BIGREQS_DEFINITIONS - Compiler switches required for using X11ProtoBigReqs

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_BIGREQS QUIET bigreqsproto)
set(X11PROTO_BIGREQS_DEFINITIONS ${PC_X11PROTO_BIGREQS_CFLAGS_OTHER})

if(PC_X11PROTO_BIGREQS_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-bigreqs: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_BIGREQS_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_BIGREQS_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_BIGREQS_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_BIGREQS_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_BIGREQS_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_BIGREQS_LIBRARIES}")

find_path(X11PROTO_BIGREQS_INCLUDE_DIRS X11/extensions/bigreqsproto.h
        HINTS ${PC_X11PROTO_BIGREQS_INCLUDEDIR} ${PC_X11PROTO_BIGREQS_INCLUDE_DIRS})

set(X11PROTO_BIGREQS_INCLUDE_DIR ${X11PROTO_BIGREQS_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_BIGREQS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_BIGREQS DEFAULT_MSG
        X11PROTO_BIGREQS_INCLUDE_DIR)

if (X11PROTO_BIGREQS_FOUND)
    message(STATUS "Found x11proto-bigreqs")
else()
    message(WARNING "Could not find x11proto-bigreqs, please install: sudo apt-get install x11proto-bigreqs")
endif()

mark_as_advanced(X11PROTO_BIGREQS_INCLUDE_DIR)
