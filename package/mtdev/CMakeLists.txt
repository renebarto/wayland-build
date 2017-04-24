project(mtdev)

set(MTDEV_VERSION 1.1.5)
set(MTDEV_REQUIRED_VERSION ${MTDEV_VERSION})
set(MTDEV_NAME ${PROJECT_NAME})
set(MTDEV_BASE ${MTDEV_NAME}-${MTDEV_VERSION})

find_package(Mtdev QUIET)

if (NOT MTDEV_FOUND)
    set(MTDEV_EXTENSION tar.bz2)
    set(MTDEV_FULLNAME ${MTDEV_BASE}.${MTDEV_EXTENSION})
    set(MTDEV_SITE http://bitmath.org/code/mtdev)
    set(MTDEV_STAMP_DIR ${PACKAGE_STAMP_DIR}/${MTDEV_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${MTDEV_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${MTDEV_SITE}
        ${MTDEV_FULLNAME}
        ${MTDEV_BASE}
        ${MTDEV_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static")
else()
    add_custom_target(${MTDEV_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
