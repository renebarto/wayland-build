project(wayland)

include(utilities)
find_package(Wayland QUIET)

set(WAYLAND_FOUND FALSE)

set(WAYLAND_MODULE ${PROJECT_NAME})
set(WAYLAND_VERSION 1.13.0)
set(WAYLAND_BASE ${WAYLAND_MODULE}-${WAYLAND_VERSION})

if (NOT WAYLAND_FOUND)
    set(WAYLAND_EXTENSION tar.xz)
    set(WAYLAND_FULLNAME ${WAYLAND_BASE}.${WAYLAND_EXTENSION})
    set(WAYLAND_SITE http://wayland.freedesktop.org/releases)
    set(WAYLAND_STAMP_DIR ${PACKAGE_STAMP_DIR}/${WAYLAND_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${WAYLAND_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${WAYLAND_SITE}
        ${WAYLAND_FULLNAME}
        ${WAYLAND_MODULE}
        ${WAYLAND_BASE}
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static --disable-documentation")
    add_dependencies(${WAYLAND_BASE} libffi-3.2.1 expat-2.2.0 libxml2-2.9.4)
else()
    add_custom_target(${WAYLAND_BASE})
endif()