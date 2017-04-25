# - Try to find LibFFI
# Once done this will define
#  MESA_FOUND - System has LibFFI
#  MESA_INCLUDE_DIR - The LibFFI include directories
#  MESA_LIBRARIES - The libraries needed to use LibFFI
#  MESA_DEFINITIONS - Compiler switches required for using LibFFI

find_package(PkgConfig)
pkg_check_modules(PC_MESA_GL QUIET gl)

pkg_check_modules(PC_MESA_GLESV1 QUIET glesv1_cm)

pkg_check_modules(PC_MESA_GLESV2 QUIET glesv2)

pkg_check_modules(PC_MESA_DRI QUIET dri)

pkg_check_modules(PC_MESA_GBM QUIET gbm)

pkg_check_modules(PC_MESA_EGL QUIET egl)

pkg_check_modules(PC_MESA_WAYLAND_EGL QUIET wayland-egl)

set(MESA_DEFINITIONS ${PC_MESA_GL_CFLAGS_OTHER})

if(PC_MESA_GL_FOUND)
    set(GL_FOUND_TEXT "Found")
else()
    set(GL_FOUND_TEXT "Not found")
endif()

if(PC_MESA_GLESV1_FOUND)
    set(GLESV1_FOUND_TEXT "Found")
else()
    set(v_FOUND_TEXT "Not found")
endif()

if(PC_MESA_GLESV2_FOUND)
    set(GLESV2_FOUND_TEXT "Found")
else()
    set(GLESV2_FOUND_TEXT "Not found")
endif()

if(PC_MESA_DRI_FOUND)
    set(DRI_FOUND_TEXT "Found")
else()
    set(DRI_FOUND_TEXT "Not found")
endif()

if(PC_MESA_GBM_FOUND)
    set(GBM_FOUND_TEXT "Found")
else()
    set(GBM_FOUND_TEXT "Not found")
endif()

if(PC_MESA_EGL_FOUND)
    set(EGL_FOUND_TEXT "Found")
else()
    set(EGL_FOUND_TEXT "Not found")
endif()

if(PC_MESA_WAYLAND_EGL_FOUND)
    set(WAYLAND_EGL_FOUND_TEXT "Found")
else()
    set(WAYLAND_EGL_FOUND_TEXT "Not found")
endif()

message(STATUS "mesa GL        : ${GL_FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_GL_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_GL_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_GL_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_GL_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_GL_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_GL_LIBRARIES}")
message(STATUS "mesa GLESV1    : ${GLESV1_FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_GLESV1_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_GLESV1_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_GLESV1_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_GLESV1_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_GLESV1_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_GLESV1_LIBRARIES}")
message(STATUS "mesa GLESV2    : ${GLESV2_FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_GLESV2_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_GLESV2_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_GLESV2_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_GLESV2_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_GLESV2_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_GLESV2_LIBRARIES}")
message(STATUS "mesa DRI       : ${DRI_FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_DRI_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_DRI_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_DRI_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_DRI_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_DRI_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_DRI_LIBRARIES}")
message(STATUS "mesa GBM       : ${GBM_FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_GBM_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_GBM_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_GBM_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_GBM_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_GBM_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_GBM_LIBRARIES}")
message(STATUS "mesa EGL       : ${EGL_FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_EGL_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_EGL_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_EGL_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_EGL_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_EGL_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_EGL_LIBRARIES}")
message(STATUS "mesa wl-egl    : ${WAYLAND_EGL_FOUND_TEXT}")
message(STATUS "  version      : ${PC_MESA_WAYLAND_EGL_VERSION}")
message(STATUS "  cflags       : ${PC_MESA_WAYLAND_EGL_CFLAGS}")
message(STATUS "  cflags other : ${PC_MESA_WAYLAND_EGL_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_MESA_WAYLAND_EGL_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_MESA_WAYLAND_EGL_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_MESA_WAYLAND_EGL_LIBRARIES}")

find_path(MESA_GL_INCLUDE_DIRS GL/gl.h GL/glx.h
    HINTS ${PC_MESA_GL_INCLUDEDIR} ${PC_MESA_GL_INCLUDE_DIRS})

find_library(MESA_GL_LIBRARY NAMES glapi GL
    HINTS ${PC_MESA_GL_LIBDIR} ${PC_MESA_GL_LIBRARY_DIRS})

find_path(MESA_GLESV1_INCLUDE_DIRS GLES/egl.h GLES/gl.h GLES/glext.h GLES/glplatform.h
    HINTS ${PC_MESA_GLESV1_INCLUDEDIR} ${PC_MESA_GLESV1_INCLUDE_DIRS})

find_library(MESA_GLESV1_LIBRARY NAMES GLESv1_CM
    HINTS ${PC_MESA_GLESV1_LIBDIR} ${PC_MESA_GLESV1_LIBRARY_DIRS})

