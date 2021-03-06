project(dri2proto)

set(X11PROTO_DRI2_VERSION 2.8)
set(X11PROTO_DRI2_REQUIRED_VERSION ${X11PROTO_DRI2_VERSION})
set(X11PROTO_DRI2_NAME ${PROJECT_NAME})
set(X11PROTO_DRI2_BASE ${X11PROTO_DRI2_NAME}-${X11PROTO_DRI2_VERSION})

find_package(X11ProtoDri2 QUIET)

if (NOT X11PROTO_DRI2_FOUND)
    set(X11PROTO_DRI2_EXTENSION tar.gz)
    set(X11PROTO_DRI2_FULLNAME ${X11PROTO_DRI2_BASE}.${X11PROTO_DRI2_EXTENSION})
    set(X11PROTO_DRI2_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_DRI2_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_DRI2_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_DRI2_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_DRI2_SITE}
        ${X11PROTO_DRI2_FULLNAME}
        ${X11PROTO_DRI2_BASE}
        ${X11PROTO_DRI2_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_DRI2_BASE})
endif()
