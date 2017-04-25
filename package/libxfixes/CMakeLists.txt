project(libXfixes)

set(LIBXFIXES_VERSION 5.0.3)
set(LIBXFIXES_REQUIRED_VERSION ${LIBXFIXES_VERSION})
set(LIBXFIXES_NAME ${PROJECT_NAME})
set(LIBXFIXES_BASE ${LIBXFIXES_NAME}-${LIBXFIXES_VERSION})

find_package(LibXfixes QUIET)

if (NOT LIBXFIXES_FOUND)
    set(LIBXFIXES_EXTENSION tar.bz2)
    set(LIBXFIXES_FULLNAME ${LIBXFIXES_BASE}.${LIBXFIXES_EXTENSION})
    set(LIBXFIXES_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXFIXES_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXFIXES_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXFIXES_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXFIXES_SITE}
        ${LIBXFIXES_FULLNAME}
        ${LIBXFIXES_BASE}
        ${LIBXFIXES_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static")
    add_dependencies(${LIBXFIXES_BASE}
        libX11-1.6.4)
else()
    add_custom_target(${LIBXFIXES_BASE})
endif()
