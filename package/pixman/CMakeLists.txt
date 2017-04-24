project(pixman)

set(PIXMAN_VERSION 0.34.0)
set(PIXMAN_REQUIRED_VERSION ${PIXMAN_VERSION})
set(PIXMAN_NAME ${PROJECT_NAME})
set(PIXMAN_BASE ${PIXMAN_NAME}-${PIXMAN_VERSION})

find_package(Pixman QUIET)

if (NOT PIXMAN_FOUND)
    set(PIXMAN_EXTENSION tar.gz)
    set(PIXMAN_FULLNAME ${PIXMAN_BASE}.${PIXMAN_EXTENSION})
    set(PIXMAN_SITE http://cairographics.org/releases)
    set(PIXMAN_STAMP_DIR ${PACKAGE_STAMP_DIR}/${PIXMAN_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${PIXMAN_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${PIXMAN_SITE}
        ${PIXMAN_FULLNAME}
        ${PIXMAN_BASE}
        ${PIXMAN_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static")
    add_dependencies(${PIXMAN_BASE} libpng-1.6.29)
else()
    add_custom_target(${PIXMAN_BASE})
endif()
