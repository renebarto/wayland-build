project(fontconfig)

set(FONTCONFIG_VERSION 2.12.1)
set(FONTCONFIG_REQUIRED_VERSION ${FONTCONFIG_VERSION})
set(FONTCONFIG_NAME ${PROJECT_NAME})
set(FONTCONFIG_BASE ${FONTCONFIG_NAME}-${FONTCONFIG_VERSION})

find_package(Fontconfig QUIET)


if (NOT FONTCONFIG_FOUND)
    set(FONTCONFIG_EXTENSION tar.bz2)
    set(FONTCONFIG_FULLNAME ${FONTCONFIG_BASE}.${FONTCONFIG_EXTENSION})
    set(FONTCONFIG_SITE http://www.freedesktop.org/software/fontconfig/release)
    set(FONTCONFIG_STAMP_DIR ${PACKAGE_STAMP_DIR}/${FONTCONFIG_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${FONTCONFIG_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${FONTCONFIG_SITE}
        ${FONTCONFIG_FULLNAME}
        ${FONTCONFIG_BASE}
        ${FONTCONFIG_BASE}
        "0001-CHAR_WIDTH.patch;0002-redefine-CHAR_WIDTH.patch"
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} \
            --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var \
            --disable-docs \
            --docdir=${CMAKE_INSTALL_PREFIX}/share/doc/fontconfig-2.12.1")
    add_dependencies(${FONTCONFIG_BASE} freetype-2.7.1 expat-2.2.0)
else()
    add_custom_target(${FONTCONFIG_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
