project(libxcb)

set(LIBXCB_VERSION 1.12)
set(LIBXCB_REQUIRED_VERSION ${LIBXCB_VERSION})
set(LIBXCB_NAME ${PROJECT_NAME})
set(LIBXCB_BASE ${LIBXCB_NAME}-${LIBXCB_VERSION})

find_package(LibXcb QUIET)

if (NOT LIBXCB_FOUND)
    set(LIBXCB_EXTENSION tar.bz2)
    set(LIBXCB_FULLNAME ${LIBXCB_BASE}.${LIBXCB_EXTENSION})
    set(LIBXCB_SITE http://xcb.freedesktop.org/dist)
    set(LIBXCB_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXCB_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXCB_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXCB_SITE}
        ${LIBXCB_FULLNAME}
        ${LIBXCB_BASE}
        ${LIBXCB_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static --enable-xinput"
        "make"
        "make check"
        "make install")
    add_dependencies(${LIBXCB_BASE} libpthread-stubs-0.4)
else()
    add_custom_target(${LIBXCB_BASE})
endif()
