# - Try to find Westeros_SimpleShell
# Once done this will define
#  WESTEROS_SIMPLESHELL_FOUND - System has Westeros_SimpleShell
#  WESTEROS_SIMPLESHELL_INCLUDE_DIR - The Westeros_SimpleShell include directories
#  WESTEROS_SIMPLESHELL_LIBRARIES - The libraries needed to use Westeros_SimpleShell
#  WESTEROS_SIMPLESHELL_DEFINITIONS - Compiler switches required for using Westeros_SimpleShell

find_path(WESTEROS_SIMPLESHELL_INCLUDE_DIRS westeros-simpleshell.h simpleshell-client-protocol.h
    HINTS ${CMAKE_INSTALL_PREFIX}/include)

find_library(WESTEROS_SIMPLESHELL_CLIENT_LIBRARY NAMES westeros_simpleshell_client
    HINTS ${CMAKE_INSTALL_PREFIX}/lib )
find_library(WESTEROS_SIMPLESHELL_SERVER_LIBRARY NAMES westeros_simpleshell_server
    HINTS ${CMAKE_INSTALL_PREFIX}/lib )

set(WESTEROS_SIMPLESHELL_LIBRARIES ${WESTEROS_SIMPLESHELL_CLIENT_LIBRARY} ${WESTEROS_SIMPLESHELL_SERVER_LIBRARY})
set(WESTEROS_SIMPLESHELL_INCLUDE_DIR ${WESTEROS_SIMPLESHELL_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set WESTEROS_SIMPLESHELL_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Westeros_SimpleShell DEFAULT_MSG
        WESTEROS_SIMPLESHELL_LIBRARIES WESTEROS_SIMPLESHELL_INCLUDE_DIR)

if(WESTEROS_SIMPLESHELL_FOUND)
set(FOUND_TEXT "Found")
else()
set(FOUND_TEXT "Not found")
endif()

message(STATUS "westeros-simpleshell: ${FOUND_TEXT}")
message(STATUS "  include dirs : ${WESTEROS_SIMPLESHELL_INCLUDE_DIRS}")
message(STATUS "  libs         : ${WESTEROS_SIMPLESHELL_LIBRARIES}")

if (WESTEROS_SIMPLESHELL_FOUND)
    message(STATUS "Found westeros-simpleshell")
else()
    message(WARNING "Could not find westeros-simpleshell, please install")
endif()

mark_as_advanced(WESTEROS_SIMPLESHELL_INCLUDE_DIR WESTEROS_SIMPLESHELL_CLIENT_LIBRARY WESTEROS_SIMPLESHELL_SERVER_LIBRARY)
