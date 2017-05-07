project(gst-plugins-bad)

set(GST_PLUGINS_BAD_VERSION 1.10.4)
set(GST_PLUGINS_BAD_REQUIRED_VERSION ${GST_PLUGINS_BAD_VERSION})
set(GST_PLUGINS_BAD_NAME ${PROJECT_NAME})
set(GST_PLUGINS_BAD_BAD ${GST_PLUGINS_BAD_NAME}-${GST_PLUGINS_BAD_VERSION})

find_package(GstPluginsBad1 QUIET)

if (NOT GST_PLUGINS_BAD_FOUND)
    set(GST_PLUGINS_BAD_EXTENSION tar.xz)
    set(GST_PLUGINS_BAD_FULLNAME ${GST_PLUGINS_BAD_BAD}.${GST_PLUGINS_BAD_EXTENSION})
    set(GST_PLUGINS_BAD_SITE  https://gstreamer.freedesktop.org/src/gst-plugins-bad)
    set(GST_PLUGINS_BAD_STAMP_DIR ${PACKAGE_STAMP_DIR}/${GST_PLUGINS_BAD_BAD})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${GST_PLUGINS_BAD_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${GST_PLUGINS_BAD_SITE}
        ${GST_PLUGINS_BAD_FULLNAME}
        ${GST_PLUGINS_BAD_BAD}
        ${GST_PLUGINS_BAD_BAD}
        ""
        ""
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH ./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH make"
        ""
#        "make check" // Tests for GL fail
        "make install")
    add_dependencies(${GST_PLUGINS_BAD_BAD}
        gstreamer-1.10.4)
else()
    add_custom_target(${GST_PLUGINS_BAD_BAD})
endif()
