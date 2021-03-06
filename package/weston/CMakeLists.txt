project(weston)

set(WESTON_VERSION 1.12.0)
set(WESTON_REQUIRED_VERSION ${WESTON_VERSION})
set(WESTON_NAME ${PROJECT_NAME})
set(WESTON_BASE ${WESTON_NAME}-${WESTON_VERSION})

find_package(Weston QUIET)

if (NOT WESTON_FOUND)
    set(WESTON_EXTENSION tar.xz)
    set(WESTON_FULLNAME ${WESTON_BASE}.${WESTON_EXTENSION})
    set(WESTON_SITE http://wayland.freedesktop.org/releases)
    set(WESTON_STAMP_DIR ${PACKAGE_STAMP_DIR}/${WESTON_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${WESTON_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${WESTON_SITE}
        ${WESTON_FULLNAME}
        ${WESTON_BASE}
        ${WESTON_BASE}
        ""
        ""
        "CFLAGS=-I${CMAKE_INSTALL_PREFIX}/include LDFLAGS=-L${CMAKE_INSTALL_PREFIX}/lib ./configure --prefix=${CMAKE_INSTALL_PREFIX} \
            --enable-demo-clients-install \
            --disable-setuid-install"
        "make"
        ""
#        "make check" // One test fails (xwayland)
        "make install")
    add_dependencies(${WESTON_BASE}
        wayland-1.13.0
        wayland-protocols-1.7
        libevdev-1.5.6
        libxkbcommon-0.7.1
        cairo-1.14.8
        libjpeg-turbo-1.5.1
        mesa-17.0.4
        mtdev-1.1.5
        libXcursor-1.1.14
        libXrender-0.9.10)
else()
    add_custom_target(${WESTON_BASE})
endif()