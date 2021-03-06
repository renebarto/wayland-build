project(randrproto)

set(X11PROTO_RANDR_VERSION 1.5.0)
set(X11PROTO_RANDR_REQUIRED_VERSION ${X11PROTO_RANDR_VERSION})

find_package(X11ProtoRandr QUIET)

set(X11PROTO_RANDR_NAME ${PROJECT_NAME})
set(X11PROTO_RANDR_BASE ${X11PROTO_RANDR_NAME}-${X11PROTO_RANDR_VERSION})

if (NOT X11PROTO_RANDR_FOUND)
    set(X11PROTO_RANDR_EXTENSION tar.gz)
    set(X11PROTO_RANDR_FULLNAME ${X11PROTO_RANDR_BASE}.${X11PROTO_RANDR_EXTENSION})
    set(X11PROTO_RANDR_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_RANDR_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_RANDR_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_RANDR_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_RANDR_SITE}
        ${X11PROTO_RANDR_FULLNAME}
        ${X11PROTO_RANDR_BASE}
        ${X11PROTO_RANDR_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_RANDR_BASE})
endif()
