project(libXcursor)

set(LIBXCURSOR_VERSION 1.1.14)
set(LIBXCURSOR_REQUIRED_VERSION ${LIBXCURSOR_VERSION})
set(LIBXCURSOR_NAME ${PROJECT_NAME})
set(LIBXCURSOR_BASE ${LIBXCURSOR_NAME}-${LIBXCURSOR_VERSION})

find_package(LibXcursor QUIET)

if (NOT LIBXCURSOR_FOUND)
    set(LIBXCURSOR_EXTENSION tar.bz2)
    set(LIBXCURSOR_FULLNAME ${LIBXCURSOR_BASE}.${LIBXCURSOR_EXTENSION})
    set(LIBXCURSOR_SITE ftp://ftp.x.org/pub/individual/lib)
    set(LIBXCURSOR_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXCURSOR_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXCURSOR_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXCURSOR_SITE}
        ${LIBXCURSOR_FULLNAME}
        ${LIBXCURSOR_BASE}
        ${LIBXCURSOR_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static")
    add_dependencies(${LIBXCURSOR_BASE}
        libXrender-0.9.10)
else()
    add_custom_target(${LIBXCURSOR_BASE})
endif()
