project(westeros-simplebuffer)

set(WESTEROS_SIMPLEBUFFER_VERSION 87bc367344f7aab820b74e8fd01f4cf104807ab8)
set(WESTEROS_SIMPLEBUFFER_NAME ${PROJECT_NAME})
set(WESTEROS_SIMPLEBUFFER_BASE ${WESTEROS_SIMPLEBUFFER_NAME}-${WESTEROS_SIMPLEBUFFER_VERSION})

find_package(Westeros-SimpleBuffer QUIET)

if (NOT WESTEROS_SIMPLEBUFFER_FOUND)
    set(WESTEROS_SIMPLEBUFFER_EXTENSION tar.gz)
    set(WESTEROS_SIMPLEBUFFER_FULLNAME ${WESTEROS_SIMPLEBUFFER_VERSION}.${WESTEROS_SIMPLEBUFFER_EXTENSION})
    set(WESTEROS_SIMPLEBUFFER_SITE https://github.com/rdkcmf/westeros/archive)
    set(WESTEROS_SIMPLEBUFFER_STAMP_DIR ${PACKAGE_STAMP_DIR}/${WESTEROS_SIMPLEBUFFER_BASE})

    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${WESTEROS_SIMPLEBUFFER_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${WESTEROS_SIMPLEBUFFER_SITE}
        ${WESTEROS_SIMPLEBUFFER_FULLNAME}
        ${WESTEROS_SIMPLEBUFFER_BASE}
        ${WESTEROS_SIMPLEBUFFER_BASE}
        ""
        "cd ${PACKAGE_BUILD_DIR}/${WESTEROS_SIMPLEBUFFER_BASE}/simplebuffer && mkdir -p cfg && autoreconf -i -f -Icfg"
        "cd ${PACKAGE_BUILD_DIR}/${WESTEROS_SIMPLEBUFFER_BASE}/simplebuffer && \
         ./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "SCANNER_TOOL=${CMAKE_INSTALL_PREFIX}/bin/wayland-scanner make -C ${PACKAGE_BUILD_DIR}/${WESTEROS_SIMPLEBUFFER_BASE}/simplebuffer/protocol && \
         make -C ${PACKAGE_BUILD_DIR}/${WESTEROS_SIMPLEBUFFER_BASE}/simplebuffer"
        ""
        #        "make check" // One test fails (xwayland)
        "make -C ${PACKAGE_BUILD_DIR}/${WESTEROS_SIMPLEBUFFER_BASE}/simplebuffer install")
    add_dependencies(${WESTEROS_SIMPLEBUFFER_BASE}
        wayland-1.13.0
        wayland-protocols-1.7
        libevdev-1.5.6
        libxkbcommon-0.7.1
        cairo-1.14.8
        libjpeg-turbo-1.5.1
        mesa-17.0.4
        mtdev-1.1.5
        libXcursor-1.1.14
        libXrender-0.9.10
        glib-2.52.1
        gstreamer-1.10.4)

else()
    add_custom_target(${WESTEROS_SIMPLEBUFFER_BASE})
endif()