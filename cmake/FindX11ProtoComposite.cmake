# - Try to find X11ProtoComposite
# Once done this will define
#  X11PROTO_COMPOSITE_FOUND - System has X11ProtoComposite
#  X11PROTO_COMPOSITE_INCLUDE_DIR - The X11ProtoComposite include directories
#  X11PROTO_COMPOSITE_LIBRARIES - The libraries needed to use X11ProtoComposite
#  X11PROTO_COMPOSITE_DEFINITIONS - Compiler switches required for using X11ProtoComposite

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_COMPOSITE QUIET compositeproto)
set(X11PROTO_COMPOSITE_DEFINITIONS ${PC_X11PROTO_COMPOSITE_CFLAGS_OTHER})

if(PC_X11PROTO_COMPOSITE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-composite: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_COMPOSITE_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_COMPOSITE_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_COMPOSITE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_COMPOSITE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_COMPOSITE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_COMPOSITE_LIBRARIES}")

find_path(X11PROTO_COMPOSITE_INCLUDE_DIRS X11/extensions/compositeproto.h
        HINTS ${PC_X11PROTO_COMPOSITE_INCLUDEDIR} ${PC_X11PROTO_COMPOSITE_INCLUDE_DIRS})

set(X11PROTO_COMPOSITE_INCLUDE_DIR ${X11PROTO_COMPOSITE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_COMPOSITE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_COMPOSITE DEFAULT_MSG
        X11PROTO_COMPOSITE_INCLUDE_DIR)

if (X11PROTO_COMPOSITE_FOUND)
    message(STATUS "Found x11proto-composite")
else()
    message(WARNING "Could not find x11proto-composite, please install: sudo apt-get install x11proto-composite")
endif()

mark_as_advanced(X11PROTO_COMPOSITE_INCLUDE_DIR)
