project(libXdamage)

set(LIBXDAMAGE_VERSION 1.1.4)
set(LIBXDAMAGE_REQUIRED_VERSION ${LIBXDAMAGE_VERSION})
set(LIBXDAMAGE_NAME ${PROJECT_NAME})
set(LIBXDAMAGE_BASE ${LIBXDAMAGE_NAME}-${LIBXDAMAGE_VERSION})

find_package(LibXdamage QUIET)

if (NOT LIBXDAMAGE_FOUND)
    set(LIBXDAMAGE_EXTENSION tar.bz2)
    set(LIBXDAMAGE_FULLNAME ${LIBXDAMAGE_BASE}.${LIBXDAMAGE_EXTENSION})
    set(LIBXDAMAGE_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXDAMAGE_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXDAMAGE_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXDAMAGE_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXDAMAGE_SITE}
        ${LIBXDAMAGE_FULLNAME}
        ${LIBXDAMAGE_BASE}
        ${LIBXDAMAGE_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static"
        "make"
        "make check"
        "make install")
    add_dependencies(${LIBXDAMAGE_BASE}
        libX11-1.6.4
        libXfixes-5.0.3)
else()
    add_custom_target(${LIBXDAMAGE_BASE})
endif()
