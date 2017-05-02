project(gstreamer)

set(GSTREAMER_VERSION 1.10.4)
set(GSTREAMER_REQUIRED_VERSION ${GSTREAMER_VERSION})
set(GSTREAMER_NAME ${PROJECT_NAME})
set(GSTREAMER_BASE ${GSTREAMER_NAME}-${GSTREAMER_VERSION})

find_package(GStreamer1 QUIET)

if (NOT GSTREAMER_FOUND)
    set(GSTREAMER_EXTENSION tar.xz)
    set(GSTREAMER_FULLNAME ${GSTREAMER_BASE}.${GSTREAMER_EXTENSION})
    set(GSTREAMER_SITE https://gstreamer.freedesktop.org/src/gstreamer)
    set(GSTREAMER_STAMP_DIR ${PACKAGE_STAMP_DIR}/${GSTREAMER_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${GSTREAMER_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${GSTREAMER_SITE}
        ${GSTREAMER_FULLNAME}
        ${GSTREAMER_BASE}
        ${GSTREAMER_BASE}
        ""
        ""
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH ./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH make"
        "make check"
        "make install")
else()
    add_custom_target(${GSTREAMER_BASE})
endif()
