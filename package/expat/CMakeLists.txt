project(expat)

set(EXPAT_VERSION 2.2.0)
set(EXPAT_REQUIRED_VERSION ${EXPAT_VERSION})
set(EXPAT_NAME ${PROJECT_NAME})
set(EXPAT_BASE ${EXPAT_NAME}-${EXPAT_VERSION})

find_package(EXPAT QUIET)

if (NOT EXPAT_FOUND)
    set(EXPAT_EXTENSION tar.bz2)
    set(EXPAT_FULLNAME ${EXPAT_BASE}.${EXPAT_EXTENSION})
    set(EXPAT_SITE http://downloads.sourceforge.net/project/expat/expat/${EXPAT_VERSION})
    set(EXPAT_STAMP_DIR ${PACKAGE_STAMP_DIR}/${EXPAT_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${EXPAT_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${EXPAT_SITE}
        ${EXPAT_FULLNAME}
        ${EXPAT_BASE}
        ${EXPAT_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static"
        "make"
        "make check"
        "make install")
    add_auxiliary_target(${EXPAT_BASE} aux)
    add_custom_target(install_doc
        DEPENDS ${EXPAT_BASE}-aux
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/share/doc/${EXPAT_BASE}
        COMMAND ${CMAKE_COMMAND} -E copy
            ${PACKAGE_BUILD_DIR}/${EXPAT_BASE}/doc/reference.html
            ${PACKAGE_BUILD_DIR}/${EXPAT_BASE}/doc/expat.png
            ${PACKAGE_BUILD_DIR}/${EXPAT_BASE}/doc/valid-xhtml10.png
            ${PACKAGE_BUILD_DIR}/${EXPAT_BASE}/doc/style.css
            ${CMAKE_INSTALL_PREFIX}/share/doc/${EXPAT_BASE}
        COMMENT "Install docs"
        VERBATIM)
    add_dependencies(${EXPAT_BASE} install_doc)
else()
    add_custom_target(${EXPAT_BASE})
endif()