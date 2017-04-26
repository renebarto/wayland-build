project(glproto)

set(X11PROTO_GL_VERSION 1.4.17)
set(X11PROTO_GL_REQUIRED_VERSION ${X11PROTO_GL_VERSION})

find_package(X11ProtoGL QUIET)

set(X11PROTO_GL_NAME ${PROJECT_NAME})
set(X11PROTO_GL_BASE ${X11PROTO_GL_NAME}-${X11PROTO_GL_VERSION})

if (NOT X11PROTO_GL_FOUND)
    set(X11PROTO_GL_EXTENSION tar.gz)
    set(X11PROTO_GL_FULLNAME ${X11PROTO_GL_BASE}.${X11PROTO_GL_EXTENSION})
    set(X11PROTO_GL_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_GL_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_GL_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_GL_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_GL_SITE}
        ${X11PROTO_GL_FULLNAME}
        ${X11PROTO_GL_BASE}
        ${X11PROTO_GL_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}")
    add_dependencies(${X11PROTO_GL_BASE} libX11-1.6.4)
else()
    add_custom_target(${X11PROTO_GL_BASE})
endif()
