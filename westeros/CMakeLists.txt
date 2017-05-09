project(westeros)

set(WESTEROS_VERSION 87bc367344f7aab820b74e8fd01f4cf104807ab8)
set(WESTEROS_REQUIRED_VERSION 1.0.0)
set(WESTEROS_NAME ${PROJECT_NAME})
set(WESTEROS_BASE ${WESTEROS_NAME}-${WESTEROS_VERSION})

set(WAYLAND_SCANNER ${CMAKE_INSTALL_PREFIX}/bin/wayland-scanner)

set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_SOURCE
    simplebuffer/protocol/simple-buffer.xml)
set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SOURCE
    simplebuffer/protocol/simplebuffer-protocol.c)
set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_CLIENT_HEADER
    simplebuffer/protocol/simplebuffer-client-protocol.h)
set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SERVER_HEADER
    simplebuffer/protocol/simplebuffer-server-protocol.h)

add_custom_command(OUTPUT ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SOURCE}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} code
        ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_SOURCE}
        ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SOURCE}
    COMMENT "Generate ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SOURCE}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_CLIENT_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} client-header
        ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_SOURCE}
        ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_CLIENT_HEADER}
    COMMENT "Generate ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_CLIENT_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SERVER_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} server-header
        ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_SOURCE}
        ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SERVER_HEADER}
    COMMENT "Generate ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SERVER_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_target(westeros-simplebuffer-protocol
    DEPENDS
    ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SOURCE}
    ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_CLIENT_HEADER}
    ${WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SERVER_HEADER})

set(WESTEROS_SIMPLE_SHELL_PROTOCOL_SOURCE
    simpleshell/protocol/simpleshell.xml)
set(WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SOURCE
    simpleshell/protocol/simpleshell-protocol.c)
set(WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_CLIENT_HEADER
    simpleshell/protocol/simpleshell-client-protocol.h)
set(WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SERVER_HEADER
    simpleshell/protocol/simpleshell-server-protocol.h)

add_custom_command(OUTPUT ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SOURCE}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} code
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_SOURCE}
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SOURCE}
    COMMENT "Generate ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SOURCE}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_CLIENT_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} client-header
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_SOURCE}
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_CLIENT_HEADER}
    COMMENT "Generate ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_CLIENT_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SERVER_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} server-header
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_SOURCE}
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SERVER_HEADER}
    COMMENT "Generate ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SERVER_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_target(westeros-simpleshell-protocol
    DEPENDS
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SOURCE}
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_CLIENT_HEADER}
    ${WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SERVER_HEADER})

set(WESTEROS_XDG_SHELL_V4_PROTOCOL_SOURCE
    protocol/version4/xdg-shell.xml)
set(WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SOURCE
    protocol/version4/xdg-shell-protocol.c)
set(WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SERVER_HEADER
    protocol/version4/xdg-shell-server-protocol.h)

add_custom_command(OUTPUT ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SOURCE}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} code ${WESTEROS_XDG_SHELL_V4_PROTOCOL_SOURCE} ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SOURCE}
    COMMENT "Generate ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SOURCE}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SERVER_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} server-header ${WESTEROS_XDG_SHELL_V4_PROTOCOL_SOURCE} ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SERVER_HEADER}
    COMMENT "Generate ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SERVER_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_target(westeros-xdgshell-v4-protocol
    DEPENDS
    ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SOURCE}
    ${WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SERVER_HEADER})

set(WESTEROS_XDG_SHELL_V5_PROTOCOL_SOURCE
    protocol/version5/xdg-shell.xml)
set(WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SOURCE
    protocol/version5/xdg-shell-protocol.c)
set(WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SERVER_HEADER
    protocol/version5/xdg-shell-server-protocol.h)

add_custom_command(OUTPUT ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SOURCE}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} code ${WESTEROS_XDG_SHELL_V5_PROTOCOL_SOURCE} ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SOURCE}
    COMMENT "Generate ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SOURCE}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SERVER_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} server-header ${WESTEROS_XDG_SHELL_V5_PROTOCOL_SOURCE} ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SERVER_HEADER}
    COMMENT "Generate ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SERVER_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_target(westeros-xdgshell-v5-protocol
    DEPENDS
    ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SOURCE}
    ${WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SERVER_HEADER})