find_path(MESA_GLESV2_INCLUDE_DIRS GLES2/gl2.h GLES3/gl31.h GLES3/gl32.h GLES3/gl3ext.h GLES3/gl3platform.h
    HINTS ${PC_MESA_GLESV2_INCLUDEDIR} ${PC_MESA_GLESV2_INCLUDE_DIRS})

find_library(MESA_GLESV2_LIBRARY NAMES GLESv2
    HINTS ${PC_MESA_GLESV2_LIBDIR} ${PC_MESA_GLESV2_LIBRARY_DIRS})

find_path(MESA_DRI_INCLUDE_DIRS GL/internal/dri_interface.h
    HINTS ${PC_MESA_DRI_INCLUDEDIR} ${PC_MESA_DRI_INCLUDE_DIRS})

find_path(MESA_GBM_INCLUDE_DIRS gbm.h
    HINTS ${PC_MESA_GBM_INCLUDEDIR} ${PC_MESA_GBM_INCLUDE_DIRS})

find_library(MESA_GBM_LIBRARY NAMES gbm
    HINTS ${PC_MESA_GBM_LIBDIR} ${PC_MESA_GBM_LIBRARY_DIRS})

find_path(MESA_EGL_INCLUDE_DIRS EGL/eglext.h EGL/egl.h EGL/eglextchromium.h EGL/eglmesaext.h EGL/eglplatform.h
    HINTS ${PC_MESA_EGL_INCLUDEDIR} ${PC_MESA_EGL_INCLUDE_DIRS})

find_library(MESA_EGL_LIBRARY NAMES EGL
    HINTS ${PC_MESA_EGL_LIBDIR} ${PC_MESA_EGL_LIBRARY_DIRS})

find_library(MESA_WAYLAND_EGL_LIBRARY NAMES wayland-egl
    HINTS ${PC_MESA_WAYLAND_EGL_LIBDIR} ${PC_MESA_WAYLAND_EGL_LIBRARY_DIRS})

set(MESA_GL_LIBRARIES ${MESA_GL_LIBRARY})
set(MESA_GL_INCLUDE_DIR ${MESA_GL_INCLUDE_DIRS})
set(MESA_GLESV1_LIBRARIES ${MESA_GLESV1_LIBRARY})
set(MESA_GLESV1_INCLUDE_DIR ${MESA_GLESV1_INCLUDE_DIRS})
set(MESA_GLESV2_LIBRARIES ${MESA_GLESV2_LIBRARY})
set(MESA_GLESV2_INCLUDE_DIR ${MESA_GLESV2_INCLUDE_DIRS})
set(MESA_DRI_INCLUDE_DIR ${MESA_DRI_INCLUDE_DIRS})
set(MESA_GBM_LIBRARIES ${MESA_GBM_LIBRARY})
set(MESA_GBM_INCLUDE_DIR ${MESA_GBM_INCLUDE_DIRS})
set(MESA_EGL_LIBRARIES ${MESA_EGL_LIBRARY})
set(MESA_EGL_INCLUDE_DIR ${MESA_EGL_INCLUDE_DIRS})
set(MESA_WAYLAND_EGL_LIBRARIES ${MESA_WAYLAND_EGL_LIBRARY})

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set MESA_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(MESA_GL DEFAULT_MSG
    MESA_GL_LIBRARY MESA_GL_INCLUDE_DIR)
find_package_handle_standard_args(MESA_GLESV1 DEFAULT_MSG
    MESA_GLESV1_LIBRARY MESA_GLESV1_INCLUDE_DIR)
find_package_handle_standard_args(MESA_GLESV2 DEFAULT_MSG
    MESA_GLESV2_LIBRARY MESA_GLESV2_INCLUDE_DIR)
find_package_handle_standard_args(MESA_DRI DEFAULT_MSG
    MESA_DRI_INCLUDE_DIR)
find_package_handle_standard_args(MESA_GBM DEFAULT_MSG
    MESA_GBM_LIBRARY MESA_GBM_INCLUDE_DIR)
find_package_handle_standard_args(MESA_EGL DEFAULT_MSG
    MESA_EGL_LIBRARY MESA_EGL_INCLUDE_DIR)
find_package_handle_standard_args(MESA_WAYLAND_EGL DEFAULT_MSG
    MESA_WAYLAND_EGL_LIBRARY)

if (MESA_REQUIRED_VERSION)
    set(MESA_GL_REQUIRED_VERSION ${MESA_REQUIRED_VERSION})
    set(MESA_GLESV1_REQUIRED_VERSION ${MESA_REQUIRED_VERSION})
    set(MESA_GLESV2_REQUIRED_VERSION ${MESA_REQUIRED_VERSION})
    set(MESA_DRI_REQUIRED_VERSION ${MESA_REQUIRED_VERSION})
    set(MESA_GBM_REQUIRED_VERSION ${MESA_REQUIRED_VERSION})
    set(MESA_EGL_REQUIRED_VERSION ${MESA_REQUIRED_VERSION})
    set(MESA_WAYLAND_EGL_REQUIRED_VERSION ${MESA_REQUIRED_VERSION})
