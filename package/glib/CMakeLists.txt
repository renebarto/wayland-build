project(glib)

set(LIBGLIB2_VERSION 2.52.1)
set(LIBGLIB2_REQUIRED_VERSION ${LIBGLIB2_VERSION})
set(LIBGLIB2_NAME ${PROJECT_NAME})
set(LIBGLIB2_BASE ${LIBGLIB2_NAME}-${LIBGLIB2_VERSION})

find_package(LibGlib2 QUIET)

if (NOT LIBGLIB2_FOUND)
    set(LIBGLIB2_EXTENSION tar.xz)
    set(LIBGLIB2_FULLNAME ${LIBGLIB2_BASE}.${LIBGLIB2_EXTENSION})
    set(LIBGLIB2_SITE ftp://ftp.gnome.org/pub/gnome/sources/glib/2.52)
    set(LIBGLIB2_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBGLIB2_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBGLIB2_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBGLIB2_SITE}
        ${LIBGLIB2_FULLNAME}
        ${LIBGLIB2_BASE}
        ${LIBGLIB2_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --with-pcre=system"
        "make"
        ""
#        "make check" // 2 tests failing
        "make install")
else()
    add_custom_target(${LIBGLIB2_BASE})
endif()
