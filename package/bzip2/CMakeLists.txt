project(bzip2)

set(BZIP2_VERSION 1.0.6)
set(BZIP2_REQUIRED_VERSION ${BZIP2_VERSION})
set(BZIP2_NAME ${PROJECT_NAME})
set(BZIP2_BASE ${BZIP2_NAME}-${BZIP2_VERSION})

find_package(BZip2 QUIET)

if (NOT BZIP2_FOUND)
    set(BZIP2_EXTENSION tar.gz)
    set(BZIP2_FULLNAME ${BZIP2_BASE}.${BZIP2_EXTENSION})
    set(BZIP2_SITE http://www.bzip.org/1.0.6)
    set(BZIP2_STAMP_DIR ${PACKAGE_STAMP_DIR}/${BZIP2_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${BZIP2_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${BZIP2_SITE}
        ${BZIP2_FULLNAME}
        ${BZIP2_BASE}
        ${BZIP2_BASE}
        ""
        ""
        ""
        "make"
        "make check"
        "make PREFIX=${CMAKE_INSTALL_PREFIX} install")
else()
    add_custom_target(${BZIP2_BASE})
endif()
