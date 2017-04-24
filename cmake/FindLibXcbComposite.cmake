# - Try to find LibXcbComposite
# Once done this will define
#  LIBXCB_COMPOSITE_FOUND - System has LibXcbComposite
#  LIBXCB_COMPOSITE_INCLUDE_DIR - The LibXcbComposite include directories
#  LIBXCB_COMPOSITE_LIBRARIES - The libraries needed to use LibXcbComposite
#  LIBXCB_COMPOSITE_DEFINITIONS - Compiler switches required for using LibXcbComposite

find_package(PkgConfig)
pkg_check_modules(PC_LIBXCB_COMPOSITE QUIET libxcb-composite)
set(LIBXCB_COMPOSITE_DEFINITIONS ${PC_LIBXCB_COMPOSITE_CFLAGS_OTHER})

if(PC_LIBXCB_COMPOSITE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxcb-composite: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXCB_COMPOSITE_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXCB_COMPOSITE_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXCB_COMPOSITE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXCB_COMPOSITE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXCB_COMPOSITE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXCB_COMPOSITE_LIBRARIES}")

find_path(LIBXCB_COMPOSITE_INCLUDE_DIRS xcb/composite.h
        HINTS ${PC_LIBXCB_COMPOSITE_INCLUDEDIR} ${PC_LIBXCB_COMPOSITE_INCLUDE_DIRS})

find_library(LIBXCB_COMPOSITE_LIBRARY NAMES libxcb-composite
        HINTS ${PC_LIBXCB_COMPOSITE_LIBDIR} ${PC_LIBXCB_COMPOSITE_LIBRARY_DIRS})

set(LIBXCB_COMPOSITE_LIBRARIES ${LIBXCB_COMPOSITE_LIBRARY} )
set(LIBXCB_COMPOSITE_INCLUDE_DIR ${LIBXCB_COMPOSITE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXCB_COMPOSITE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXCB_COMPOSITE DEFAULT_MSG
        LIBXCB_COMPOSITE_LIBRARY LIBXCB_COMPOSITE_INCLUDE_DIR)

if (LIBXCB_COMPOSITE_FOUND)
    if(LIBXCB_COMPOSITE_REQUIRED_VERSION)
        if (NOT "${LIBXCB_COMPOSITE_REQUIRED_VERSION}" STREQUAL "${PC_LIBXCB_COMPOSITE_VERSION}")
            message(WARNING "Incorrect version, please install libffi-${LIBXCB_COMPOSITE_REQUIRED_VERSION}")
            unset(LIBXCB_COMPOSITE_FOUND)
        endif()
    else()
        message(STATUS "Found libxcb-composite")
    endif()
else()
    message(WARNING "Could not find libxcb-composite, please install: sudo apt-get install libxcb-composite0-dev")
endif()

mark_as_advanced(LIBXCB_COMPOSITE_INCLUDE_DIR LIBXCB_COMPOSITE_LIBRARY)
