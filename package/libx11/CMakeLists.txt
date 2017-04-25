project(libX11)

set(LIBX11_VERSION 1.6.4)
set(LIBX11_REQUIRED_VERSION ${LIBX11_VERSION})
set(LIBX11_NAME ${PROJECT_NAME})
set(LIBX11_BASE ${LIBX11_NAME}-${LIBX11_VERSION})

find_package(LibX11 QUIET)

if (NOT LIBX11_FOUND)
    set(LIBX11_EXTENSION tar.bz2)
    set(LIBX11_FULLNAME ${LIBX11_BASE}.${LIBX11_EXTENSION})
    set(LIBX11_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBX11_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBX11_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBX11_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBX11_SITE}
        ${LIBX11_FULLNAME}
        ${LIBX11_BASE}
        ${LIBX11_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static")
#    add_dependencies(${LIBX11_BASE})
else()
    add_custom_target(${LIBX11_BASE})
endif()
