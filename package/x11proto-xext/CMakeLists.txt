project(xextproto)

set(X11PROTO_XEXT_VERSION 7.3.0)
set(X11PROTO_XEXT_REQUIRED_VERSION ${X11PROTO_XEXT_VERSION})

find_package(X11ProtoXext QUIET)

set(X11PROTO_XEXT_NAME ${PROJECT_NAME})
set(X11PROTO_XEXT_BASE ${X11PROTO_XEXT_NAME}-${X11PROTO_XEXT_VERSION})

if (NOT X11PROTO_XEXT_FOUND)
    set(X11PROTO_XEXT_EXTENSION tar.gz)
    set(X11PROTO_XEXT_FULLNAME ${X11PROTO_XEXT_BASE}.${X11PROTO_XEXT_EXTENSION})
    set(X11PROTO_XEXT_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_XEXT_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_XEXT_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_XEXT_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_XEXT_SITE}
        ${X11PROTO_XEXT_FULLNAME}
        ${X11PROTO_XEXT_BASE}
        ${X11PROTO_XEXT_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_XEXT_BASE})
endif()
