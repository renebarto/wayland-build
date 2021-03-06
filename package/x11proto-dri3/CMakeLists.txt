project(dri3proto)

set(X11PROTO_DRI3_VERSION 1.0)
set(X11PROTO_DRI3_REQUIRED_VERSION ${X11PROTO_DRI3_VERSION})
set(X11PROTO_DRI3_NAME ${PROJECT_NAME})
set(X11PROTO_DRI3_BASE ${X11PROTO_DRI3_NAME}-${X11PROTO_DRI3_VERSION})

find_package(X11ProtoDri3 QUIET)

if (NOT X11PROTO_DRI3_FOUND)
    set(X11PROTO_DRI3_EXTENSION tar.gz)
    set(X11PROTO_DRI3_FULLNAME ${X11PROTO_DRI3_BASE}.${X11PROTO_DRI3_EXTENSION})
    set(X11PROTO_DRI3_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_DRI3_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_DRI3_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_DRI3_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_DRI3_SITE}
        ${X11PROTO_DRI3_FULLNAME}
        ${X11PROTO_DRI3_BASE}
        ${X11PROTO_DRI3_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_DRI3_BASE})
endif()
