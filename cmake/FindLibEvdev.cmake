# - Try to find libevdev
# Once done this will define
#  LIBEVDEV_FOUND - System has libevdev
#  LIBEVDEV_INCLUDE_DIRS - The libevdev include directories
#  LIBEVDEV_LIBRARIES - The libraries needed to use libevdev

find_package(PkgConfig)
pkg_check_modules(PC_LIBEVDEV QUIET libevdev)

if(PC_LIBEVDEV_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libevdev       : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBEVDEV_VERSION}")
message(STATUS "  cflags       : ${PC_LIBEVDEV_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBEVDEV_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBEVDEV_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBEVDEV_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBEVDEV_LIBRARIES}")

FIND_PATH(
    LIBEVDEV_INCLUDE_DIR libevdev/libevdev.h
    HINTS ${PC_LIBEVDEV_INCLUDEDIR} ${PC_LIBEVDEV_INCLUDE_DIRS}
    /usr/include
    /usr/local/include
    ${LIBEVDEV_PATH_INCLUDES}
)

FIND_LIBRARY(
    LIBEVDEV_LIBRARY
    NAMES evdev libevdev
    HINTS ${PC_LIBEVDEV_LIBDIR} ${PC_LIBEVDEV_LIBRARY_DIRS}
    PATHS ${ADDITIONAL_LIBRARY_PATHS}
    ${LIBEVDEV_PATH_LIB}
)

set(LIBEVDEV_LIBRARIES ${LIBEVDEV_LIBRARY} )
set(LIBEVDEV_INCLUDE_DIRS ${LIBEVDEV_INCLUDE_DIR} )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libevdev  DEFAULT_MSG
    LIBEVDEV_LIBRARY LIBEVDEV_INCLUDE_DIR)

if (LIBEVDEV_FOUND)
    if(LIBEVDEV_REQUIRED_VERSION)
        if (NOT "${LIBEVDEV_REQUIRED_VERSION}" STREQUAL "${PC_LIBEVDEV_VERSION}")
            message(WARNING "Incorrect version, please install libevdev-${LIBEVDEV_REQUIRED_VERSION}")
            unset(LIBEVDEV_FOUND)
        endif()
    else()
        message(STATUS "Found libevdev")
    endif()
else()
    message(WARNING "Could not find libevdev, please install: sudo apt-get install libevdev-dev")
endif()

mark_as_advanced(LIBEVDEV_INCLUDE_DIR LIBEVDEV_LIBRARY )