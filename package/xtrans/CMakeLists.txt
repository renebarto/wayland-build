project(xtrans)

set(XTRANS_VERSION 1.3.5)
set(XTRANS_REQUIRED_VERSION ${XTRANS_VERSION})
set(XTRANS_NAME ${PROJECT_NAME})
set(XTRANS_BASE ${XTRANS_NAME}-${XTRANS_VERSION})

find_package(Xtrans QUIET)

if (NOT XTRANS_FOUND)
    set(XTRANS_EXTENSION tar.bz2)
    set(XTRANS_FULLNAME ${XTRANS_BASE}.${XTRANS_EXTENSION})
    set(XTRANS_SITE ftp://ftp.x.org/pub/individual/lib)
    set(XTRANS_STAMP_DIR ${PACKAGE_STAMP_DIR}/${XTRANS_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${XTRANS_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${XTRANS_SITE}
        ${XTRANS_FULLNAME}
        ${XTRANS_BASE}
        ${XTRANS_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${XTRANS_BASE})
endif()
