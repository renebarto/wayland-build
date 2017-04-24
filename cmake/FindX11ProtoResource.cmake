# - Try to find X11ProtoResource
# Once done this will define
#  X11PROTO_RESOURCE_FOUND - System has X11ProtoResource
#  X11PROTO_RESOURCE_INCLUDE_DIR - The X11ProtoResource include directories
#  X11PROTO_RESOURCE_LIBRARIES - The libraries needed to use X11ProtoResource
#  X11PROTO_RESOURCE_DEFINITIONS - Compiler switches required for using X11ProtoResource

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_RESOURCE QUIET resourceproto)
set(X11PROTO_RESOURCE_DEFINITIONS ${PC_X11PROTO_RESOURCE_CFLAGS_OTHER})

if(PC_X11PROTO_RESOURCE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-resource  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_RESOURCE_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_RESOURCE_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_RESOURCE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_RESOURCE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_RESOURCE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_RESOURCE_LIBRARIES}")

find_path(X11PROTO_RESOURCE_INCLUDE_DIRS X11/extensions/XResproto.h
        HINTS ${PC_X11PROTO_RESOURCE_INCLUDEDIR} ${PC_X11PROTO_RESOURCE_INCLUDE_DIRS})

set(X11PROTO_RESOURCE_INCLUDE_DIR ${X11PROTO_RESOURCE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_RESOURCE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_RESOURCE DEFAULT_MSG
        X11PROTO_RESOURCE_INCLUDE_DIR)

if (X11PROTO_RESOURCE_FOUND)
    message(STATUS "Found x11proto-resource")
else()
    message(WARNING "Could not find x11proto-resource, please install: sudo apt-get install x11proto-resource")
endif()

mark_as_advanced(X11PROTO_RESOURCE_INCLUDE_DIR)
