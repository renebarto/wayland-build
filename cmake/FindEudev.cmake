# - Try to find Eudev
# Once done this will define
#  EUDEV_FOUND - System has Eudev
#  EUDEV_INCLUDE_DIR - The Eudev include directories
#  EUDEV_LIBRARIES - The libraries needed to use Eudev
#  EUDEV_DEFINITIONS - Compiler switches required for using Eudev

find_package(PkgConfig)
pkg_check_modules(PC_EUDEV QUIET libudev)
set(EUDEV_DEFINITIONS ${PC_EUDEV_CFLAGS_OTHER})

if(PC_EUDEV_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "eudev          : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_EUDEV_VERSION}")
message(STATUS "  cflags       : ${PC_EUDEV_CFLAGS}")
message(STATUS "  cflags other : ${PC_EUDEV_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_EUDEV_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_EUDEV_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_EUDEV_LIBRARIES}")

find_path(EUDEV_INCLUDE_DIRS libudev.h
    HINTS ${PC_EUDEV_INCLUDEDIR} ${PC_EUDEV_INCLUDE_DIRS})

find_library(EUDEV_LIBRARY NAMES udev
        HINTS ${PC_EUDEV_LIBDIR} ${PC_EUDEV_LIBRARY_DIRS})

find_program(EUDEV_EXECUTABLES udevadm udevd
    HINTS ${CMAKE_INSTALL_PREFIX}/bin)

set(EUDEV_LIBRARIES ${EUDEV_LIBRARY} )
set(EUDEV_INCLUDE_DIR ${EUDEV_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set EUDEV_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(EUDEV DEFAULT_MSG
        EUDEV_LIBRARY EUDEV_INCLUDE_DIR EUDEV_EXECUTABLES)

if (EUDEV_FOUND)
    if(EUDEV_REQUIRED_VERSION)
        if (NOT "${EUDEV_REQUIRED_VERSION}" STREQUAL "${PC_EUDEV_VERSION}")
            message(WARNING "Incorrect version, please install libudev-${EUDEV_REQUIRED_VERSION}")
            unset(EUDEV_FOUND)
        endif()
    else()
        message(STATUS "Found libudev")
    endif()
else()
    message(WARNING "Could not find libudev, please install: sudo apt-get install libudev-dev")
endif()

mark_as_advanced(EUDEV_INCLUDE_DIR EUDEV_LIBRARY)
