project(eudev)

set(EUDEV_VERSION 3.2.1)
set(EUDEV_REQUIRED_VERSION 220)
set(EUDEV_NAME ${PROJECT_NAME})
set(EUDEV_BASE ${EUDEV_NAME}-${EUDEV_VERSION})

find_package(Eudev QUIET)

if (NOT EUDEV_FOUND)
    set(EUDEV_EXTENSION tar.gz)
    set(EUDEV_FULLNAME ${EUDEV_BASE}.${EUDEV_EXTENSION})
    set(EUDEV_SITE http://dev.gentoo.org/~blueness/eudev)
    set(EUDEV_STAMP_DIR ${PACKAGE_STAMP_DIR}/${EUDEV_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${EUDEV_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${EUDEV_SITE}
        ${EUDEV_FULLNAME}
        ${EUDEV_BASE}
        ${EUDEV_BASE}
        ""
        ""
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH ./configure --prefix=${CMAKE_INSTALL_PREFIX} \
            --bindir=${CMAKE_SYSROOT}/sbin            \
            --sbindir=${CMAKE_SYSROOT}/sbin           \
            --libdir=${CMAKE_INSTALL_PREFIX}/lib      \
            --sysconfdir=${CMAKE_SYSROOT}/etc         \
            --libexecdir=${CMAKE_SYSROOT}/lib         \
            --with-rootprefix=${CMAKE_SYSROOT}        \
            --with-rootlibdir=${CMAKE_SYSROOT}/lib    \
            --enable-manpages                         \
            --disable-static                          \
            --config-cache"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${EUDEV_BASE})
endif()
