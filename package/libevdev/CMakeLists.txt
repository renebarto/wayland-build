project(libevdev)

set(LIBEVDEV_VERSION 1.5.6)
set(LIBEVDEV_REQUIRED_VERSION ${LIBEVDEV_VERSION})
set(LIBEVDEV_NAME ${PROJECT_NAME})
set(LIBEVDEV_BASE ${LIBEVDEV_NAME}-${LIBEVDEV_VERSION})

find_package(LibEvdev QUIET)

if (NOT LIBEVDEV_FOUND)
    set(LIBEVDEV_EXTENSION tar.xz)
    set(LIBEVDEV_FULLNAME ${LIBEVDEV_BASE}.${LIBEVDEV_EXTENSION})
    set(LIBEVDEV_SITE http://www.freedesktop.org/software/libevdev)
    set(LIBEVDEV_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBEVDEV_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBEVDEV_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBEVDEV_SITE}
        ${LIBEVDEV_FULLNAME}
        ${LIBEVDEV_BASE}
        ${LIBEVDEV_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${LIBEVDEV_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
