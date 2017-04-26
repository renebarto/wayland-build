project(kbproto)

set(X11PROTO_KB_VERSION 1.0.7)
set(X11PROTO_KB_REQUIRED_VERSION ${X11PROTO_KB_VERSION})

find_package(X11ProtoKb QUIET)

set(X11PROTO_KB_NAME ${PROJECT_NAME})
set(X11PROTO_KB_BASE ${X11PROTO_KB_NAME}-${X11PROTO_KB_VERSION})

if (NOT X11PROTO_KB_FOUND)
    set(X11PROTO_KB_EXTENSION tar.gz)
    set(X11PROTO_KB_FULLNAME ${X11PROTO_KB_BASE}.${X11PROTO_KB_EXTENSION})
    set(X11PROTO_KB_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_KB_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_KB_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_KB_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_KB_SITE}
        ${X11PROTO_KB_FULLNAME}
        ${X11PROTO_KB_BASE}
        ${X11PROTO_KB_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}")
    add_dependencies(${X11PROTO_KB_BASE} libX11-1.6.4)
else()
    add_custom_target(${X11PROTO_KB_BASE})
endif()