set(WESTEROS_VPC_PROTOCOL_SOURCE
    protocol/vpc.xml)
set(WESTEROS_VPC_PROTOCOL_OUTPUT_SOURCE
    protocol/vpc-protocol.c)
set(WESTEROS_VPC_PROTOCOL_OUTPUT_CLIENT_HEADER
    protocol/vpc-client-protocol.h)
set(WESTEROS_VPC_PROTOCOL_OUTPUT_SERVER_HEADER
    protocol/vpc-server-protocol.h)

add_custom_command(OUTPUT ${WESTEROS_VPC_PROTOCOL_OUTPUT_SOURCE}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} code ${WESTEROS_VPC_PROTOCOL_SOURCE} ${WESTEROS_VPC_PROTOCOL_OUTPUT_SOURCE}
    COMMENT "Generate ${WESTEROS_VPC_PROTOCOL_OUTPUT_SOURCE}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_VPC_PROTOCOL_OUTPUT_CLIENT_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} client-header ${WESTEROS_VPC_PROTOCOL_SOURCE} ${WESTEROS_VPC_PROTOCOL_OUTPUT_CLIENT_HEADER}
    COMMENT "Generate ${WESTEROS_VPC_PROTOCOL_OUTPUT_CLIENT_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(OUTPUT ${WESTEROS_VPC_PROTOCOL_OUTPUT_SERVER_HEADER}
    DEPENDS wayland-1.13.0 wayland-protocols-1.7
    COMMAND ${WAYLAND_SCANNER} server-header ${WESTEROS_VPC_PROTOCOL_SOURCE} ${WESTEROS_VPC_PROTOCOL_OUTPUT_SERVER_HEADER}
    COMMENT "Generate ${WESTEROS_VPC_PROTOCOL_OUTPUT_SERVER_HEADER}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_target(westeros-vpc-protocol
    DEPENDS
    ${WESTEROS_VPC_PROTOCOL_OUTPUT_SOURCE}
    ${WESTEROS_VPC_PROTOCOL_OUTPUT_CLIENT_HEADER}
    ${WESTEROS_VPC_PROTOCOL_OUTPUT_SERVER_HEADER})

set(WESTEROS_SIMPLE_BUFFER_CLIENT_SOURCES
    simplebuffer/protocol/simplebuffer-protocol.c)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS
    simplebuffer/protocol/simplebuffer-client-protocol.h)
add_library(westeros_simplebuffer_client
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS})
set(WESTEROS_SIMPLE_BUFFER_SERVER_SOURCES
    simplebuffer/protocol/simplebuffer-protocol.c)
set(WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS
    simplebuffer/protocol/simplebuffer-server-protocol.h)
add_library(westeros_simplebuffer_server
    ${WESTEROS_SIMPLE_BUFFER_SERVER_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS})

