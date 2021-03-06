project(fixesproto)

set(X11PROTO_FIXES_VERSION 5.0)
set(X11PROTO_FIXES_REQUIRED_VERSION ${X11PROTO_FIXES_VERSION})

find_package(X11ProtoFixes QUIET)

set(X11PROTO_FIXES_NAME ${PROJECT_NAME})
set(X11PROTO_FIXES_BASE ${X11PROTO_FIXES_NAME}-${X11PROTO_FIXES_VERSION})

if (NOT X11PROTO_FIXES_FOUND)
    set(X11PROTO_FIXES_EXTENSION tar.gz)
    set(X11PROTO_FIXES_FULLNAME ${X11PROTO_FIXES_BASE}.${X11PROTO_FIXES_EXTENSION})
    set(X11PROTO_FIXES_SITE ftp://ftp.x.org/pub/individual/proto)
    set(X11PROTO_FIXES_STAMP_DIR ${PACKAGE_STAMP_DIR}/${X11PROTO_FIXES_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${X11PROTO_FIXES_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${X11PROTO_FIXES_SITE}
        ${X11PROTO_FIXES_FULLNAME}
        ${X11PROTO_FIXES_BASE}
        ${X11PROTO_FIXES_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX}"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${X11PROTO_FIXES_BASE})
endif()
