project(libjpeg-turbo)

set(LIBJPEGTURBO_VERSION 1.5.1)
set(LIBJPEGTURBO_REQUIRED_VERSION ${LIBJPEGTURBO_VERSION})
set(LIBJPEGTURBO_NAME ${PROJECT_NAME})
set(LIBJPEGTURBO_BASE ${LIBJPEGTURBO_NAME}-${LIBJPEGTURBO_VERSION})

find_package(LibJPEGTurbo QUIET)
set(NASM_REQUIRED_VERSION 2.11.08)
find_package(Nasm REQUIRED)

if (NOT LIBJPEGTURBO_FOUND)
    set(LIBJPEGTURBO_EXTENSION tar.gz)
    set(LIBJPEGTURBO_FULLNAME ${LIBJPEGTURBO_BASE}.${LIBJPEGTURBO_EXTENSION})
    set(LIBJPEGTURBO_SITE http://downloads.sourceforge.net/libjpeg-turbo)
    set(LIBJPEGTURBO_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBJPEGTURBO_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBJPEGTURBO_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBJPEGTURBO_SITE}
        ${LIBJPEGTURBO_FULLNAME}
        ${LIBJPEGTURBO_BASE}
        ${LIBJPEGTURBO_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static \
            --mandir=${CMAKE_INSTALL_PREFIX}/usr/share/man \
            --with-jpeg8            \
            --docdir=${CMAKE_INSTALL_PREFIX}/usr/share/doc/libjpeg-turbo-1.5.1")
else()
    add_custom_target(${LIBJPEGTURBO_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
