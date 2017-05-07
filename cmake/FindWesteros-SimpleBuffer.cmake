# - Try to find Westeros_SimpleBuffer
# Once done this will define
#  WESTEROS_SIMPLEBUFFER_FOUND - System has Westeros_SimpleBuffer
#  WESTEROS_SIMPLEBUFFER_INCLUDE_DIR - The Westeros_SimpleBuffer include directories
#  WESTEROS_SIMPLEBUFFER_LIBRARIES - The libraries needed to use Westeros_SimpleBuffer
#  WESTEROS_SIMPLEBUFFER_DEFINITIONS - Compiler switches required for using Westeros_SimpleBuffer

find_path(WESTEROS_SIMPLEBUFFER_INCLUDE_DIRS westeros-simplebuffer.h simplebuffer-client-protocol.h
    HINTS ${CMAKE_INSTALL_PREFIX}/include)

find_library(WESTEROS_SIMPLEBUFFER_CLIENT_LIBRARY NAMES westeros_simplebuffer_client
    HINTS ${CMAKE_INSTALL_PREFIX}/lib )
find_library(WESTEROS_SIMPLEBUFFER_SERVER_LIBRARY NAMES westeros_simplebuffer_server
    HINTS ${CMAKE_INSTALL_PREFIX}/lib )

set(WESTEROS_SIMPLEBUFFER_LIBRARIES ${WESTEROS_SIMPLEBUFFER_CLIENT_LIBRARY} ${WESTEROS_SIMPLEBUFFER_SERVER_LIBRARY})
set(WESTEROS_SIMPLEBUFFER_INCLUDE_DIR ${WESTEROS_SIMPLEBUFFER_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set WESTEROS_SIMPLEBUFFER_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Westeros_SimpleBuffer DEFAULT_MSG
        WESTEROS_SIMPLEBUFFER_LIBRARIES WESTEROS_SIMPLEBUFFER_INCLUDE_DIR)

if(WESTEROS_SIMPLEBUFFER_FOUND)
set(FOUND_TEXT "Found")
else()
set(FOUND_TEXT "Not found")
endif()

message(STATUS "westeros-simplebuffer: ${FOUND_TEXT}")
message(STATUS "  include dirs : ${WESTEROS_SIMPLEBUFFER_INCLUDE_DIRS}")
message(STATUS "  libs         : ${WESTEROS_SIMPLEBUFFER_LIBRARIES}")

if (WESTEROS_SIMPLEBUFFER_FOUND)
    message(STATUS "Found westeros-simplebuffer")
else()
    message(WARNING "Could not find westeros-simplebuffer, please install")
endif()

mark_as_advanced(WESTEROS_SIMPLEBUFFER_INCLUDE_DIR WESTEROS_SIMPLEBUFFER_CLIENT_LIBRARY WESTEROS_SIMPLEBUFFER_SERVER_LIBRARY)
