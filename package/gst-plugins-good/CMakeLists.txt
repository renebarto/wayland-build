project(gst-plugins-good)

set(GST_PLUGINS_GOOD_VERSION 1.10.4)
set(GST_PLUGINS_GOOD_REQUIRED_VERSION ${GST_PLUGINS_GOOD_VERSION})
set(GST_PLUGINS_GOOD_NAME ${PROJECT_NAME})
set(GST_PLUGINS_GOOD_GOOD ${GST_PLUGINS_GOOD_NAME}-${GST_PLUGINS_GOOD_VERSION})

find_package(GstPluginsGood1 QUIET)

if (NOT GST_PLUGINS_GOOD_FOUND)
    set(GST_PLUGINS_GOOD_EXTENSION tar.xz)
    set(GST_PLUGINS_GOOD_FULLNAME ${GST_PLUGINS_GOOD_GOOD}.${GST_PLUGINS_GOOD_EXTENSION})
    set(GST_PLUGINS_GOOD_SITE  https://gstreamer.freedesktop.org/src/gst-plugins-good)
    set(GST_PLUGINS_GOOD_STAMP_DIR ${PACKAGE_STAMP_DIR}/${GST_PLUGINS_GOOD_GOOD})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${GST_PLUGINS_GOOD_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${GST_PLUGINS_GOOD_SITE}
        ${GST_PLUGINS_GOOD_FULLNAME}
        ${GST_PLUGINS_GOOD_GOOD}
        ${GST_PLUGINS_GOOD_GOOD}
        ""
        ""
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH ./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "PATH=${CMAKE_INSTALL_PREFIX}/bin:$PATH make"
        "make check"
        "make install")
    add_dependencies(${GST_PLUGINS_GOOD_GOOD}
        gstreamer-1.10.4)
else()
    add_custom_target(${GST_PLUGINS_GOOD_GOOD})
endif()
