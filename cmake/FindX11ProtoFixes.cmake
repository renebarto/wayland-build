# - Try to find X11ProtoFixes
# Once done this will define
#  X11PROTO_FIXES_FOUND - System has X11ProtoFixes
#  X11PROTO_FIXES_INCLUDE_DIR - The X11ProtoFixes include directories
#  X11PROTO_FIXES_LIBRARIES - The libraries needed to use X11ProtoFixes
#  X11PROTO_FIXES_DEFINITIONS - Compiler switches required for using X11ProtoFixes

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_FIXES QUIET fixesproto)
set(X11PROTO_FIXES_DEFINITIONS ${PC_X11PROTO_FIXES_CFLAGS_OTHER})

if(PC_X11PROTO_FIXES_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-fixes : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_FIXES_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_FIXES_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_FIXES_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_FIXES_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_FIXES_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_FIXES_LIBRARIES}")

find_path(X11PROTO_FIXES_INCLUDE_DIRS X11/extensions/xfixesproto.h
        HINTS ${PC_X11PROTO_FIXES_INCLUDEDIR} ${PC_X11PROTO_FIXES_INCLUDE_DIRS})

set(X11PROTO_FIXES_INCLUDE_DIR ${X11PROTO_FIXES_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_FIXES_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_FIXES DEFAULT_MSG
        X11PROTO_FIXES_INCLUDE_DIR)

if (X11PROTO_FIXES_FOUND)
    message(STATUS "Found x11proto-fixes")
else()
    message(WARNING "Could not find x11proto-fixes, please install: sudo apt-get install x11proto-fixes")
endif()

mark_as_advanced(X11PROTO_FIXES_INCLUDE_DIR)
