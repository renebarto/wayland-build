# - Try to find Mtdev
# Once done this will define
#  MTDEV_FOUND - System has Mtdev
#  MTDEV_INCLUDE_DIR - The Mtdev include directories
#  MTDEV_LIBRARIES - The libraries needed to use Mtdev
#  MTDEV_DEFINITIONS - Compiler switches required for using Mtdev

find_package(PkgConfig)
pkg_check_modules(PC_MTDEV QUIET mtdev)
set(MTDEV_DEFINITIONS ${PC_MTDEV_CFLAGS_OTHER})

if(PC_MTDEV_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "mtdev          : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_MTDEV_VERSION}")
message(STATUS "  cflags       : ${PC_MTDEV_CFLAGS}")
message(STATUS "  cflags other : ${PC_MTDEV_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MTDEV_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MTDEV_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MTDEV_LIBRARIES}")

find_path(MTDEV_INCLUDE_DIRS mtdev.h mtdev-mapping.h mtdev-plumbing.h
        HINTS ${PC_MTDEV_INCLUDEDIR} ${PC_MTDEV_INCLUDE_DIRS})

find_library(MTDEV_LIBRARY NAMES mtdev
        HINTS ${PC_MTDEV_LIBDIR} ${PC_MTDEV_LIBRARY_DIRS} )

message(STATUS "  include dirs : ${MTDEV_INCLUDE_DIRS}")
message(STATUS "  lib          : ${MTDEV_LIBRARY}")

set(MTDEV_LIBRARIES ${MTDEV_LIBRARY} )
set(MTDEV_INCLUDE_DIR ${MTDEV_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set MTDEV_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Mtdev DEFAULT_MSG
        MTDEV_LIBRARY MTDEV_INCLUDE_DIR)

if (MTDEV_FOUND)
    if(MTDEV_REQUIRED_VERSION)
        if (NOT "${MTDEV_REQUIRED_VERSION}" STREQUAL "${PC_MTDEV_VERSION}")
            message(WARNING "Incorrect version, please install mtdev-${MTDEV_REQUIRED_VERSION}")
            unset(MTDEV_FOUND)
        endif()
    else()
        message(STATUS "Found mtdev")
    endif()
else()
    message(WARNING "Could not find mtdev, please install: sudo apt-get install mtdev-dev")
endif()

mark_as_advanced(MTDEV_INCLUDE_DIR MTDEV_LIBRARY)
