project(Linux-PAM)

set(LIBPAM_VERSION 1.3.0)
set(LIBPAM_REQUIRED_VERSION ${LIBPAM_VERSION})
set(LIBPAM_NAME ${PROJECT_NAME})
set(LIBPAM_BASE ${LIBPAM_NAME}-${LIBPAM_VERSION})

find_package(LibPAM QUIET)

if (NOT LIBPAM_FOUND)
    set(LIBPAM_EXTENSION tar.bz2)
    set(LIBPAM_FULLNAME ${LIBPAM_BASE}.${LIBPAM_EXTENSION})
    set(LIBPAM_SITE http://linux-pam.org/library)
    set(LIBPAM_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBPAM_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBPAM_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBPAM_SITE}
        ${LIBPAM_FULLNAME}
        ${LIBPAM_BASE}
        ${LIBPAM_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --includedir=${CMAKE_INSTALL_PREFIX}/include/security \
            --libdir=${CMAKE_INSTALL_PREFIX}/lib                \
            --disable-regenerate-docu        \
            --enable-securedir=${CMAKE_SYSROOT}/lib/security \
            --docdir=${CMAKE_INSTALL_PREFIX}/share/doc/Linux-PAM-1.3.0"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${LIBPAM_BASE})
endif()
