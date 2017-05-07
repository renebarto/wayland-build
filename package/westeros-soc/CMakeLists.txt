project(westeros-soc)

set(WESTEROS_SOC_VERSION 87bc367344f7aab820b74e8fd01f4cf104807ab8)
set(WESTEROS_SOC_NAME ${PROJECT_NAME})
set(WESTEROS_SOC_BASE ${WESTEROS_SOC_NAME}-${WESTEROS_SOC_VERSION})

find_package(Westeros-Soc QUIET)

if (NOT WESTEROS_SOC_FOUND)
    set(WESTEROS_SOC_EXTENSION tar.gz)
    set(WESTEROS_SOC_FULLNAME ${WESTEROS_SOC_VERSION}.${WESTEROS_SOC_EXTENSION})
    set(WESTEROS_SOC_SITE https://github.com/rdkcmf/westeros/archive)
    set(WESTEROS_SOC_STAMP_DIR ${PACKAGE_STAMP_DIR}/${WESTEROS_SOC_BASE})

    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${WESTEROS_SOC_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${WESTEROS_SOC_SITE}
        ${WESTEROS_SOC_FULLNAME}
        ${WESTEROS_SOC_BASE}
        ${WESTEROS_SOC_BASE}
        ""
        "cd ${PACKAGE_BUILD_DIR}/${WESTEROS_SOC_BASE}/drm && mkdir -p cfg && autoreconf -i -f -Icfg"
        "cd ${PACKAGE_BUILD_DIR}/${WESTEROS_SOC_BASE}/drm && \
         ./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "SCANNER_TOOL=${CMAKE_INSTALL_PREFIX}/bin/wayland-scanner make -C ${PACKAGE_BUILD_DIR}/${WESTEROS_SOC_BASE}/protocol && \
         CPATH=${CMAKE_INSTALL_PREFIX}/include:${CMAKE_INSTALL_PREFIX}/include/libdrm LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib make -C ${PACKAGE_BUILD_DIR}/${WESTEROS_SOC_BASE}/drm"
        ""
        #        "make check" // One test fails (xwayland)
        "make -C ${PACKAGE_BUILD_DIR}/${WESTEROS_SOC_BASE}/drm install")
    add_dependencies(${WESTEROS_SOC_BASE}
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
    add_custom_target(${WESTEROS_SOC_BASE})
endif()