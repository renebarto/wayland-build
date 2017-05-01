project(zlib)

set(ZLIB_VERSION 1.2.11)
set(ZLIB_REQUIRED_VERSION ${ZLIB_VERSION})
set(ZLIB_NAME ${PROJECT_NAME})
set(ZLIB_BASE ${ZLIB_NAME}-${ZLIB_VERSION})

find_package(ZLib QUIET)

if (NOT ZLIB_FOUND)
    set(ZLIB_EXTENSION tar.gz)
    set(ZLIB_FULLNAME ${ZLIB_BASE}.${ZLIB_EXTENSION})
    set(ZLIB_SITE http://zlib.net)
    set(ZLIB_STAMP_DIR ${PACKAGE_STAMP_DIR}/${ZLIB_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${ZLIB_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${ZLIB_SITE}
        ${ZLIB_FULLNAME}
        ${ZLIB_BASE}
        ${ZLIB_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${ZLIB_BASE})
endif()
