project(libdrm)

set(LIBDRM_VERSION 2.4.78)
set(LIBDRM_REQUIRED_VERSION ${LIBDRM_VERSION})
set(LIBDRM_NAME ${PROJECT_NAME})
set(LIBDRM_BASE ${LIBDRM_NAME}-${LIBDRM_VERSION})

find_package(LibDRM QUIET)

if (NOT LIBDRM_FOUND)
    set(LIBDRM_EXTENSION tar.bz2)
    set(LIBDRM_FULLNAME ${LIBDRM_BASE}.${LIBDRM_EXTENSION})
    set(LIBDRM_SITE http://dri.freedesktop.org/libdrm)
    set(LIBDRM_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBDRM_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBDRM_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBDRM_SITE}
        ${LIBDRM_FULLNAME}
        ${LIBDRM_BASE}
        ${LIBDRM_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-udev --disable-static"
        "make"
        "make check"
        "make install")
    add_dependencies(${LIBDRM_BASE}
        libpciaccess-0.13.4)
else()
    add_custom_target(${LIBDRM_BASE})
endif()
