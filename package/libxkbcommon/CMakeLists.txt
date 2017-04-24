project(libxkbcommon)

set(LIBXKBCOMMON_VERSION 0.7.1)
set(LIBXKBCOMMON_REQUIRED_VERSION ${LIBXKBCOMMON_VERSION})
set(LIBXKBCOMMON_NAME ${PROJECT_NAME})
set(LIBXKBCOMMON_BASE ${LIBXKBCOMMON_NAME}-${LIBXKBCOMMON_VERSION})

find_package(LibXKBCommon QUIET)

if (NOT LIBXKBCOMMON_FOUND)
    set(LIBXKBCOMMON_EXTENSION tar.xz)
    set(LIBXKBCOMMON_FULLNAME ${LIBXKBCOMMON_BASE}.${LIBXKBCOMMON_EXTENSION})
    set(LIBXKBCOMMON_SITE http://xkbcommon.org/download)
    set(LIBXKBCOMMON_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBXKBCOMMON_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBXKBCOMMON_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBXKBCOMMON_SITE}
        ${LIBXKBCOMMON_FULLNAME}
        ${LIBXKBCOMMON_BASE}
        ${LIBXKBCOMMON_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static -disable-x11 --docdir=${CMAKE_INSTALL_PREFIX}/usr/share/doc/libxkbcommon-0.7.1")
else()
    add_custom_target(${LIBXKBCOMMON_BASE})
endif()
