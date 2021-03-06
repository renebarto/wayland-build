project(dmxproto)

set(X11PROTO_DMX_VERSION 2.3.1)
set(X11PROTO_DMX_REQUIRED_VERSION ${X11PROTO_DMX_VERSION})

find_package(X11ProtoDmx QUIET)

set(X11PROTO_DMX_NAME ${PROJECT_NAME})
set(X11PROTO_DMX_BASE ${X11PROTO_DMX_NAME}-${X11PROTO_DMX_VERSION})

if (NOT X11PROTO_DMX_FOUND)
    set(X11PROTO_DMX_EXTENSION tar.gz)
    set(X11PROTO_DMX_FULLNAME ${X11PROTO_DMX_BASE}.${X11PROTO_DMX_EXTENSION})
    set(X11PROTO_DMX_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_DMX_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_DMX_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_DMX_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_DMX_SITE}
        ${X11PROTO_DMX_FULLNAME}
        ${X11PROTO_DMX_BASE}
        ${X11PROTO_DMX_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_DMX_BASE})
endif()
