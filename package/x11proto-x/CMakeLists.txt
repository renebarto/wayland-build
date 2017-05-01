project(xproto)

set(X11PROTO_X_VERSION 7.0.31)
set(X11PROTO_X_REQUIRED_VERSION ${X11PROTO_X_VERSION})

find_package(X11ProtoX QUIET)

set(X11PROTO_X_NAME ${PROJECT_NAME})
set(X11PROTO_X_BASE ${X11PROTO_X_NAME}-${X11PROTO_X_VERSION})

if (NOT X11PROTO_X_FOUND)
    set(X11PROTO_X_EXTENSION tar.gz)
    set(X11PROTO_X_FULLNAME ${X11PROTO_X_BASE}.${X11PROTO_X_EXTENSION})
    set(X11PROTO_X_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_X_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_X_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_X_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_X_SITE}
        ${X11PROTO_X_FULLNAME}
        ${X11PROTO_X_BASE}
        ${X11PROTO_X_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_X_BASE})
endif()
