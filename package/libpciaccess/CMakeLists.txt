project(libpciaccess)

set(LIBPCIACCESS_VERSION 0.13.4)
set(LIBPCIACCESS_REQUIRED_VERSION ${LIBPCIACCESS_VERSION})
set(LIBPCIACCESS_NAME ${PROJECT_NAME})
set(LIBPCIACCESS_BASE ${LIBPCIACCESS_NAME}-${LIBPCIACCESS_VERSION})

find_package(LibPCIAccess QUIET)

if (NOT LIBPCIACCESS_FOUND)
    set(LIBPCIACCESS_EXTENSION tar.bz2)
    set(LIBPCIACCESS_FULLNAME ${LIBPCIACCESS_BASE}.${LIBPCIACCESS_EXTENSION})
    set(LIBPCIACCESS_SITE ftp://ftp.x.org/pub/individual/lib/)
    set(LIBPCIACCESS_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBPCIACCESS_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBPCIACCESS_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBPCIACCESS_SITE}
        ${LIBPCIACCESS_FULLNAME}
        ${LIBPCIACCESS_BASE}
        ${LIBPCIACCESS_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static")
else()
    add_custom_target(${LIBPCIACCESS_BASE})
endif()
