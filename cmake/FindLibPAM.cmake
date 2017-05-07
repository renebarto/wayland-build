# - Try to find LibPAM
# Once done this will define
#  LIBPAM_FOUND - System has LibPAM
#  LIBPAM_INCLUDE_DIR - The LibPAM include directories
#  LIBPAM_LIBRARIES - The libraries needed to use LibPAM
#  LIBPAM_DEFINITIONS - Compiler switches required for using LibPAM

find_package(PkgConfig)
find_path(LIBPAM_INCLUDE_DIRS security/pam_appl.h security/pam_client.h security/pam_ext.h security/pam_filter.h
    security/pam_misc.h security/pam_modules.h security/pam_modutil.h
    HINTS ${CMAKE_INSTALL_PREFIX}/include)

find_library(LIBPAM_LIBRARY NAMES pam pam_misc pamc
        HINTS ${CMAKE_INSTALL_PREFIX}/lib)

set(LIBPAM_LIBRARIES ${LIBPAM_LIBRARY} )
set(LIBPAM_INCLUDE_DIR ${LIBPAM_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBPAM_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBPAM DEFAULT_MSG
        LIBPAM_LIBRARY LIBPAM_INCLUDE_DIR)

if(LIBPAM_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libpam         : ${FOUND_TEXT}")
message(STATUS "  include dirs : ${PC_LIBPAM_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBPAM_LIBRARY_DIRS}")

if (LIBPAM_FOUND)
    message(STATUS "Found libpam")
else()
    message(WARNING "Could not find libpam, please install: sudo apt-get install libpam0g-dev")
endif()

mark_as_advanced(LIBPAM_INCLUDE_DIR LIBPAM_LIBRARY)
