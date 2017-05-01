project(libXau)

set(LIBXAU_VERSION 1.0.8)
set(LIBXAU_REQUIRED_VERSION ${LIBXAU_VERSION})
set(LIBXAU_NAME ${PROJECT_NAME})
set(LIBXAU_BASE ${LIBXAU_NAME}-${LIBXAU_VERSION})

find_package(LibXau QUIET)

if (NOT LIBXAU_FOUND)
    set(LIBXAU_EXTENSION tar.bz2)
    set(LIBXAU_FULLNAME ${LIBXAU_BASE}.${LIBXAU_EXTENSION})
    set(LIBXAU_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXAU_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXAU_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXAU_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXAU_SITE}
        ${LIBXAU_FULLNAME}
        ${LIBXAU_BASE}
        ${LIBXAU_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${LIBXAU_BASE})
endif()
