project(libxml2)

set(LIBXML2_VERSION 2.9.4)
set(LIBXML2_REQUIRED_VERSION ${LIBXML2_VERSION})
set(LIBXML2_NAME ${PROJECT_NAME})
set(LIBXML2_BASE ${LIBXML2_NAME}-${LIBXML2_VERSION})

find_package(LibXml2 QUIET)

if (NOT LIBXML2_FOUND)
    set(LIBXML2_EXTENSION tar.gz)
    set(LIBXML2_FULLNAME ${LIBXML2_BASE}.${LIBXML2_EXTENSION})
    set(LIBXML2_SITE ftp://xmlsoft.org/libxml2)
    set(LIBXML2_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXML2_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXML2_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXML2_SITE}
        ${LIBXML2_FULLNAME}
        ${LIBXML2_BASE}
        ${LIBXML2_BASE}
        "0001-Fix-XPointer-paths-beginning-with-range-to.patch;0002-Disallow-namespace-nodes-in-XPointer-ranges.patch"
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} \
            --disable-static \
            --with-history \
            --with-gnu-ld \
            --without-python \
            --without-debug \
            --without-zlib \
            --without-lzma \
            --without-iconv"
        "make"
#        "make check" // No checking for now
        ""
        "make install")
else()
    add_custom_target(${LIBXML2_BASE})
endif()
