project(gperf)

set(GPERF_VERSION 3.0.4)
#set(GPERF_REQUIRED_VERSION ${GPERF_VERSION})
set(GPERF_NAME ${PROJECT_NAME})
set(GPERF_BASE ${GPERF_NAME}-${GPERF_VERSION})

find_package(Gperf QUIET)

if (NOT GPERF_FOUND)
    set(GPERF_EXTENSION tar.gz)
    set(GPERF_FULLNAME ${GPERF_BASE}.${GPERF_EXTENSION})
    set(GPERF_SITE ftp://ftp.gnu.org/gnu/gperf)
    set(GPERF_STAMP_DIR ${PACKAGE_STAMP_DIR}/${GPERF_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${GPERF_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${GPERF_SITE}
        ${GPERF_FULLNAME}
        ${GPERF_BASE}
        ${GPERF_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --docdir=${CMAKE_INSTALL_PREFIX}/share/doc/gperf-3.0.4"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${GPERF_BASE})
endif()
