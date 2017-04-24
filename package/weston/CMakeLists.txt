project(weston)

set(WESTON_VERSION 1.12.0)
set(WESTON_REQUIRED_VERSION ${WESTON_VERSION})
set(WESTON_NAME ${PROJECT_NAME})
set(WESTON_BASE ${WESTON_NAME}-${WESTON_VERSION})

#find_package(Wayland QUIET)

set(WESTON_FOUND FALSE)

if (NOT WESTON_FOUND)
    set(WESTON_EXTENSION tar.xz)
    set(WESTON_FULLNAME ${WESTON_BASE}.${WESTON_EXTENSION})
    set(WESTON_SITE http://wayland.freedesktop.org/releases)
    set(WESTON_STAMP_DIR ${PACKAGE_STAMP_DIR}/${WESTON_BASE})
#    setup_package_automake(
#        ${PACKAGE_DOWNLOAD_DIR}
#        ${PACKAGE_BUILD_DIR}
#        ${PACKAGE_STAGING_DIR}
#        ${WESTON_STAMP_DIR}
#        ${CMAKE_CURRENT_SOURCE_DIR}
#        ${WESTON_SITE}
#        ${WESTON_FULLNAME}
#        ${WESTON_BASE}
#        ${WESTON_BASE}
#        ""
#        ""
#        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-demo-clients-install")
    #    add_custom_target(install_doc
    #        DEPENDS ${WESTON_BASE}_COMPLETE
    #        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/share/doc/${WESTON_BASE}
    #        COMMAND ${CMAKE_COMMAND} -E copy
    #            ${PACKAGE_BUILD_DIR}/${WESTON_BASE}/doc/reference.html
    #            ${PACKAGE_BUILD_DIR}/${WESTON_BASE}/doc/expat.png
    #            ${PACKAGE_BUILD_DIR}/${WESTON_BASE}/doc/valid-xhtml10.png
    #            ${PACKAGE_BUILD_DIR}/${WESTON_BASE}/doc/style.css
    #            ${CMAKE_INSTALL_PREFIX}/share/doc/${WESTON_BASE}
    #        COMMENT "Copy html"
    #        VERBATIM)
    add_custom_target(${WESTON_BASE})
    add_dependencies(${WESTON_BASE} wayland-1.13.0 wayland-protocols-1.7 libevdev-1.5.6 libxkbcommon-0.7.1)
else()
    add_custom_target(${WESTON_BASE})
endif()