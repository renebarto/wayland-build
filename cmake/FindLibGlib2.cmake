# - Try to find LibGlib2
# Once done this will define
#  LIBGLIB2_FOUND - System has LibGlib2
#  LIBGLIB2_INCLUDE_DIR - The LibGlib2 include directories
#  LIBGLIB2_LIBRARIES - The libraries needed to use LibGlib2
#  LIBGLIB2_DEFINITIONS - Compiler switches required for using LibGlib2

find_package(PkgConfig)
pkg_check_modules(PC_LIBGLIB2 QUIET glib-2.0)
pkg_check_modules(PC_LIBGIO2 QUIET gio-2.0)
pkg_check_modules(PC_LIBGMODULE2 QUIET gmodule-2.0)
pkg_check_modules(PC_LIBGOBJECT QUIET gobject-2.0)
pkg_check_modules(PC_LIBGTHREAD QUIET gthread-2.0)
set(LIBGLIB2_DEFINITIONS ${PC_LIBGLIB2_CFLAGS_OTHER})

if(PC_LIBGLIB2_FOUND)
    set(FOUND_TEXT_GLIB2 "Found")
else()
    set(FOUND_TEXT_GLIB2 "Not found")
endif()

if(PC_LIBGIO2_FOUND)
    set(FOUND_TEXT_GIO2 "Found")
else()
    set(FOUND_TEXT_GIO2 "Not found")
endif()

if(PC_LIBGMODULE2_FOUND)
    set(FOUND_TEXT_GMODULE2 "Found")
else()
    set(FOUND_TEXT_GMODULE2 "Not found")
endif()

if(PC_LIBGOBJECT2_FOUND)
    set(FOUND_TEXT_GOBJECT2 "Found")
else()
    set(FOUND_TEXT_GOBJECT2 "Not found")
endif()

if(PC_LIBGTHREAD2_FOUND)
    set(FOUND_TEXT_GTHREAD2 "Found")
else()
    set(FOUND_TEXT_GTHREAD2 "Not found")
endif()

message(STATUS "glib-2.0       : ${FOUND_TEXT_GLIB2}")
message(STATUS "  version      : ${PC_LIBGLIB2_VERSION}")
message(STATUS "  cflags       : ${PC_LIBGLIB2_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBGLIB2_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBGLIB2_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBGLIB2_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBGLIB2_LIBRARIES}")
message(STATUS "gio-2.0        : ${FOUND_TEXT_GIO2}")
message(STATUS "  version      : ${PC_LIBGIO2_VERSION}")
message(STATUS "  cflags       : ${PC_LIBGIO2_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBGIO2_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBGIO2_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBGIO2_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBGIO2_LIBRARIES}")
message(STATUS "gmodule-2.0    : ${FOUND_TEXT_GMODULE2}")
message(STATUS "  version      : ${PC_LIBGMODULE2_VERSION}")
message(STATUS "  cflags       : ${PC_LIBGMODULE2_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBGMODULE2_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBGMODULE2_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBGMODULE2_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBGMODULE2_LIBRARIES}")
message(STATUS "gobject-2.0    : ${FOUND_TEXT_GOBJECT2}")
message(STATUS "  version      : ${PC_LIBGOBJECT2_VERSION}")
message(STATUS "  cflags       : ${PC_LIBGOBJECT2_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBGOBJECT2_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBGOBJECT2_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBGOBJECT2_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBGOBJECT2_LIBRARIES}")
message(STATUS "gthread-2.0    : ${FOUND_TEXT_GTHREAD2}")
message(STATUS "  version      : ${PC_LIBGTHREAD2_VERSION}")
message(STATUS "  cflags       : ${PC_LIBGTHREAD2_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBGTHREAD2_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBGTHREAD2_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBGTHREAD2_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBGTHREAD2_LIBRARIES}")

find_path(LIBGLIB2_INCLUDE_DIRS glib-2.0/glib.h
        HINTS ${PC_LIBGLIB2_INCLUDEDIR} ${PC_LIBGLIB2_INCLUDE_DIRS})
