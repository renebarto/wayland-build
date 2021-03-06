project(fontsproto)

set(X11PROTO_FONTS_VERSION 2.1.3)
set(X11PROTO_FONTS_REQUIRED_VERSION ${X11PROTO_FONTS_VERSION})

find_package(X11ProtoFonts QUIET)

set(X11PROTO_FONTS_NAME ${PROJECT_NAME})
set(X11PROTO_FONTS_BASE ${X11PROTO_FONTS_NAME}-${X11PROTO_FONTS_VERSION})

if (NOT X11PROTO_FONTS_FOUND)
    set(X11PROTO_FONTS_EXTENSION tar.gz)
    set(X11PROTO_FONTS_FULLNAME ${X11PROTO_FONTS_BASE}.${X11PROTO_FONTS_EXTENSION})
    set(X11PROTO_FONTS_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_FONTS_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_FONTS_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_FONTS_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_FONTS_SITE}
        ${X11PROTO_FONTS_FULLNAME}
        ${X11PROTO_FONTS_BASE}
        ${X11PROTO_FONTS_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_FONTS_BASE})
endif()
