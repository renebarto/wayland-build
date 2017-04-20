project(wayland)

include(utilities)
find_package(Wayland QUIET)

#set(EXPAT_FOUND FALSE)

set(MODULE ${PROJECT_NAME})
set(VERSION 1.13.0)
set(BASE ${MODULE}-${VERSION})

if (NOT WAYLAND_FOUND)
    set(EXTENSION tar.xz)
    set(FULLNAME ${BASE}.${EXTENSION})
    set(SITE http://wayland.freedesktop.org/releases)
    set(DOWNLOAD_DIR ${PACKAGE_DOWNLOAD_DIR})
    set(STAMP_DIR ${PACKAGE_STAMP_DIR}/${BASE})
#    setup_package_automake(
#        ${DOWNLOAD_DIR}
#        ${PACKAGE_BUILD_DIR}
#        ${PACKAGE_STAGING_DIR}
#        ${STAMP_DIR}
#        ${CMAKE_CURRENT_SOURCE_DIR}
#        ${SITE}
#        ${FULLNAME}
#        ${MODULE}
#        ${BASE}
#        ""
#        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static")
    #    add_custom_target(install_doc
    #        DEPENDS ${BASE}_COMPLETE
    #        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/share/doc/${BASE}
    #        COMMAND ${CMAKE_COMMAND} -E copy
    #            ${PACKAGE_BUILD_DIR}/${BASE}/doc/reference.html
    #            ${PACKAGE_BUILD_DIR}/${BASE}/doc/expat.png
    #            ${PACKAGE_BUILD_DIR}/${BASE}/doc/valid-xhtml10.png
    #            ${PACKAGE_BUILD_DIR}/${BASE}/doc/style.css
    #            ${CMAKE_INSTALL_PREFIX}/share/doc/${BASE}
    #        COMMENT "Copy html"
    #        VERBATIM)
    #    add_dependencies(${BASE} install_doc)
else()
    add_custom_target(${BASE})
endif()