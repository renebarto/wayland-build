# - Try to find Westeros
# Once done this will define
#  WESTEROS_FOUND - System has Westeros
#  WESTEROS_INCLUDE_DIR - The Westeros include directories
#  WESTEROS_LIBRARIES - The libraries needed to use Westeros
#  WESTEROS_DEFINITIONS - Compiler switches required for using Westeros

find_package(PkgConfig)
pkg_check_modules(PC_WESTEROS QUIET westeros-compositor)
set(WESTEROS_DEFINITIONS ${PC_WESTEROS_CFLAGS_OTHER})

if(PC_WESTEROS_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "westeros-compositor: ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_WESTEROS_VERSION}")
message(STATUS "  cflags       : ${PC_WESTEROS_CFLAGS}")
message(STATUS "  cflags other : ${PC_WESTEROS_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_WESTEROS_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_WESTEROS_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_WESTEROS_LIBRARIES}")

find_path(WESTEROS_INCLUDE_DIRS westeros-compositor.h westeros-render.h protocol/vpc-client-protocol.h
        HINTS ${PC_WESTEROS_INCLUDEDIR} ${PC_WESTEROS_INCLUDE_DIRS})

find_library(WESTEROS_LIBRARY_COMPOSITOR NAMES westeros_compositor
        HINTS ${PC_WESTEROS_LIBDIR} ${PC_WESTEROS_LIBRARY_DIRS} )
find_library(WESTEROS_LIBRARY_RENDER_GL NAMES westeros_render_gl
    HINTS ${PC_WESTEROS_LIBDIR} ${PC_WESTEROS_LIBRARY_DIRS} )
find_library(WESTEROS_LIBRARY_RENDER_EMBEDDED NAMES westeros_render_embedded
    HINTS ${PC_WESTEROS_LIBDIR} ${PC_WESTEROS_LIBRARY_DIRS} )

find_program(WESTEROS_EXECUTABLE NAMES westeros
    HINTS ${CMAKE_INSTALL_PREFIX}/bin )
find_program(WESTEROS_EXECUTABLE_TEST NAMES westeros_test
    HINTS ${CMAKE_INSTALL_PREFIX}/bin )

set(WESTEROS_LIBRARIES ${WESTEROS_LIBRARY_COMPOSITOR} ${WESTEROS_LIBRARY_RENDER_GL} ${WESTEROS_LIBRARY_RENDER_EMBEDDED} )
set(WESTEROS_INCLUDE_DIR ${WESTEROS_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set WESTEROS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Westeros DEFAULT_MSG
        WESTEROS_LIBRARIES WESTEROS_INCLUDE_DIR WESTEROS_EXECUTABLE WESTEROS_EXECUTABLE_TEST)

if (WESTEROS_FOUND)
    if(WESTEROS_REQUIRED_VERSION)
        if (NOT "${WESTEROS_REQUIRED_VERSION}" STREQUAL "${PC_WESTEROS_VERSION}")
            message(WARNING "Incorrect version, please install weston-${WESTEROS_REQUIRED_VERSION}")
            unset(WESTEROS_FOUND)
        endif()
    else()
        message(STATUS "Found weston")
    endif()
else()
    message(WARNING "Could not find weston, please install: sudo apt-get install weston")
endif()

mark_as_advanced(WESTEROS_INCLUDE_DIR WESTEROS_LIBRARIES)
