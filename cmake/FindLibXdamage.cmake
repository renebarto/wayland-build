# - Try to find LibXdamage
# Once done this will define
#  LIBXDAMAGEFOUND - System has LibXdamage
#  LIBXDAMAGEINCLUDE_DIR - The LibXdamage include directories
#  LIBXDAMAGELIBRARIES - The libraries needed to use LibXdamage
#  LIBXDAMAGEDEFINITIONS - Compiler switches required for using LibXdamage

find_package(PkgConfig)
pkg_check_modules(PC_LIBXDAMAGE QUIET xdamage)
set(LIBXDAMAGEDEFINITIONS ${PC_LIBXDAMAGE_CFLAGS_OTHER})

if(PC_LIBXDAMAGE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libXdamage     : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXDAMAGE_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXDAMAGE_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXDAMAGE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXDAMAGE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXDAMAGE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXDAMAGE_LIBRARIES}")

find_path(LIBXDAMAGEINCLUDE_DIRS X11/extensions/Xdamage.h
        HINTS ${PC_LIBXDAMAGE_INCLUDEDIR} ${PC_LIBXDAMAGE_INCLUDE_DIRS})

find_library(LIBXDAMAGELIBRARY NAMES Xdamage
        HINTS ${PC_LIBXDAMAGE_LIBDIR} ${PC_LIBXDAMAGE_LIBRARY_DIRS})

set(LIBXDAMAGELIBRARIES ${LIBXDAMAGELIBRARY} )
set(LIBXDAMAGEINCLUDE_DIR ${LIBXDAMAGEINCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXDAMAGEFOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LibXdamage DEFAULT_MSG
        LIBXDAMAGELIBRARY LIBXDAMAGEINCLUDE_DIR)

if (LIBXDAMAGE_FOUND)
    if(LIBXDAMAGEREQUIRED_VERSION)
        if (NOT "${LIBXDAMAGEREQUIRED_VERSION}" STREQUAL "${PC_LIBXDAMAGE_VERSION}")
            message(WARNING "Incorrect version, please install libXdamage-${LIBXDAMAGEREQUIRED_VERSION}")
            unset(LIBXDAMAGEFOUND)
        endif()
    else()
        message(STATUS "Found libXdamage")
    endif()
else()
    message(WARNING "Could not find libXdamage, please install: sudo apt-get install libXdamage-dev")
endif()

mark_as_advanced(LIBXDAMAGEINCLUDE_DIR LIBXDAMAGELIBRARY)
