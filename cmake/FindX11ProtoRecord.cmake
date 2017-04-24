# - Try to find X11ProtoRecord
# Once done this will define
#  X11PROTO_RECORD_FOUND - System has X11ProtoRecord
#  X11PROTO_RECORD_INCLUDE_DIR - The X11ProtoRecord include directories
#  X11PROTO_RECORD_LIBRARIES - The libraries needed to use X11ProtoRecord
#  X11PROTO_RECORD_DEFINITIONS - Compiler switches required for using X11ProtoRecord

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_RECORD QUIET recordproto)
set(X11PROTO_RECORD_DEFINITIONS ${PC_X11PROTO_RECORD_CFLAGS_OTHER})

if(PC_X11PROTO_RECORD_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-record  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_RECORD_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_RECORD_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_RECORD_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_RECORD_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_RECORD_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_RECORD_LIBRARIES}")

find_path(X11PROTO_RECORD_INCLUDE_DIRS X11/extensions/recordproto.h
        HINTS ${PC_X11PROTO_RECORD_INCLUDEDIR} ${PC_X11PROTO_RECORD_INCLUDE_DIRS})

set(X11PROTO_RECORD_INCLUDE_DIR ${X11PROTO_RECORD_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_RECORD_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_RECORD DEFAULT_MSG
        X11PROTO_RECORD_INCLUDE_DIR)

if (X11PROTO_RECORD_FOUND)
    message(STATUS "Found x11proto-record")
else()
    message(WARNING "Could not find x11proto-record, please install: sudo apt-get install x11proto-record")
endif()

mark_as_advanced(X11PROTO_RECORD_INCLUDE_DIR)
