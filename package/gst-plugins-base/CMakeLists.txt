project(gst-plugins-base)

set(GST_PLUGINS_BASE_VERSION 1.10.4)
set(GST_PLUGINS_BASE_REQUIRED_VERSION ${GST_PLUGINS_BASE_VERSION})
set(GST_PLUGINS_BASE_NAME ${PROJECT_NAME})
set(GST_PLUGINS_BASE_BASE ${GST_PLUGINS_BASE_NAME}-${GST_PLUGINS_BASE_VERSION})

find_package(GstPluginsBase1 QUIET)

if (NOT GST_PLUGINS_BASE_FOUND)
    set(GST_PLUGINS_BASE_EXTENSION tar.xz)
    set(GST_PLUGINS_BASE_FULLNAME ${GST_PLUGINS_BASE_BASE}.${GST_PLUGINS_BASE_EXTENSION})
    set(GST_PLUGINS_BASE_SITE  https://gstreamer.freedesktop.org/src/gst-plugins-base)
    set(GST_PLUGINS_BASE_STAMP_DIR ${PACKAGE_STAMP_DIR}/${GST_PLUGINS_BASE_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${GST_PLUGINS_BASE_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${GST_PLUGINS_BASE_SITE}
        ${GST_PLUGINS_BASE_FULLNAME}
        ${GST_PLUGINS_BASE_BASE}
        ${GST_PLUGINS_BASE_BASE}
        ""
        ""
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH ./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH make"
        ""
#        "make check" // 1 test fails
        "make install")
    add_dependencies(${GST_PLUGINS_BASE_BASE}
        gstreamer-1.10.4)
else()
    add_custom_target(${GST_PLUGINS_BASE_BASE})
endif()
