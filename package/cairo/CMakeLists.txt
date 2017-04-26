project(cairo)

set(CAIRO_VERSION 1.14.8)
set(CAIRO_NAME ${PROJECT_NAME})
set(CAIRO_BASE ${CAIRO_NAME}-${CAIRO_VERSION})
set(CAIRO_REQUIRED_VERSION ${CAIRO_VERSION})

find_package(Cairo QUIET)

if (NOT CAIRO_FOUND)
    set(CAIRO_EXTENSION tar.xz)
    set(CAIRO_FULLNAME ${CAIRO_BASE}.${CAIRO_EXTENSION})
    set(CAIRO_SITE http://cairographics.org/releases)
    set(CAIRO_STAMP_DIR ${PACKAGE_STAMP_DIR}/${CAIRO_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${CAIRO_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CAIRO_SITE}
        ${CAIRO_FULLNAME}
        ${CAIRO_BASE}
        ${CAIRO_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static \
            --enable-trace=no \
            --enable-interpreter=no \
            --disable-directfb \
            --enable-tee \
            --enable-ft \
            --disable-xlib --enable-xcb --without-x \
            --disable-xlib-xrender \
            --disable-gl --enable-glesv2 \
            --disable-vg \
            --enable-ps \
            --enable-pdf \
            --enable-png \
            --enable-svg \
            --enable-xml \
            --disable-drm")
    add_dependencies(${CAIRO_BASE} libpng-1.6.29 pixman-0.34.0 fontconfig-2.12.1 libdrm-2.4.78)
else()
    add_custom_target(${CAIRO_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
