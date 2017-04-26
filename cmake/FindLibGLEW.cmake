# - Try to find LibGLEW
# Once done this will define
#  LIBGLEW_FOUND - System has LibGLEW
#  LIBGLEW_INCLUDE_DIR - The LibGLEW include directories
#  LIBGLEW_LIBRARIES - The libraries needed to use LibGLEW
#  LIBGLEW_DEFINITIONS - Compiler switches required for using LibGLEW

find_package(PkgConfig)
pkg_check_modules(PC_LIBGLEW QUIET glew)
set(LIBGLEW_DEFINITIONS ${PC_LIBGLEW_CFLAGS_OTHER})

if(PC_LIBGLEW_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libglew        : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBGLEW_VERSION}")
message(STATUS "  cflags       : ${PC_LIBGLEW_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBGLEW_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBGLEW_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBGLEW_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBGLEW_LIBRARIES}")

find_path(LIBGLEW_INCLUDE_DIRS GLEW/gl.h
        HINTS ${PC_LIBGLEW_INCLUDEDIR} ${PC_LIBGLEW_INCLUDE_DIRS})

find_library(LIBGLEW_LIBRARY NAMES glew
        HINTS ${PC_LIBGLEW_LIBDIR} ${PC_LIBGLEW_LIBRARY_DIRS})

set(LIBGLEW_LIBRARIES ${LIBGLEW_LIBRARY} )
set(LIBGLEW_INCLUDE_DIR ${LIBGLEW_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBGLEW_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBGLEW DEFAULT_MSG
        LIBGLEW_LIBRARY LIBGLEW_INCLUDE_DIR)

if (LIBGLEW_FOUND)
    if(LIBGLEW_REQUIRED_VERSION)
        if (NOT "${LIBGLEW_REQUIRED_VERSION}" STREQUAL "${PC_LIBGLEW_VERSION}")
            message(WARNING "Incorrect version, please install libglew-${LIBGLEW_REQUIRED_VERSION}")
            unset(LIBGLEW_FOUND)
        endif()
    else()
        message(STATUS "Found libglew")
    endif()
else()
    message(WARNING "Could not find libglew, please install: sudo apt-get install libglew-dev")
endif()

mark_as_advanced(LIBGLEW_INCLUDE_DIR LIBGLEW_LIBRARY)
