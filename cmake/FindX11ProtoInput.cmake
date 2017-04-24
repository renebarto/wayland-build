# - Try to find X11ProtoInput
# Once done this will define
#  X11PROTO_INPUT_FOUND - System has X11ProtoInput
#  X11PROTO_INPUT_INCLUDE_DIR - The X11ProtoInput include directories
#  X11PROTO_INPUT_LIBRARIES - The libraries needed to use X11ProtoInput
#  X11PROTO_INPUT_DEFINITIONS - Compiler switches required for using X11ProtoInput

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_INPUT QUIET inputproto)
set(X11PROTO_INPUT_DEFINITIONS ${PC_X11PROTO_INPUT_CFLAGS_OTHER})

if(PC_X11PROTO_INPUT_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-input : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_INPUT_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_INPUT_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_INPUT_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_INPUT_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_INPUT_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_INPUT_LIBRARIES}")

find_path(X11PROTO_INPUT_INCLUDE_DIRS X11/extensions/XIproto.h X11/extensions/XI2proto.h
        HINTS ${PC_X11PROTO_INPUT_INCLUDEDIR} ${PC_X11PROTO_INPUT_INCLUDE_DIRS})

set(X11PROTO_INPUT_INCLUDE_DIR ${X11PROTO_INPUT_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_INPUT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_INPUT DEFAULT_MSG
        X11PROTO_INPUT_INCLUDE_DIR)

if (X11PROTO_INPUT_FOUND)
    message(STATUS "Found x11proto-input")
else()
    message(WARNING "Could not find x11proto-input, please install: sudo apt-get install x11proto-input")
endif()

mark_as_advanced(X11PROTO_INPUT_INCLUDE_DIR)
