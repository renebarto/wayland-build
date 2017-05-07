project(gettext)

set(LIBGETTEXT_VERSION 0.19.8)
set(LIBGETTEXT_REQUIRED_VERSION ${LIBGETTEXT_VERSION})
set(LIBGETTEXT_NAME ${PROJECT_NAME})
set(LIBGETTEXT_BASE ${LIBGETTEXT_NAME}-${LIBGETTEXT_VERSION})

find_package(LibGettext QUIET)

if (NOT LIBGETTEXT_FOUND)
    set(LIBGETTEXT_EXTENSION tar.xz)
    set(LIBGETTEXT_FULLNAME ${LIBGETTEXT_BASE}.${LIBGETTEXT_EXTENSION})
    set(LIBGETTEXT_SITE ftp://ftp.gnu.org/pub/gnu/gettext)
    set(LIBGETTEXT_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBGETTEXT_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBGETTEXT_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBGETTEXT_SITE}
        ${LIBGETTEXT_FULLNAME}
        ${LIBGETTEXT_BASE}
        ${LIBGETTEXT_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} \
            --disable-static \
            --docdir=${CMAKE_INSTALL_PREFIX}/share/doc/gettext-0.19.8.1"
        "make"
        ""
#        "make check" // Fails on locale tests
        "make install")
else()
    add_custom_target(${LIBGETTEXT_BASE})
endif()
