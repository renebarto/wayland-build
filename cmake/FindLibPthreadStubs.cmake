# - Try to find LibXau
# Once done this will define
#  LIBPTHREAD_STUBS_FOUND - System has LibXau
#  LIBPTHREAD_STUBS_INCLUDE_DIR - The LibXau include directories
#  LIBPTHREAD_STUBS_LIBRARIES - The libraries needed to use LibXau
#  LIBPTHREAD_STUBS_DEFINITIONS - Compiler switches required for using LibXau

find_package(PkgConfig)
pkg_check_modules(PC_LIBPTHREAD_STUBS QUIET pthread-stubs)
set(LIBPTHREAD_STUBS_DEFINITIONS ${PC_LIBPTHREAD_STUBS_CFLAGS_OTHER})

if(PC_LIBPTHREAD_STUBS_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libpthread-stubs: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBPTHREAD_STUBS_VERSION}")
message(STATUS "  cflags       : ${PC_LIBPTHREAD_STUBS_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBPTHREAD_STUBS_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBPTHREAD_STUBS_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBPTHREAD_STUBS_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBPTHREAD_STUBS_LIBRARIES}")

set(LIBPTHREAD_STUBS_LIBRARIES ${LIBPTHREAD_STUBS_LIBRARY} )
set(LIBPTHREAD_STUBS_INCLUDE_DIR ${LIBPTHREAD_STUBS_INCLUDE_DIRS} )

set(LIBPTHREAD_STUBS_FOUND ${PC_LIBPTHREAD_STUBS_FOUND})

if (LIBPTHREAD_STUBS_FOUND)
    if(LIBPTHREAD_STUBS_REQUIRED_VERSION)
        if (NOT "${LIBPTHREAD_STUBS_REQUIRED_VERSION}" STREQUAL "${PC_LIBPTHREAD_STUBS_VERSION}")
            message(WARNING "Incorrect version, please install libpthread-stubs-${LIBPTHREAD_STUBS_REQUIRED_VERSION}")
            unset(LIBPTHREAD_STUBS_FOUND)
        endif()
    else()
        message(STATUS "Found libpthread-stubs")
    endif()
else()
    message(WARNING "Could not find libpthread-stubs, please install: sudo apt-get install libpthread-stubs0-dev")
endif()

mark_as_advanced(LIBPTHREAD_STUBS_INCLUDE_DIR LIBPTHREAD_STUBS_LIBRARY)