#    set(STAMP_EXTRACT ${WESTEROS_STAMP_DIR}/stamp_extract)
#    add_custom_target(${WESTEROS_BASE} DEPENDS ${STAMP_EXTRACT})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_DOWNLOAD_DIR ${PACKAGE_DOWNLOAD_DIR})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_BUILD_DIR ${PACKAGE_BUILD_DIR})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_STAMP_DIR ${WESTEROS_STAMP_DIR})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_PACKAGE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_STAGING_DIR ${PACKAGE_STAGING_DIR})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_SITE ${WESTEROS_SITE})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_FULLNAME ${WESTEROS_FULLNAME})
#    set_property(TARGET ${WESTEROS_BASE} PROPERTY _PKG_MODULE ${WESTEROS_BASE})
#    setup_mkdir_command(${WESTEROS_BASE})
#    setup_download_command(${WESTEROS_BASE})
#    setup_extract_command(${WESTEROS_BASE})
#    add_dependencies(${WESTEROS_BASE}
#        wayland-1.13.0
#        wayland-protocols-1.7
#        libevdev-1.5.6
#        libxkbcommon-0.7.1
#        cairo-1.14.8
#        libjpeg-turbo-1.5.1
#        mesa-17.0.4
#        mtdev-1.1.5
#        libXcursor-1.1.14
#        libXrender-0.9.10)
#
#    set(WESTEROS_BUILD ${PACKAGE_BUILD_DIR}/${WESTEROS_BASE})
#    set(WESTEROS_PROTOCOLS westeros-protocol)
#    set(WESTEROS_SIMPLE_SHELL westeros-simpleshell)
#    set(WESTEROS_SIMPLE_BUFFER westeros-simplebuffer)
#    set(WESTEROS_GL westeros-gl)
#    set(WESTEROS_SINK westeros-sink)
#    set(WESTEROS_SINK westeros-soc)
#    set(WESTEROS_MAIN westeros-main)
#    set(WESTEROS westeros)
#
#    set(WESTEROS_INCLUDE_DIRS
#        ${WESTEROS_BUILD}/protocol
#        ${WESTEROS_BUILD}/simpleshell/protocol
#        ${WESTEROS_BUILD}/simplebuffer/protocol
#        ${WESTEROS_BUILD}/westeros-sink
#        ${CMAKE_INSTALL_PREFIX}/include
#        ${CMAKE_INSTALL_PREFIX}/include/libdrm
#        /usr/include
#        /usr/include/x86_64-linux-gnu)
#
#    message(STATUS "westeros-protocols sources: ${WESTEROS_PROTOCOLS_SOURCE_FILES}")
#    message(STATUS "westeros-protocols headers: ${WESTEROS_PROTOCOLS_HEADER_FILES}")
#
#    add_custom_target(${WESTEROS_PROTOCOLS} DEPENDS
#        ${WESTEROS_BASE}
#        ${WESTEROS_PROTOCOLS_SOURCE_FILES}
#        ${WESTEROS_PROTOCOLS_HEADER_FILES})
#
#    # SIMPLESHELL
#    set(WESTEROS_SIMPLESHELL_CLIENT_SOURCE_FILES
#        ${WESTEROS_BUILD}/simpleshell/protocol/simpleshell-protocol.c)
#    set(WESTEROS_SIMPLESHELL_CLIENT_HEADER_FILES
#        ${WESTEROS_BUILD}/simpleshell/protocol/simpleshell-client-protocol.h
#        ${WESTEROS_BUILD}/simpleshell/protocol/simpleshell-server-protocol.h)
#
#    add_library(westeros_simpleshell_client
#        ${WESTEROS_SIMPLESHELL_CLIENT_SOURCE_FILES}
#        ${WESTEROS_SIMPLESHELL_CLIENT_HEADER_FILES})
#    target_include_directories(westeros_simpleshell_client PRIVATE ${WESTEROS_INCLUDE_DIRS})
#
#    set(WESTEROS_SIMPLESHELL_SERVER_SOURCE_FILES
#        ${WESTEROS_BUILD}/simpleshell/protocol/simpleshell-protocol.c
#        ${WESTEROS_BUILD}/simpleshell/westeros-simpleshell.cpp)
#    set(WESTEROS_SIMPLESHELL_SERVER_HEADER_FILES
#        ${WESTEROS_BUILD}/simpleshell/protocol/simpleshell-client-protocol.h
#        ${WESTEROS_BUILD}/simpleshell/protocol/simpleshell-server-protocol.h
#        ${WESTEROS_BUILD}/simpleshell/westeros-simpleshell.h)
#
#    add_library(westeros_simpleshell_server
#        ${WESTEROS_SIMPLESHELL_SERVER_SOURCE_FILES}
#        ${WESTEROS_SIMPLESHELL_SERVER_HEADER_FILES})
#    target_include_directories(westeros_simpleshell_server PRIVATE ${WESTEROS_INCLUDE_DIRS})
#
#    add_custom_target(${WESTEROS_SIMPLE_SHELL} DEPENDS
#        westeros_simpleshell_client
#        westeros_simpleshell_server)
#
#    # SIMPLEBUFFER
#    set(WESTEROS_SIMPLEBUFFER_CLIENT_SOURCE_FILES
#        ${WESTEROS_BUILD}/simplebuffer/protocol/simplebuffer-protocol.c)
#    set(WESTEROS_SIMPLEBUFFER_CLIENT_HEADER_FILES
#        ${WESTEROS_BUILD}/simplebuffer/protocol/simplebuffer-client-protocol.h
#        ${WESTEROS_BUILD}/simplebuffer/protocol/simplebuffer-server-protocol.h)
#
#    add_library(westeros_simplebuffer_client
#        ${WESTEROS_SIMPLEBUFFER_CLIENT_SOURCE_FILES}
#        ${WESTEROS_SIMPLEBUFFER_CLIENT_HEADER_FILES})
#    target_include_directories(westeros_simplebuffer_client PRIVATE ${WESTEROS_INCLUDE_DIRS})
#
#    set(WESTEROS_SIMPLEBUFFER_SERVER_SOURCE_FILES
#        ${WESTEROS_BUILD}/simplebuffer/protocol/simplebuffer-protocol.c
#        ${WESTEROS_BUILD}/simplebuffer/westeros-simplebuffer.cpp)
#    set(WESTEROS_SIMPLEBUFFER_SERVER_HEADER_FILES
#        ${WESTEROS_BUILD}/simplebuffer/protocol/simplebuffer-client-protocol.h
#        ${WESTEROS_BUILD}/simplebuffer/protocol/simplebuffer-server-protocol.h
#        ${WESTEROS_BUILD}/simplebuffer/westeros-simplebuffer.h)
#
#    add_library(westeros_simplebuffer_server
#        ${WESTEROS_SIMPLEBUFFER_SERVER_SOURCE_FILES}
#        ${WESTEROS_SIMPLEBUFFER_SERVER_HEADER_FILES})
#    target_include_directories(westeros_simplebuffer_server PRIVATE ${WESTEROS_INCLUDE_DIRS})
#
#    add_custom_target(${WESTEROS_SIMPLE_BUFFER} DEPENDS
#        westeros_simplebuffer_client
#        westeros_simplebuffer_server)
#
#    # GL
#    set(WESTEROS_GL_SERVER_SOURCE_FILES
#        ${WESTEROS_BUILD}/drm/westeros-gl/westeros-gl.c)
#    set(WESTEROS_GL_SERVER_HEADER_FILES
#        ${WESTEROS_BUILD}/drm/westeros-gl/westeros-gl.h)
#
#    add_library(westeros_gl
#        ${WESTEROS_GL_SERVER_SOURCE_FILES}
#        ${WESTEROS_GL_SERVER_HEADER_FILES})
#    target_include_directories(westeros_gl PRIVATE ${WESTEROS_INCLUDE_DIRS})
#    target_link_libraries(westeros_gl drm gbm)
#
#    add_custom_target(${WESTEROS_GL} DEPENDS
#        westeros_gl)
#
#    # SINK
#    set(WESTEROS_SINK_SERVER_SOURCE_FILES
#        ${WESTEROS_BUILD}/drm/westeros-sink/westeros-sink-soc.c
#        ${WESTEROS_BUILD}/westeros-sink/westeros-sink.c)
#    set(WESTEROS_SINK_SERVER_HEADER_FILES
#        ${WESTEROS_BUILD}/drm/westeros-sink/westeros-sink-soc.h
#        ${WESTEROS_BUILD}/westeros-sink/westeros-sink.h)
#
##    add_library(westeros_sink
##        ${WESTEROS_SINK_SERVER_SOURCE_FILES}
##        ${WESTEROS_SINK_SERVER_HEADER_FILES})
##    target_include_directories(westeros_sink PRIVATE ${WESTEROS_INCLUDE_DIRS})
##    target_link_libraries(westeros_sink westeros_compositor westeros_simplebuffer_client westeros_simpleshell_client)
##
##    add_custom_target(${WESTEROS_SINK} DEPENDS
##        westeros_sink)
#
#    # MAIN
#    set(WESTEROS_MAIN_SERVER_SOURCE_FILES
#        ${WESTEROS_BUILD}/westeros-main.cpp)
#    set(WESTEROS_MAIN_SERVER_HEADER_FILES)
#
#    add_library(westeros_main
#        ${WESTEROS_MAIN_SERVER_SOURCE_FILES}
#        ${WESTEROS_MAIN_SERVER_HEADER_FILES})
#    target_include_directories(westeros_main PRIVATE ${WESTEROS_INCLUDE_DIRS})
#    target_link_libraries(westeros_main westeros_compositor)
#
#    add_custom_target(${WESTEROS_MAIN} DEPENDS
#        westeros_main)
#
#    add_custom_target(${WESTEROS} DEPENDS
#        ${WESTEROS_PROTOCOLS}
#        ${WESTEROS_SIMPLE_SHELL}
#        ${WESTEROS_SIMPLE_BUFFER}
##        ${WESTEROS_SINK}
#        ${WESTEROS_MAIN})

