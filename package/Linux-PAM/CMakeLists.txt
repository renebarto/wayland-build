project(Linux-PAM)

set(LINUX_PAM_VERSION 1.3.0)
set(LINUX_PAM_REQUIRED_VERSION ${LINUX_PAM_VERSION})
set(LINUX_PAM_NAME ${PROJECT_NAME})
set(LINUX_PAM_BASE ${LINUX_PAM_NAME}-${LINUX_PAM_VERSION})

find_package(Linux-PAM QUIET)

if (NOT LINUX_PAM_FOUND)
    set(LINUX_PAM_EXTENSION tar.bz2)
    set(LINUX_PAM_FULLNAME ${LINUX_PAM_BASE}.${LINUX_PAM_EXTENSION})
    set(LINUX_PAM_SITE http://linux-pam.org/library)
    set(LINUX_PAM_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LINUX_PAM_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LINUX_PAM_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LINUX_PAM_SITE}
        ${LINUX_PAM_FULLNAME}
        ${LINUX_PAM_BASE}
        ${LINUX_PAM_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} \
            --sysconfdir=${CMAKE_SYSROOT}/etc \
            --libdir=${CMAKE_INSTALL_PREFIX}/lib\
            --disable-regenerate-docu \
            --enable-securedir=${CMAKE_SYSROOT}/lib/security \
            --docdir=${CMAKE_INSTALL_PREFIX}/share/doc/Linux-PAM-1.3.0")
else()
    add_custom_target(${LINUX_PAM_BASE})
endif()
