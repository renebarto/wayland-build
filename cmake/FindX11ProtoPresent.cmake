# - Try to find X11ProtoPresent
# Once done this will define
#  X11PROTO_PRESENT_FOUND - System has X11ProtoPresent
#  X11PROTO_PRESENT_INCLUDE_DIR - The X11ProtoPresent include directories
#  X11PROTO_PRESENT_LIBRARIES - The libraries needed to use X11ProtoPresent
#  X11PROTO_PRESENT_DEFINITIONS - Compiler switches required for using X11ProtoPresent

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_PRESENT QUIET presentproto)
set(X11PROTO_PRESENT_DEFINITIONS ${PC_X11PROTO_PRESENT_CFLAGS_OTHER})

if(PC_X11PROTO_PRESENT_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-present: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_PRESENT_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_PRESENT_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_PRESENT_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_PRESENT_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_PRESENT_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_PRESENT_LIBRARIES}")

find_path(X11PROTO_PRESENT_INCLUDE_DIRS X11/extensions/presentproto.h X11/extensions/presenttokens.h
        HINTS ${PC_X11PROTO_PRESENT_INCLUDEDIR} ${PC_X11PROTO_PRESENT_INCLUDE_DIRS})

set(X11PROTO_PRESENT_INCLUDE_DIR ${X11PROTO_PRESENT_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_PRESENT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_PRESENT DEFAULT_MSG
        X11PROTO_PRESENT_INCLUDE_DIR)

if (X11PROTO_PRESENT_FOUND)
    message(STATUS "Found x11proto-present")
else()
    message(WARNING "Could not find x11proto-present, please install: sudo apt-get install x11proto-present")
endif()

mark_as_advanced(X11PROTO_PRESENT_INCLUDE_DIR)
