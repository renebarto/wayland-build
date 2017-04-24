# - Try to find X11ProtoDamage
# Once done this will define
#  X11PROTO_DAMAGE_FOUND - System has X11ProtoDamage
#  X11PROTO_DAMAGE_INCLUDE_DIR - The X11ProtoDamage include directories
#  X11PROTO_DAMAGE_LIBRARIES - The libraries needed to use X11ProtoDamage
#  X11PROTO_DAMAGE_DEFINITIONS - Compiler switches required for using X11ProtoDamage

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_DAMAGE QUIET damageproto)
set(X11PROTO_DAMAGE_DEFINITIONS ${PC_X11PROTO_DAMAGE_CFLAGS_OTHER})

if(PC_X11PROTO_DAMAGE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-damage: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_DAMAGE_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_DAMAGE_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_DAMAGE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_DAMAGE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_DAMAGE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_DAMAGE_LIBRARIES}")

find_path(X11PROTO_DAMAGE_INCLUDE_DIRS X11/extensions/damageproto.h
        HINTS ${PC_X11PROTO_DAMAGE_INCLUDEDIR} ${PC_X11PROTO_DAMAGE_INCLUDE_DIRS})

set(X11PROTO_DAMAGE_INCLUDE_DIR ${X11PROTO_DAMAGE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_DAMAGE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_DAMAGE DEFAULT_MSG
        X11PROTO_DAMAGE_INCLUDE_DIR)

if (X11PROTO_DAMAGE_FOUND)
    message(STATUS "Found x11proto-damage")
else()
    message(WARNING "Could not find x11proto-damage, please install: sudo apt-get install x11proto-damage")
endif()

mark_as_advanced(X11PROTO_DAMAGE_INCLUDE_DIR)
