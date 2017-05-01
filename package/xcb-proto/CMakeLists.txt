project(xcb-proto)

set(XCB_PROTO_VERSION 1.12)
set(XCB_PROTO_REQUIRED_VERSION ${XCB_PROTO_VERSION})
set(XCB_PROTO_NAME ${PROJECT_NAME})
set(XCB_PROTO_BASE ${XCB_PROTO_NAME}-${XCB_PROTO_VERSION})

find_package(XcbProto QUIET)

if (NOT XCB_PROTO_FOUND)
    set(XCB_PROTO_EXTENSION tar.bz2)
    set(XCB_PROTO_FULLNAME ${XCB_PROTO_BASE}.${XCB_PROTO_EXTENSION})
    set(XCB_PROTO_SITE http://xcb.freedesktop.org/dist)
    set(XCB_PROTO_STAMP_DIR ${PACKAGE_STAMP_DIR}/${XCB_PROTO_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${XCB_PROTO_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${XCB_PROTO_SITE}
        ${XCB_PROTO_FULLNAME}
        ${XCB_PROTO_BASE}
        ${XCB_PROTO_BASE}
        "0001-Fix-checks.patch"
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --sysconfdir=${CMAKE_SYSROOT}/etc \
            --localstatedir=${CMAKE_SYSROOT}/var --disable-static"
        "make"
        "make check"
        "make install")
else()
    add_custom_target(${XCB_PROTO_BASE})
endif()
