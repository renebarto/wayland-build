# - Try to find X11ProtoVideo
# Once done this will define
#  X11PROTO_VIDEO_FOUND - System has X11ProtoVideo
#  X11PROTO_VIDEO_INCLUDE_DIR - The X11ProtoVideo include directories
#  X11PROTO_VIDEO_LIBRARIES - The libraries needed to use X11ProtoVideo
#  X11PROTO_VIDEO_DEFINITIONS - Compiler switches required for using X11ProtoVideo

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_VIDEO QUIET videoproto)
set(X11PROTO_VIDEO_DEFINITIONS ${PC_X11PROTO_VIDEO_CFLAGS_OTHER})

if(PC_X11PROTO_VIDEO_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-video  : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_VIDEO_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_VIDEO_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_VIDEO_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_VIDEO_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_VIDEO_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_VIDEO_LIBRARIES}")

find_path(X11PROTO_VIDEO_INCLUDE_DIRS X11/extensions/Xvproto.h
        HINTS ${PC_X11PROTO_VIDEO_INCLUDEDIR} ${PC_X11PROTO_VIDEO_INCLUDE_DIRS})

set(X11PROTO_VIDEO_INCLUDE_DIR ${X11PROTO_VIDEO_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_VIDEO_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_VIDEO DEFAULT_MSG
        X11PROTO_VIDEO_INCLUDE_DIR)

if (X11PROTO_VIDEO_FOUND)
    message(STATUS "Found x11proto-video")
else()
    message(WARNING "Could not find x11proto-video, please install: sudo apt-get install x11proto-video")
endif()

mark_as_advanced(X11PROTO_VIDEO_INCLUDE_DIR)
