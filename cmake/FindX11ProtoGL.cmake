# - Try to find X11ProtoGL
# Once done this will define
#  X11PROTO_GL_FOUND - System has X11ProtoGL
#  X11PROTO_GL_INCLUDE_DIR - The X11ProtoGL include directories
#  X11PROTO_GL_LIBRARIES - The libraries needed to use X11ProtoGL
#  X11PROTO_GL_DEFINITIONS - Compiler switches required for using X11ProtoGL

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_GL QUIET glproto)
set(X11PROTO_GL_DEFINITIONS ${PC_X11PROTO_GL_CFLAGS_OTHER})

if(PC_X11PROTO_GL_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-gl    : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_GL_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_GL_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_GL_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_GL_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_GL_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_GL_LIBRARIES}")

find_path(X11PROTO_GL_INCLUDE_DIRS X11/extensions/glcore.h X11/extensions/glxproto.h
        HINTS ${PC_X11PROTO_GL_INCLUDEDIR} ${PC_X11PROTO_GL_INCLUDE_DIRS})

set(X11PROTO_GL_INCLUDE_DIR ${X11PROTO_GL_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_GL_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_GL DEFAULT_MSG
        X11PROTO_GL_INCLUDE_DIR)

if (X11PROTO_GL_FOUND)
    message(STATUS "Found x11proto-gl")
else()
    message(WARNING "Could not find x11proto-gl, please install: sudo apt-get install x11proto-gl")
endif()

mark_as_advanced(X11PROTO_GL_INCLUDE_DIR)
