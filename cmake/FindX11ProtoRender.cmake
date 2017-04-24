# - Try to find X11ProtoRender
# Once done this will define
#  X11PROTO_RENDER_FOUND - System has X11ProtoRender
#  X11PROTO_RENDER_INCLUDE_DIR - The X11ProtoRender include directories
#  X11PROTO_RENDER_LIBRARIES - The libraries needed to use X11ProtoRender
#  X11PROTO_RENDER_DEFINITIONS - Compiler switches required for using X11ProtoRender

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_RENDER QUIET renderproto)
set(X11PROTO_RENDER_DEFINITIONS ${PC_X11PROTO_RENDER_CFLAGS_OTHER})

if(PC_X11PROTO_RENDER_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-render  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_RENDER_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_RENDER_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_RENDER_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_RENDER_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_RENDER_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_RENDER_LIBRARIES}")

find_path(X11PROTO_RENDER_INCLUDE_DIRS X11/extensions/renderproto.h
        HINTS ${PC_X11PROTO_RENDER_INCLUDEDIR} ${PC_X11PROTO_RENDER_INCLUDE_DIRS})

set(X11PROTO_RENDER_INCLUDE_DIR ${X11PROTO_RENDER_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_RENDER_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_RENDER DEFAULT_MSG
        X11PROTO_RENDER_INCLUDE_DIR)

if (X11PROTO_RENDER_FOUND)
    message(STATUS "Found x11proto-render")
else()
    message(WARNING "Could not find x11proto-render, please install: sudo apt-get install x11proto-render")
endif()

mark_as_advanced(X11PROTO_RENDER_INCLUDE_DIR)
