# - Try to find LibPCRE
# Once done this will define
#  LIBPCRE_FOUND - System has LibPCRE
#  LIBPCRE_INCLUDE_DIR - The LibPCRE include directories
#  LIBPCRE_LIBRARIES - The libraries needed to use LibPCRE
#  LIBPCRE_DEFINITIONS - Compiler switches required for using LibPCRE

find_package(PkgConfig)
pkg_check_modules(PC_LIBPCRE QUIET libpcre)
set(LIBPCRE_DEFINITIONS ${PC_LIBPCRE_CFLAGS_OTHER})

if(PC_LIBPCRE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "pcre           : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBPCRE_VERSION}")
message(STATUS "  cflags       : ${PC_LIBPCRE_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBPCRE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBPCRE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBPCRE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBPCRE_LIBRARIES}")

find_path(LIBPCRE_INCLUDE_DIRS pcre.h pcre_scanner.h pcre_stringpiece.h pcrecpp.h pcrecpparg.h pcreposix.h
        HINTS ${PC_LIBPCRE_INCLUDEDIR} ${PC_LIBPCRE_INCLUDE_DIRS})
find_library(LIBPCRE_LIBRARY NAMES pcre pcre16 pcre32 pcrecpp pcreposix
    HINTS ${PC_LIBPCRE_LIBDIR} ${PC_LIBPCRE_LIBRARY_DIRS})

set(LIBPCRE_INCLUDE_DIR ${LIBPCRE_INCLUDE_DIRS} )
set(LIBPCRE_INCLUDE_DIR ${LIBPCRE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBPCRE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBPCRE DEFAULT_MSG
        LIBPCRE_INCLUDE_DIR LIBPCRE_INCLUDE_DIR)

if (LIBPCRE_FOUND)
    if(LIBPCRE_REQUIRED_VERSION)
        if (NOT "${LIBPCRE_REQUIRED_VERSION}" STREQUAL "${PC_LIBPCRE_VERSION}")
            message(WARNING "Incorrect version, please install libpcre-${LIBPCRE_REQUIRED_VERSION}")
            unset(LIBPCRE_FOUND)
        endif()
    else()
        message(STATUS "Found libpcre")
    endif()
else()
    message(WARNING "Could not find libpcre, please install: sudo apt-get install libpcre3-dev")
endif()

mark_as_advanced(LIBPCRE_INCLUDE_DIR LIBPCRE_LIBRARY)