#    setup_package_automake(
#        ${PACKAGE_DOWNLOAD_DIR}
#        ${PACKAGE_BUILD_DIR}
#        ${PACKAGE_STAGING_DIR}
#        ${WESTEROS_STAMP_DIR}
#        ${CMAKE_CURRENT_SOURCE_DIR}
#        ${WESTEROS_SITE}
#        ${WESTEROS_FULLNAME}
#        ${WESTEROS_BASE}
#        ${WESTEROS_BASE}
#        "0001-Fix_voidp_to_uint32_conversion.patch"
#        "mkdir -p cfg && autoreconf -i -f -Icfg"
#        "./configure --prefix=${CMAKE_INSTALL_PREFIX} \
#            --enable-app=yes \
#            --enable-test=yes \
#            --enable-rendergl=yes \
#            --enable-sbprotocol=yes \
#            --enable-xdgv5=yes"
#        "SCANNER_TOOL=${CMAKE_INSTALL_PREFIX}/bin/wayland-scanner make -C ${PACKAGE_BUILD_DIR}/${WESTEROS_BASE}/protocol && \
#         CFLAGS='-DWESTEROS_PLATFORM_DRM -DWESTEROS_HAVE_WAYLAND_EGL -I${CMAKE_INSTALL_PREFIX}/include/interface/vmcs_host/linux -I${CMAKE_INSTALL_PREFIX}/include/libdrm -I./include -I./protocol -I${CMAKE_INSTALL_PREFIX}/include/wayland' \
#         CPPFLAGS='-DWESTEROS_PLATFORM_DRM -DWESTEROS_HAVE_WAYLAND_EGL -I${CMAKE_INSTALL_PREFIX}/include/interface/vmcs_host/linux -I${CMAKE_INSTALL_PREFIX}/include/libdrm -I./include -I./protocol -I${CMAKE_INSTALL_PREFIX}/include/wayland' \
#         make"
#        ""
#        #        "make check" // One test fails (xwayland)
#        "make install")
add_custom_target(${WESTEROS_BASE}
    COMMENT "Westeros")
add_dependencies(${WESTEROS_BASE}
    wayland-1.13.0
    wayland-protocols-1.7
    libevdev-1.5.6
    libxkbcommon-0.7.1
    cairo-1.14.8
    libjpeg-turbo-1.5.1
    mesa-17.0.4
    mtdev-1.1.5
    libXcursor-1.1.14
    libXrender-0.9.10
    glib-2.52.1
    gstreamer-1.10.4
    gst-plugins-base-1.10.4
    gst-plugins-good-1.10.4
    gst-plugins-bad-1.10.4
    gstreamer-1.10.4
    westeros-simplebuffer-protocol
    westeros-simpleshell-protocol
    westeros-xdgshell-v4-protocol
    westeros-xdgshell-v5-protocol
    westeros-vpc-protocol)
