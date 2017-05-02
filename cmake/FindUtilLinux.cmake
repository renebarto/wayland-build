# - Try to find UtilLinux - specifically targetting on libmount
# Once done this will define
#  UTIL_LINUX_FOUND - System has UtilLinux
#  UTIL_LINUX_INCLUDE_DIR - The UtilLinux include directories
#  UTIL_LINUX_LIBRARIES - The libraries needed to use UtilLinux
#  UTIL_LINUX_DEFINITIONS - Compiler switches required for using UtilLinux

find_package(PkgConfig)
pkg_check_modules(PC_UTIL_LINUX QUIET mount)
set(UTIL_LINUX_DEFINITIONS ${PC_UTIL_LINUX_CFLAGS_OTHER})

if(PC_UTIL_LINUX_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "util-linux     : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_UTIL_LINUX_VERSION}")
message(STATUS "  cflags       : ${PC_UTIL_LINUX_CFLAGS}")
message(STATUS "  cflags other : ${PC_UTIL_LINUX_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_UTIL_LINUX_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_UTIL_LINUX_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_UTIL_LINUX_LIBRARIES}")

find_path(UTIL_LINUX_INCLUDE_DIRS libmount
    HINTS ${PC_UTIL_LINUX_INCLUDEDIR} ${PC_UTIL_LINUX_INCLUDE_DIRS})
find_library(UTIL_LINUX_LIBRARY NAMES libblkid.so, libfdisk.so, libmount.so, libsmartcols.so, and libuuid.so
    HINTS ${PC_UTIL_LINUX_LIBDIR} ${PC_UTIL_LINUX_LIBRARY_DIRS})

find_program(UTIL_LINUX_PROGRAMS mount mountpoint umount)

set(UTIL_LINUX_LIBRARIES ${UTIL_LINUX_LIBRARY} )
set(UTIL_LINUX_INCLUDE_DIR ${UTIL_LINUX_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set UTIL_LINUX_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(UTIL_LINUX DEFAULT_MSG
        UTIL_LINUX_INCLUDE_DIR UTIL_LINUX_LIBRARIES)

if (UTIL_LINUX_FOUND)
    if(UTIL_LINUX_REQUIRED_VERSION)
        if (NOT "${UTIL_LINUX_REQUIRED_VERSION}" STREQUAL "${PC_UTIL_LINUX_VERSION}")
            message(WARNING "Incorrect version, please install util-linux-${UTIL_LINUX_REQUIRED_VERSION}")
            unset(UTIL_LINUX_FOUND)
        endif()
    else()
        message(STATUS "Found util-linux")
    endif()
else()
    message(WARNING "Could not find util-linux, please install: sudo apt-get install util-linux")
endif()

mark_as_advanced(UTIL_LINUX_INCLUDE_DIR)
