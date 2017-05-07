# - Try to find LibGettext
# Once done this will define
#  LIBGETTEXT_FOUND - System has LibGettext
#  LIBGETTEXT_INCLUDE_DIR - The LibGettext include directories
#  LIBGETTEXT_LIBRARIES - The libraries needed to use LibGettext
#  LIBGETTEXT_DEFINITIONS - Compiler switches required for using LibGettext

find_path(LIBGETTEXT_INCLUDE_DIRS gettext-po.h
        HINTS ${CMAKE_INSTALL_PREFIX}/include)

find_library(LIBGETTEXT_LIBRARY NAMES gettextpo
        HINTS ${CMAKE_INSTALL_PREFIX}/lib)

set(LIBGETTEXT_LIBRARIES ${LIBGETTEXT_LIBRARY} )
set(LIBGETTEXT_INCLUDE_DIR ${LIBGETTEXT_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBGETTEXT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBGETTEXT DEFAULT_MSG
        LIBGETTEXT_LIBRARY LIBGETTEXT_INCLUDE_DIR)

if(LIBGETTEXT_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "gettext        : ${FOUND_TEXT}")
message(STATUS "  include dirs : ${LIBGETTEXT_INCLUDE_DIR}")
message(STATUS "  libraries    : ${LIBGETTEXT_LIBRARY}")

if (LIBGETTEXT_FOUND)
    message(STATUS "Found gettext")
else()
    message(WARNING "Could not find gettext, please install: sudo apt-get install libgettextpo-dev")
endif()

mark_as_advanced(LIBGETTEXT_INCLUDE_DIR LIBGETTEXT_LIBRARY)
