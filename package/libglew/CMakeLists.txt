project(glew)

set(LIBGLEW_VERSION 2.0.0)
set(LIBGLEW_REQUIRED_VERSION ${LIBGLEW_VERSION})
set(LIBGLEW_NAME ${PROJECT_NAME})
set(LIBGLEW_BASE ${LIBGLEW_NAME}-${LIBGLEW_VERSION})

find_package(LibGLEW QUIET)

if (NOT LIBGLEW_FOUND)
    set(LIBGLEW_EXTENSION tgz)
    set(LIBGLEW_FULLNAME ${LIBGLEW_BASE}.${LIBGLEW_EXTENSION})
    set(LIBGLEW_SITE https://sourceforge.net/projects/glew/files/glew/2.0.0)
    set(LIBGLEW_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBGLEW_BASE})

    # ! build as cmake build. cd build; cmake ./cmake
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBGLEW_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBGLEW_SITE}
        ${LIBGLEW_FULLNAME}
        ${LIBGLEW_BASE}
        ${LIBGLEW_BASE}
        ""
        ""
        "echo test")
else()
    add_custom_target(${LIBGLEW_BASE})
endif()
