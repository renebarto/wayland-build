project(libXdmcp)

set(LIBXDMCP_VERSION 1.1.2)
set(LIBXDMCP_REQUIRED_VERSION ${LIBXDMCP_VERSION})
set(LIBXDMCP_NAME ${PROJECT_NAME})
set(LIBXDMCP_BASE ${LIBXDMCP_NAME}-${LIBXDMCP_VERSION})

find_package(LibXdmcp QUIET)

if (NOT LIBXDMCP_FOUND)
    set(LIBXDMCP_EXTENSION tar.bz2)
    set(LIBXDMCP_FULLNAME ${LIBXDMCP_BASE}.${LIBXDMCP_EXTENSION})
    set(LIBXDMCP_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXDMCP_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXDMCP_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXDMCP_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXDMCP_SITE}
        ${LIBXDMCP_FULLNAME}
        ${LIBXDMCP_BASE}
        ${LIBXDMCP_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${LIBXDMCP_BASE})
endif()
