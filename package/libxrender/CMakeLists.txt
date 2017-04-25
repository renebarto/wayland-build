project(libXrender)

set(LIBXRENDER_VERSION 0.9.10)
set(LIBXRENDER_REQUIRED_VERSION ${LIBXRENDER_VERSION})
set(LIBXRENDER_NAME ${PROJECT_NAME})
set(LIBXRENDER_BASE ${LIBXRENDER_NAME}-${LIBXRENDER_VERSION})

find_package(LibXrender QUIET)

if (NOT LIBXRENDER_FOUND)
    set(LIBXRENDER_EXTENSION tar.bz2)
    set(LIBXRENDER_FULLNAME ${LIBXRENDER_BASE}.${LIBXRENDER_EXTENSION})
    set(LIBXRENDER_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXRENDER_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXRENDER_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXRENDER_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXRENDER_SITE}
        ${LIBXRENDER_FULLNAME}
        ${LIBXRENDER_BASE}
        ${LIBXRENDER_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static")
else()
    add_custom_target(${LIBXRENDER_BASE})
endif()
