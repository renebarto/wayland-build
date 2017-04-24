# - Try to find X11ProtoFonts
# Once done this will define
#  X11PROTO_FONTS_FOUND - System has X11ProtoFonts
#  X11PROTO_FONTS_INCLUDE_DIR - The X11ProtoFonts include directories
#  X11PROTO_FONTS_LIBRARIES - The libraries needed to use X11ProtoFonts
#  X11PROTO_FONTS_DEFINITIONS - Compiler switches required for using X11ProtoFonts

find_package(PkgConfig)
pkg_check_modules(PC_X11PROTO_FONTS QUIET fontsproto)
set(X11PROTO_FONTS_DEFINITIONS ${PC_X11PROTO_FONTS_CFLAGS_OTHER})

if(PC_X11PROTO_FONTS_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "x11proto-fonts : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_X11PROTO_FONTS_VERSION}")
message(STATUS "  cflags       : ${PC_X11PROTO_FONTS_CFLAGS}")
message(STATUS "  cflags other : ${PC_X11PROTO_FONTS_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_X11PROTO_FONTS_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_X11PROTO_FONTS_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_X11PROTO_FONTS_LIBRARIES}")

find_path(X11PROTO_FONTS_INCLUDE_DIRS X11/extensions/fontsproto.h
        HINTS ${PC_X11PROTO_FONTS_INCLUDEDIR} ${PC_X11PROTO_FONTS_INCLUDE_DIRS})

set(X11PROTO_FONTS_INCLUDE_DIR ${X11PROTO_FONTS_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set X11PROTO_FONTS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(X11PROTO_FONTS DEFAULT_MSG
        X11PROTO_FONTS_INCLUDE_DIR)

if (X11PROTO_FONTS_FOUND)
    message(STATUS "Found x11proto-fonts")
else()
    message(WARNING "Could not find x11proto-fonts, please install: sudo apt-get install x11proto-fonts")
endif()

mark_as_advanced(X11PROTO_FONTS_INCLUDE_DIR)
