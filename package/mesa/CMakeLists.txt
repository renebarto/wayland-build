project(mesa)

set(MESA_VERSION 17.0.4)
set(MESA_REQUIRED_VERSION ${MESA_VERSION})
set(MESA_NAME ${PROJECT_NAME})
set(MESA_BASE ${MESA_NAME}-${MESA_VERSION})

find_package(Mesa QUIET)

if (MESA_GL_FOUND AND MESA_GLESV1_FOUND AND MESA_GLESV2_FOUND AND
    MESA_DRI_FOUND AND MESA_GBM_FOUND AND
    MESA_EGL_FOUND AND MESA_WAYLAND_EGL_FOUND)
    set(MESA_FOUND TRUE)
else()
    set(MESA_FOUND FALSE)
endif()

if (NOT MESA_FOUND)
    set(MESA_EXTENSION tar.xz)
    set(MESA_FULLNAME ${MESA_BASE}.${MESA_EXTENSION})
    set(MESA_SITE ftp://ftp.freedesktop.org/pub/mesa)
    set(MESA_STAMP_DIR ${PACKAGE_STAMP_DIR}/${MESA_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${MESA_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${MESA_SITE}
        ${MESA_FULLNAME}
        ${MESA_BASE}
        ${MESA_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} \
            --with-gallium-drivers=swrast,r600,svga \
            --enable-gles2 \
            --with-egl-platforms=x11,wayland,drm \
            --enable-gbm \
            --enable-shared-glapi")
else()
    add_custom_target(${MESA_BASE})
endif()
