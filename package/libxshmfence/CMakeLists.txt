project(libxshmfence)

set(LIBXSHMFENCE_VERSION 1.2)
set(LIBXSHMFENCE_REQUIRED_VERSION ${LIBXSHMFENCE_VERSION})
set(LIBXSHMFENCE_NAME ${PROJECT_NAME})
set(LIBXSHMFENCE_BASE ${LIBXSHMFENCE_NAME}-${LIBXSHMFENCE_VERSION})

find_package(LibXshmfence QUIET)

if (NOT LIBXSHMFENCE_FOUND)
    set(LIBXSHMFENCE_EXTENSION tar.bz2)
    set(LIBXSHMFENCE_FULLNAME ${LIBXSHMFENCE_BASE}.${LIBXSHMFENCE_EXTENSION})
    set(LIBXSHMFENCE_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXSHMFENCE_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXSHMFENCE_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXSHMFENCE_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXSHMFENCE_SITE}
        ${LIBXSHMFENCE_FULLNAME}
        ${LIBXSHMFENCE_BASE}
        ${LIBXSHMFENCE_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static"
        "make"
        "make check"
        "make install")
    add_dependencies(${LIBXSHMFENCE_BASE}
        libX11-1.6.4)
else()
    add_custom_target(${LIBXSHMFENCE_BASE})
endif()