endif()

if (MESA_GL_FOUND)
    if(MESA_GL_REQUIRED_VERSION)
        if (NOT "${MESA_GL_REQUIRED_VERSION}" STREQUAL "${PC_MESA_GL_VERSION}")
            message(WARNING "Incorrect version, please install libgl1-mesa-${MESA_GL_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found libgl1-mesa")
    endif()
else()
    message(WARNING "Could not find libgl1-mesa, please install: sudo apt-get install libgl1-mesa-dev")
endif()

if (MESA_GLESV1_FOUND)
    if(MESA_GLESV1_REQUIRED_VERSION)
        if (NOT "${MESA_GLESV1_REQUIRED_VERSION}" STREQUAL "${PC_MESA_GLESV1_VERSION}")
            message(WARNING "Incorrect version, please install libgles1-mesa-${MESA_GLESV1_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found libgles1-mesa")
    endif()
else()
    message(WARNING "Could not find libgles1-mesa, please install: sudo apt-get install libgles1-mesa-dev")
endif()

if (MESA_GLESV2_FOUND)
    if(MESA_GLESV2_REQUIRED_VERSION)
        if (NOT "${MESA_GLESV2_REQUIRED_VERSION}" STREQUAL "${PC_MESA_GLESV2_VERSION}")
            message(WARNING "Incorrect version, please install libgles2-mesa-${MESA_GLESV2_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found libgles2-mesa")
    endif()
else()
    message(WARNING "Could not find libgles2-mesa, please install: sudo apt-get install libgles2-mesa-dev")
endif()

if (MESA_DRI_FOUND)
    if(MESA_DRI_REQUIRED_VERSION)
        if (NOT "${MESA_DRI_REQUIRED_VERSION}" STREQUAL "${PC_MESA_DRI_VERSION}")
            message(WARNING "Incorrect version, please install libgl1-mesa-dri-${MESA_DRI_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found libgl1-mesa-dri")
    endif()
else()
    message(WARNING "Could not find libgl1-mesa-dri, please install: sudo apt-get install libgl1-mesa-dri-dev")
endif()

if (MESA_GBM_FOUND)
    if(MESA_GBM_REQUIRED_VERSION)
        if (NOT "${MESA_GBM_REQUIRED_VERSION}" STREQUAL "${PC_MESA_GBM_VERSION}")
            message(WARNING "Incorrect version, please install libgbm-${MESA_GBM_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found libgbm")
    endif()
else()
    message(WARNING "Could not find libgbm, please install: sudo apt-get install libgbm-dev")
endif()

if (MESA_EGL_FOUND)
    if(MESA_EGL_REQUIRED_VERSION)
        if (NOT "${MESA_EGL_REQUIRED_VERSION}" STREQUAL "${PC_MESA_EGL_VERSION}")
            message(WARNING "Incorrect version, please install libegl1-mesa-${MESA_EGL_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found libegl1-mesa")
    endif()
else()
    message(WARNING "Could not find libegl1-mesa, please install: sudo apt-get install libegl1-mesa-dev")
endif()

if (MESA_WAYLAND_EGL_FOUND)
    if(MESA_WAYLAND_EGL_REQUIRED_VERSION)
        if (NOT "${MESA_WAYLAND_EGL_REQUIRED_VERSION}" STREQUAL "${PC_MESA_WAYLAND_EGL_VERSION}")
            message(WARNING "Incorrect version, please install libwayland-egl-${MESA_WAYLAND_EGL_REQUIRED_VERSION}")
            unset(MESA_FOUND)
        endif()
    else()
        message(STATUS "Found libwayland-egl")
    endif()
else()
    message(WARNING "Could not find libwayland-egl, please install: sudo apt-get install libwayland-egl-dev")
endif()

mark_as_advanced(
    MESA_GL_INCLUDE_DIR MESA_GL_LIBRARY
    MESA_GLESV1_INCLUDE_DIR MESA_GLESV1_LIBRARY
    MESA_GLESV2_INCLUDE_DIR MESA_GLESV2_LIBRARY
    MESA_DRI_INCLUDE_DIR MESA_DRI_LIBRARY
    MESA_GBM_INCLUDE_DIR MESA_GBM_LIBRARY
    MESA_EGL_INCLUDE_DIR MESA_EGL_LIBRARY
    MESA_WAYLAND_EGL_INCLUDE_DIR MESA_WAYLAND_EGL_LIBRARY)
