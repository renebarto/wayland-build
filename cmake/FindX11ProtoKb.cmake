# - Try to find X11ProtoKB
# Once done this will define
#  X11PROTO_KB_FOUND - System has X11ProtoKB
#  X11PROTO_KB_INCLUDE_DIR - The X11ProtoKB include directories
#  X11PROTO_KB_LIBRARIES - The libraries needed to use X11ProtoKB
#  X11PROTO_KB_DEFINITIONS - Compiler switches required for using X11ProtoKB

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_KB QUIET kbproto)
set(X11PROTO_KB_DEFINITIONS ${PC_X11PROTO_KB_CFLAGS_OTHER})

if(PC_X11PROTO_KB_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-kb  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_KB_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_KB_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_KB_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_KB_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_KB_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_KB_LIBRARIES}")

find_path(X11PROTO_KB_INCLUDE_DIRS X11/extensions/XKB.h
        HINTS ${PC_X11PROTO_KB_INCLUDEDIR} ${PC_X11PROTO_KB_INCLUDE_DIRS})

set(X11PROTO_KB_INCLUDE_DIR ${X11PROTO_KB_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_KB_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_KB DEFAULT_MSG
        X11PROTO_KB_INCLUDE_DIR)

if (X11PROTO_KB_FOUND)
    message(STATUS "Found x11proto-kb")
else()
    message(WARNING "Could not find x11proto-kb, please install: sudo apt-get install x11proto-kb")
endif()

mark_as_advanced(X11PROTO_KB_INCLUDE_DIR)
