# - Try to find Linux-PAM
# Once done this will define
#  LINUX_PAM_FOUND - System has Linux-PAM
#  LINUX_PAM_INCLUDE_DIR - The Linux-PAM include directories
#  LINUX_PAM_LIBRARIES - The libraries needed to use Linux-PAM
#  LINUX_PAM_DEFINITIONS - Compiler switches required for using Linux-PAM

find_path(LINUX_PAM_INCLUDE_DIRS pam_appl.h pam_client.h)

find_library(LINUX_PAM_LIBRARY NAMES pam pamc)

set(LINUX_PAM_LIBRARIES ${LINUX_PAM_LIBRARY} )
set(LINUX_PAM_INCLUDE_DIR ${LINUX_PAM_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LINUX_PAM_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LINUX_PAM DEFAULT_MSG
        LINUX_PAM_LIBRARY LINUX_PAM_INCLUDE_DIR)

if(LINUX_PAM_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "linux-pam      : ${FOUND_TEXT}")
message(STATUS "  version      : ${LINUX_PAM_VERSION}")
message(STATUS "  cflags       : ${LINUX_PAM_CFLAGS}")
message(STATUS "  cflags other : ${LINUX_PAM_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${LINUX_PAM_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${LINUX_PAM_LIBRARY_DIRS}")
message(STATUS "  libs         : ${LINUX_PAM_LIBRARIES}")

if (LINUX_PAM_FOUND)
    if(LINUX_PAM_REQUIRED_VERSION)
        if (NOT "${LINUX_PAM_REQUIRED_VERSION}" STREQUAL "${LINUX_PAM_VERSION}")
            message(WARNING "Incorrect version, please install libpam0g-${LINUX_PAM_REQUIRED_VERSION}")
            unset(LINUX_PAM_FOUND)
        endif()
    else()
        message(STATUS "Found libpam0g")
    endif()
else()
    message(WARNING "Could not find libpam0g, please install: sudo apt-get install libpam0g-dev")
endif()

mark_as_advanced(LINUX_PAM_INCLUDE_DIR LINUX_PAM_LIBRARY)
