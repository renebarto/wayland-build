# - Try to find Westeros_Soc
# Once done this will define
#  WESTEROS_SOC_FOUND - System has Westeros_Soc
#  WESTEROS_SOC_INCLUDE_DIR - The Westeros_Soc include directories
#  WESTEROS_SOC_LIBRARIES - The libraries needed to use Westeros_Soc
#  WESTEROS_SOC_DEFINITIONS - Compiler switches required for using Westeros_Soc

find_path(WESTEROS_SOC_INCLUDE_DIRS westeros-gl.h
    HINTS ${CMAKE_INSTALL_PREFIX}/include)

find_library(WESTEROS_SOC_LIBRARY NAMES westeros_gl
    HINTS ${CMAKE_INSTALL_PREFIX}/lib )

set(WESTEROS_SOC_LIBRARIES ${WESTEROS_SOC_LIBRARY} )
set(WESTEROS_SOC_INCLUDE_DIR ${WESTEROS_SOC_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set WESTEROS_SOC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Westeros_Soc DEFAULT_MSG
        WESTEROS_SOC_LIBRARIES WESTEROS_SOC_INCLUDE_DIR)

if(WESTEROS_SOC_FOUND)
set(FOUND_TEXT "Found")
else()
set(FOUND_TEXT "Not found")
endif()

message(STATUS "westeros-soc: ${FOUND_TEXT}")
message(STATUS "  include dirs : ${WESTEROS_SOC_INCLUDE_DIRS}")
message(STATUS "  libs         : ${WESTEROS_SOC_LIBRARIES}")

if (WESTEROS_SOC_FOUND)
    message(STATUS "Found westeros-soc")
else()
    message(WARNING "Could not find westeros-soc, please install")
endif()

mark_as_advanced(WESTEROS_SOC_INCLUDE_DIR WESTEROS_SOC_CLIENT_LIBRARY WESTEROS_SOC_SERVER_LIBRARY)
