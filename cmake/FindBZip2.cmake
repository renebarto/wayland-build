# - Try to find BZip2
# Once done this will define
#  BZIP2_FOUND - System has BZip2
#  BZIP2_INCLUDE_DIR - The BZip2 include directories
#  BZIP2_LIBRARIES - The libraries needed to use BZip2
#  BZIP2_DEFINITIONS - Compiler switches required for using BZip2

find_package(PkgConfig)

find_path(BZIP2_INCLUDE_DIR bzlib.h
        HINTS ${CMAKE_INSTALL_PREFIX}/include)

find_library(BZIP2_LIBRARY NAMES bz2
        HINTS ${CMAKE_INSTALL_PREFIX}/lib)

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set BZIP2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(BZIP2 DEFAULT_MSG
        BZIP2_LIBRARY BZIP2_INCLUDE_DIR)

if(BZIP2_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "bzip2          : ${FOUND_TEXT}")
message(STATUS "  include dirs : ${BZIP2_INCLUDE_DIR}")
message(STATUS "  libs         : ${BZIP2_LIBRARY}")

if (BZIP2_FOUND)
    message(STATUS "Found bzip2")
else()
    message(WARNING "Could not find bzip2, please install: sudo apt-get install libbz2-dev")
endif()

mark_as_advanced(BZIP2_INCLUDE_DIR BZIP2_LIBRARY)
