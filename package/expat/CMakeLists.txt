project(expat)

#find_package(EXPAT QUIET)

set(MODULE ${PROJECT_NAME})
set(VERSION 2.2.0)
set(BASE ${MODULE}-${VERSION})

if (NOT EXPAT_FOUND)
    set(EXTENSION tar.bz2)
    set(FULLNAME ${BASE}.${EXTENSION})
    set(SITE http://downloads.sourceforge.net/project/expat/expat/${VERSION})
    set(DOWNLOAD_DIR ${PACKAGE_DOWNLOAD_DIR})
    set(STAMP_DIR ${PACKAGE_STAMP_DIR}/${BASE})
    setup_package_automake(
        ${DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${SITE}
        ${FULLNAME}
        ${MODULE}
        ${BASE}
        ""
        "./configure --prefix=${CMAKE_PREFIX_PATH} --disable-static")
    install(FILES ${PACKAGE_BUILD_DIR}/${BASE}/doc/*.html DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/${BASE}")
    install(FILES ${PACKAGE_BUILD_DIR}/${BASE}/doc/*.png DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/${BASE}")
    install(FILES ${PACKAGE_BUILD_DIR}/${BASE}/doc/*.css DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/${BASE}")
else()
    add_custom_target(${BASE})
endif()