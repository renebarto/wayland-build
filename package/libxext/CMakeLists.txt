project(libXext)

set(LIBXEXT_VERSION 1.3.3)
set(LIBXEXT_REQUIRED_VERSION ${LIBXEXT_VERSION})
set(LIBXEXT_NAME ${PROJECT_NAME})
set(LIBXEXT_BASE ${LIBXEXT_NAME}-${LIBXEXT_VERSION})

find_package(LibXext QUIET)

if (NOT LIBXEXT_FOUND)
    set(LIBXEXT_EXTENSION tar.bz2)
    set(LIBXEXT_FULLNAME ${LIBXEXT_BASE}.${LIBXEXT_EXTENSION})
    set(LIBXEXT_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXEXT_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXEXT_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXEXT_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXEXT_SITE}
        ${LIBXEXT_FULLNAME}
        ${LIBXEXT_BASE}
        ${LIBXEXT_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static"
        "make"
        "make check"
        "make install")
    add_dependencies(${LIBXEXT_BASE}
        libX11-1.6.4)
else()
    add_custom_target(${LIBXEXT_BASE})
endif()
