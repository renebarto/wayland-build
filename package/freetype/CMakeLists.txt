project(freetype)

set(FREETYPE_VERSION 2.7.1)
set(FREETYPE_REQUIRED_VERSION ${FREETYPE_VERSION})
set(FREETYPE_NAME ${PROJECT_NAME})
set(FREETYPE_BASE ${FREETYPE_NAME}-${FREETYPE_VERSION})

find_package(Freetype QUIET)


if (NOT FREETYPE_FOUND)
    set(FREETYPE_EXTENSION tar.bz2)
    set(FREETYPE_FULLNAME ${FREETYPE_BASE}.${FREETYPE_EXTENSION})
    set(FREETYPE_SITE  http://downloads.sourceforge.net/freetype)
    set(FREETYPE_STAMP_DIR ${PACKAGE_STAMP_DIR}/${FREETYPE_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${FREETYPE_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${FREETYPE_SITE}
        ${FREETYPE_FULLNAME}
        ${FREETYPE_BASE}
        ${FREETYPE_BASE}
        "0001-LFS-patch.patch;0002-LFS-patch-subpixel-rendering.patch"
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static")
else()
    add_custom_target(${FREETYPE_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
