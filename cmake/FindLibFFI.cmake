# - Try to find LibFFI
# Once done this will define
#  LIBFFI_FOUND - System has LibFFI
#  LIBFFI_INCLUDE_DIR - The LibFFI include directories
#  LIBFFI_LIBRARIES - The libraries needed to use LibFFI
#  LIBFFI_DEFINITIONS - Compiler switches required for using LibFFI

find_package(PkgConfig)
pkg_check_modules(PC_LIBFFI QUIET libffi)
set(LIBFFI_DEFINITIONS ${PC_LIBFFI_CFLAGS_OTHER})

if(PC_LIBFFI_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libffi         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBFFI_VERSION}")
message(STATUS "  cflags       : ${PC_LIBFFI_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBFFI_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBFFI_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBFFI_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBFFI_LIBRARIES}")

find_path(LIBFFI_INCLUDE_DIRS ffi.h
        HINTS ${PC_LIBFFI_INCLUDEDIR} ${PC_LIBFFI_INCLUDE_DIRS})

find_library(LIBFFI_LIBRARY NAMES ffi
        HINTS ${PC_LIBFFI_LIBDIR} ${PC_LIBFFI_LIBRARY_DIRS} )

message(STATUS "  include dirs : ${LIBFFI_INCLUDE_DIRS}")
message(STATUS "  lib          : ${LIBFFI_LIBRARY}")

set(LIBFFI_LIBRARIES ${LIBFFI_LIBRARY} )
set(LIBFFI_INCLUDE_DIR ${LIBFFI_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBFFI_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LibFFI DEFAULT_MSG
        LIBFFI_LIBRARY LIBFFI_INCLUDE_DIR)

if (LIBFFI_FOUND)
    message(STATUS "Found libffi")
else()
    message(WARNING "Could not find libffi, please install: sudo apt-get install libffi-dev")
endif()
mark_as_advanced(LIBFFI_INCLUDE_DIR LIBFFI_LIBRARY)
