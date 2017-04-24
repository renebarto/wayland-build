# - Try to find X11ProtoXinerama
# Once done this will define
#  X11PROTO_XINERAMA_FOUND - System has X11ProtoXinerama
#  X11PROTO_XINERAMA_INCLUDE_DIR - The X11ProtoXinerama include directories
#  X11PROTO_XINERAMA_LIBRARIES - The libraries needed to use X11ProtoXinerama
#  X11PROTO_XINERAMA_DEFINITIONS - Compiler switches required for using X11ProtoXinerama

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_XINERAMA QUIET xineramaproto)
set(X11PROTO_XINERAMA_DEFINITIONS ${PC_X11PROTO_XINERAMA_CFLAGS_OTHER})

if(PC_X11PROTO_XINERAMA_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-xinerama  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_XINERAMA_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_XINERAMA_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_XINERAMA_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_XINERAMA_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_XINERAMA_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_XINERAMA_LIBRARIES}")

find_path(X11PROTO_XINERAMA_INCLUDE_DIRS X11/extensions/panoramiXproto.h
        HINTS ${PC_X11PROTO_XINERAMA_INCLUDEDIR} ${PC_X11PROTO_XINERAMA_INCLUDE_DIRS})

set(X11PROTO_XINERAMA_INCLUDE_DIR ${X11PROTO_XINERAMA_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_XINERAMA_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_XINERAMA DEFAULT_MSG
        X11PROTO_XINERAMA_INCLUDE_DIR)

if (X11PROTO_XINERAMA_FOUND)
    message(STATUS "Found x11proto-xinerama")
else()
    message(WARNING "Could not find x11proto-xinerama, please install: sudo apt-get install x11proto-xinerama")
endif()

mark_as_advanced(X11PROTO_XINERAMA_INCLUDE_DIR)