find_path(LIBGIO2_INCLUDE_DIRS glib-2.0/gio/gio.h
    HINTS ${PC_LIBGIO2_INCLUDEDIR} ${PC_LIBGIO2_INCLUDE_DIRS})
find_path(LIBGMODULE2_INCLUDE_DIRS glib-2.0/gmodule.h
    HINTS ${PC_LIBGMODULE2_INCLUDEDIR} ${PC_LIBGMODULE2_INCLUDE_DIRS})
find_path(LIBGOBJECT2_INCLUDE_DIRS glib-2.0/gobject/gobject.h
    HINTS ${PC_LIBGOBJECT2_INCLUDEDIR} ${PC_LIBGOBJECT2_INCLUDE_DIRS})

find_library(LIBGLIB2_LIBRARY NAMES glib-2.0
        HINTS ${PC_LIBGLIB2_LIBDIR} ${PC_LIBGLIB2_LIBRARY_DIRS})
find_library(LIBGIO2_LIBRARY NAMES gio-2.0
    HINTS ${PC_LIBGIO2_LIBDIR} ${PC_LIBGIO2_LIBRARY_DIRS})
find_library(LIBGMODULE2_LIBRARY NAMES gmodule-2.0
    HINTS ${PC_LIBGMODULE2_LIBDIR} ${PC_LIBGMODULE2_LIBRARY_DIRS})
find_library(LIBGOBJECT2_LIBRARY NAMES gobject-2.0
    HINTS ${PC_LIBGOBJECT2_LIBDIR} ${PC_LIBGOBJECT2_LIBRARY_DIRS})
find_library(LIBGTHREAD2_LIBRARY NAMES gthread-2.0
    HINTS ${PC_LIBGTHREAD2_LIBDIR} ${PC_LIBGTHREAD2_LIBRARY_DIRS})

set(LIBGLIB2_LIBRARIES ${LIBGLIB2_LIBRARY} )
set(LIBGLIB2_INCLUDE_DIR ${LIBGLIB2_INCLUDE_DIRS} )
set(LIBGIO2_LIBRARIES ${LIBGIO2_LIBRARY} )
set(LIBGIO2_INCLUDE_DIR ${LIBGIO2_INCLUDE_DIRS} )
set(LIBGMODULE2_LIBRARIES ${LIBGMODULE2_LIBRARY} )
set(LIBGMODULE2_INCLUDE_DIR ${LIBGMODULE2_INCLUDE_DIRS} )
set(LIBGOBJECT2_LIBRARIES ${LIBGOBJECT2_LIBRARY} )
set(LIBGOBJECT2_INCLUDE_DIR ${LIBGOBJECT2_INCLUDE_DIRS} )
set(LIBGTHREAD2_LIBRARIES ${LIBGTHREAD2_LIBRARY} )
set(LIBGTHREAD2_INCLUDE_DIR ${LIBGLIB2_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBGLIB2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBGLIB2 DEFAULT_MSG
    LIBGLIB2_LIBRARY LIBGLIB2_INCLUDE_DIR)
find_package_handle_standard_args(LIBGIO2 DEFAULT_MSG
    LIBGIO2_LIBRARY LIBGIO2_INCLUDE_DIR)
find_package_handle_standard_args(LIBGMODULE2 DEFAULT_MSG
    LIBGMODULE2_LIBRARY LIBGMODULE2_INCLUDE_DIR)
find_package_handle_standard_args(LIBGOBJECT2 DEFAULT_MSG
    LIBGOBJECT2_LIBRARY LIBGOBJECT2_INCLUDE_DIR)
find_package_handle_standard_args(LIBGTHREAD2 DEFAULT_MSG
    LIBGTHREAD2_LIBRARY LIBGTHREAD2_INCLUDE_DIR)

if (LIBGLIB2_REQUIRED_VERSION)
    set(LIBGIO2_REQUIRED_VERSION ${LIBGLIB2_REQUIRED_VERSION})
    set(LIBGMODULE2_REQUIRED_VERSION ${LIBGLIB2_REQUIRED_VERSION})
    set(LIBGOBJECT2_REQUIRED_VERSION ${LIBGLIB2_REQUIRED_VERSION})
    set(LIBGTHREAD2_REQUIRED_VERSION ${LIBGLIB2_REQUIRED_VERSION})
endif()

if (LIBGLIB2_FOUND)
    if(LIBGLIB2_REQUIRED_VERSION)
        if (NOT "${LIBGLIB2_REQUIRED_VERSION}" STREQUAL "${PC_LIBGLIB2_VERSION}")
            message(WARNING "Incorrect version, please install libglib-${LIBGLIB2_REQUIRED_VERSION}")
            unset(LIBGLIB2_FOUND)
        endif()
    else()
        message(STATUS "Found libglib-2.0")
    endif()
else()
    message(WARNING "Could not find libglib-2.0, please install: sudo apt-get install libglib2.0-dev")
endif()

if (LIBGIO2_FOUND)
    if(LIBGIO2_REQUIRED_VERSION)
        if (NOT "${LIBGIO2_REQUIRED_VERSION}" STREQUAL "${PC_LIBGIO2_VERSION}")
            message(WARNING "Incorrect version, please install libgio-${LIBGIO2_REQUIRED_VERSION}")
            unset(LIBGIO2_FOUND)
        endif()
    else()
        message(STATUS "Found libgio-2.0")
    endif()
else()
    message(WARNING "Could not find libgio-2.0, please install: sudo apt-get install libglib2.0-dev")
endif()

if (LIBGMODULE2_FOUND)
    if(LIBGMODULE2_REQUIRED_VERSION)
        if (NOT "${LIBGMODULE2_REQUIRED_VERSION}" STREQUAL "${PC_LIBGMODULE2_VERSION}")
            message(WARNING "Incorrect version, please install libgmodule-${LIBGMODULE2_REQUIRED_VERSION}")
            unset(LIBGMODULE2_FOUND)
        endif()
    else()
        message(STATUS "Found libgmodule-2.0")
    endif()
else()
    message(WARNING "Could not find libgmodule-2.0, please install: sudo apt-get install libglib2.0-dev")
endif()

if (LIBGOBJECT2_FOUND)
    if(LIBGOBJECT2_REQUIRED_VERSION)
        if (NOT "${LIBGOBJECT2_REQUIRED_VERSION}" STREQUAL "${PC_LIBGOBJECT2_VERSION}")
            message(WARNING "Incorrect version, please install libgobject-${LIBGOBJECT2_REQUIRED_VERSION}")
            unset(LIBGOBJECT2_FOUND)
        endif()
    else()
        message(STATUS "Found libgobject-2.0")
    endif()
else()
    message(WARNING "Could not find libgobject-2.0, please install: sudo apt-get install libglib2.0-dev")
endif()

if (LIBGTHREAD2_FOUND)
    if(LIBGTHREAD2_REQUIRED_VERSION)
        if (NOT "${LIBGTHREAD2_REQUIRED_VERSION}" STREQUAL "${PC_LIBGTHREAD2_VERSION}")
            message(WARNING "Incorrect version, please install libgthread-${LIBGTHREAD2_REQUIRED_VERSION}")
            unset(LIBGTHREAD2_FOUND)
        endif()
    else()
        message(STATUS "Found libgthread-2.0")
    endif()
else()
    message(WARNING "Could not find libgthread-2.0, please install: sudo apt-get install libglib2.0-dev")
endif()

mark_as_advanced(
    LIBGLIB2_INCLUDE_DIR LIBGLIB2_LIBRARY
    LIBGIO2_INCLUDE_DIR LIBGIO2_LIBRARY
    LIBGMODULE2_INCLUDE_DIR LIBGMODULE2_LIBRARY
    LIBGOBJECT2_INCLUDE_DIR LIBGOBJECT2_LIBRARY
    LIBGTHREAD2_INCLUDE_DIR LIBGTHREAD2_LIBRARY)
