project(westeros)

include(show_target_properties)
include(setup_target_properties_library)

option(USE_GLEW "Using GLEW" OFF)
option(HAVE_WAYLAND_EGL "Have Wayland EGL support, will otherwise support EGL from westeros" ON)
option(ENABLE_WESTEROS_SBPROTOCOL "Enable simple buffer procotol (needed for drm)" ON)
option(ENABLE_XDG_V4 "Support desktop shell V4" OFF)
option(ENABLE_XDG_V5 "Support desktop shell V5" ON)
option(ENABLE_WESTEROS_RENDERERGL "Support GL rendering" ON)
option(ENABLE_WESTEROS_APP "Build main westeros application" ON)
option(ENABLE_WESTEROS_TEST "Build westeros test application" ON)
option(ENABLE_WESTEROS_PLAYER "Build westeros player application" ON)

set(WESTEROS_VERSION 87bc367344f7aab820b74e8fd01f4cf104807ab8)
set(WESTEROS_REQUIRED_VERSION 1.0.0)
set(WESTEROS_NAME ${PROJECT_NAME})
set(WESTEROS_BASE ${WESTEROS_NAME}-${WESTEROS_VERSION})

set(WAYLAND_SCANNER ${CMAKE_INSTALL_PREFIX}/bin/wayland-scanner)

set(PACKAGE westeros)
set(PACKAGE_VERSION 1.0.0)
set(PACKAGE_TARNAME westeros)

set(prefix ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${prefix})
set(bindir ${exec_prefix}/bin)
set(datarootdir ${prefix}/share)
set(datadir ${datarootdir})
set(docdir ${datarootdir}/doc/${PACKAGE_TARNAME})
set(includedir ${prefix}/include)
set(libdir ${exec_prefix}/lib)

set(DEFS -DHAVE_CONFIG_H)
set(EGL_CFLAGS -I${includedir} -I${includedir}/libdrm)
set(EGL_LIBS -L${libdir} -lEGL)
set(GLESV2_CFLAGS -I${includedir})
set(GLESV2_LIBS -L${libdir} -lGLESv2)
set(GLIB_CFLAGS -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include -I${includedir})
set(GLIB_LIBS -L${libdir} -lglib-2.0)
set(GSTBASE_CFLAGS -pthread -I${includedir}/gstreamer-1.0 -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include -I${includedir})
set(GSTBASE_LIBS -L${libdir} -lgstbase-1.0 -lgstreamer-1.0 -lgobject-2.0 -lglib-2.0)
set(GST_CFLAGS -pthread -I${includedir}/gstreamer-1.0 -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include -I${includedir})
set(GST_LIBS -L${libdir} -lgstreamer-1.0 -lgobject-2.0 -lglib-2.0)
set(GTHREAD_CFLAGS -pthread -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include -I${includedir})
set(GTHREAD_LIBS -L${libdir} -lgthread-2.0 -pthread -lglib-2.0)
set(WAYLANDLIB -lwayland-server)
set(WAYLAND_CFLAGS )
set(WAYLAND_CLIENT_CFLAGS -I${includedir})
set(WAYLAND_CLIENT_LIBS -L${libdir} -lwayland-client)
set(WAYLAND_EGL_CFLAGS -I${includedir})
set(WAYLAND_EGL_LIBS -L${libdir} -lwayland-egl -lwayland-client)
set(WAYLAND_SERVER_CFLAGS -I${includedir})
set(WAYLAND_SERVER_LIBS -L${libdir} -lwayland-server)
set(XKBCOMMON_CFLAGS -I${includedir})
set(XKBCOMMON_LIBS -L${libdir} -lxkbcommon)

set(STANDARD_CXX_FLAGS -g -O2)
set(STANDARD_C_FLAGS -g -O2)
set(STANDARD_DEFINES HAVE_CONFIG_H _LARGEFILE_SOURCE _LARGEFILE64_SOURCE _FILE_OFFSET_BITS=64)
set(STANDARD_INCLUDE_DIRS . ${includedir} /usr/include /usr/local/include /usr/include/x86_64-linux-gnu)
set(STANDARD_LIB_DIRS . ${libdir} ${LIBRARY_OUTPUT_DIRECTORY} ${ARCHIVE_OUTPUT_DIRECTORY} /usr/lib /usr/local/lib)

## Protocols

## simple-buffer

set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simple-buffer.xml)
set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-protocol.c)
set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_CLIENT_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-client-protocol.h)
set(WESTEROS_SIMPLE_BUFFER_PROTOCOL_OUTPUT_SERVER_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-server-protocol.h)

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

## simple-shell

set(WESTEROS_SIMPLE_SHELL_PROTOCOL_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell.xml)
set(WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-protocol.c)
set(WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_CLIENT_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-client-protocol.h)
set(WESTEROS_SIMPLE_SHELL_PROTOCOL_OUTPUT_SERVER_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-server-protocol.h)

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

## xdg-shell-v4

set(WESTEROS_XDG_SHELL_V4_PROTOCOL_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell.xml)
set(WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell-protocol.c)
set(WESTEROS_XDG_SHELL_V4_PROTOCOL_OUTPUT_SERVER_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell-server-protocol.h)

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

## xdg-shell-v5

set(WESTEROS_XDG_SHELL_V5_PROTOCOL_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell.xml)
set(WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell-protocol.c)
set(WESTEROS_XDG_SHELL_V5_PROTOCOL_OUTPUT_SERVER_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell-server-protocol.h)

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

## vpc

set(WESTEROS_VPC_PROTOCOL_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc.xml)
set(WESTEROS_VPC_PROTOCOL_OUTPUT_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc-protocol.c)
set(WESTEROS_VPC_PROTOCOL_OUTPUT_CLIENT_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc-client-protocol.h)
set(WESTEROS_VPC_PROTOCOL_OUTPUT_SERVER_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc-server-protocol.h)

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

## simple-buffer

## simple-buffer client

set(WESTEROS_SIMPLE_BUFFER_CLIENT_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-protocol.c)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-client-protocol.h)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_BUFFER_CLIENT_LIBS wayland-client)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES )
set(WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES_PUBLIC ${STANDARD_DEFINES})

add_library(westeros_simplebuffer_client_shared SHARED
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS})
target_link_libraries(westeros_simplebuffer_client_shared ${WESTEROS_SIMPLE_BUFFER_CLIENT_LIBS})
target_include_directories(westeros_simplebuffer_client_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_client_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_client_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES})
target_compile_definitions(westeros_simplebuffer_client_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES_PUBLIC})
add_dependencies(westeros_simplebuffer_client_shared westeros-simplebuffer-protocol)
setup_target_properties_library(westeros_simplebuffer_client_shared)
set_target_properties(westeros_simplebuffer_client_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simplebuffer_client_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simplebuffer_client_shared PROPERTIES OUTPUT_NAME westeros_simplebuffer_client)
show_target_properties(westeros_simplebuffer_client_shared)

add_library(westeros_simplebuffer_client_static STATIC
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS})
target_link_libraries(westeros_simplebuffer_client_static ${WESTEROS_SIMPLE_BUFFER_CLIENT_LIBS})
target_include_directories(westeros_simplebuffer_client_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_client_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_client_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES})
target_compile_definitions(westeros_simplebuffer_client_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES_PUBLIC})
add_dependencies(westeros_simplebuffer_client_static westeros-simplebuffer-protocol)
setup_target_properties_library(westeros_simplebuffer_client_static)
set_target_properties(westeros_simplebuffer_client_static PROPERTIES OUTPUT_NAME westeros_simplebuffer_client)
show_target_properties(westeros_simplebuffer_client_static)

## simple-buffer server

set(WESTEROS_SIMPLE_BUFFER_SERVER_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-protocol.c
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer.cpp)
set(WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-server-protocol.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer.h)
set(WESTEROS_SIMPLE_BUFFER_SERVER_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_BUFFER_SERVER_LIBS wayland-server )
set(WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
set(WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES )
set(WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES_PUBLIC ${STANDARD_DEFINES})

add_library(westeros_simplebuffer_server_shared SHARED
    ${WESTEROS_SIMPLE_BUFFER_SERVER_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS})
target_link_libraries(westeros_simplebuffer_server_shared ${WESTEROS_SIMPLE_BUFFER_SERVER_LIBS})
target_include_directories(westeros_simplebuffer_server_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_server_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_server_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES})
target_compile_definitions(westeros_simplebuffer_server_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES_PUBLIC})
add_dependencies(westeros_simplebuffer_server_shared westeros-simplebuffer-protocol)
setup_target_properties_library(westeros_simplebuffer_server_shared)
set_target_properties(westeros_simplebuffer_server_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simplebuffer_server_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simplebuffer_server_shared PROPERTIES OUTPUT_NAME westeros_simplebuffer_server)
show_target_properties(westeros_simplebuffer_server_shared)

add_library(westeros_simplebuffer_server_static STATIC
    ${WESTEROS_SIMPLE_BUFFER_SERVER_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS})
target_link_libraries(westeros_simplebuffer_server_static ${WESTEROS_SIMPLE_BUFFER_SERVER_LIBS})
target_include_directories(westeros_simplebuffer_server_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_server_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_server_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES})
target_compile_definitions(westeros_simplebuffer_server_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES_PUBLIC})
add_dependencies(westeros_simplebuffer_server_static westeros-simplebuffer-protocol)
setup_target_properties_library(westeros_simplebuffer_server_static)
set_target_properties(westeros_simplebuffer_server_static PROPERTIES OUTPUT_NAME westeros_simplebuffer_server)
show_target_properties(westeros_simplebuffer_server_static)

install(FILES simplebuffer/westeros-simplebuffer.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

## simple-shell client

set(WESTEROS_SIMPLE_SHELL_CLIENT_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-protocol.c)
set(WESTEROS_SIMPLE_SHELL_CLIENT_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-client-protocol.h)
set(WESTEROS_SIMPLE_SHELL_CLIENT_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_SHELL_CLIENT_LIBS wayland-client)
set(WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol)
set(WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES )
set(WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES_PUBLIC ${STANDARD_DEFINES})

add_library(westeros_simpleshell_client_shared SHARED
    ${WESTEROS_SIMPLE_SHELL_CLIENT_SOURCES}
    ${WESTEROS_SIMPLE_SHELL_CLIENT_HEADERS})
target_link_libraries(westeros_simpleshell_client_shared ${WESTEROS_SIMPLE_SHELL_CLIENT_LIBS})
target_include_directories(westeros_simpleshell_client_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_client_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_client_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES})
target_compile_definitions(westeros_simpleshell_client_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES_PUBLIC})
add_dependencies(westeros_simpleshell_client_shared westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_client_shared)
set_target_properties(westeros_simpleshell_client_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simpleshell_client_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simpleshell_client_shared PROPERTIES OUTPUT_NAME westeros_simpleshell_client)
show_target_properties(westeros_simpleshell_client_shared)

add_library(westeros_simpleshell_client_static STATIC
    ${WESTEROS_SIMPLE_SHELL_CLIENT_SOURCES}
    ${WESTEROS_SIMPLE_SHELL_CLIENT_HEADERS})
target_link_libraries(westeros_simpleshell_client_static ${WESTEROS_SIMPLE_SHELL_CLIENT_LIBS})
target_include_directories(westeros_simpleshell_client_static PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_client_static PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_client_static PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES})
target_compile_definitions(westeros_simpleshell_client_static PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES_PUBLIC})
add_dependencies(westeros_simpleshell_client_static westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_client_static)
set_target_properties(westeros_simpleshell_client_static PROPERTIES OUTPUT_NAME westeros_simpleshell_client)
show_target_properties(westeros_simpleshell_client_static)

## simple-shell server

set(WESTEROS_SIMPLE_SHELL_SERVER_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-protocol.c
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/westeros-simpleshell.cpp)
set(WESTEROS_SIMPLE_SHELL_SERVER_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-server-protocol.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/westeros-simpleshell.h)
set(WESTEROS_SIMPLE_SHELL_SERVER_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_SHELL_SERVER_LIBS wayland-server)
set(WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol)
set(WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_SHELL_SERVER_DEFINES )
set(WESTEROS_SIMPLE_SHELL_SERVER_DEFINES_PUBLIC ${STANDARD_DEFINES})

add_library(westeros_simpleshell_server_shared SHARED
    ${WESTEROS_SIMPLE_SHELL_SERVER_SOURCES}
    ${WESTEROS_SIMPLE_SHELL_SERVER_HEADERS})
target_link_libraries(westeros_simpleshell_server_shared ${WESTEROS_SIMPLE_SHELL_SERVER_LIBS})
target_include_directories(westeros_simpleshell_server_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_server_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_server_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES})
target_compile_definitions(westeros_simpleshell_server_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES_PUBLIC})
add_dependencies(westeros_simpleshell_server_shared westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_server_shared)
set_target_properties(westeros_simpleshell_server_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simpleshell_server_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simpleshell_server_shared PROPERTIES OUTPUT_NAME westeros_simpleshell_server)
show_target_properties(westeros_simpleshell_server_shared)

add_library(westeros_simpleshell_server_static STATIC
    ${WESTEROS_SIMPLE_SHELL_SERVER_SOURCES}
    ${WESTEROS_SIMPLE_SHELL_SERVER_HEADERS})
target_link_libraries(westeros_simpleshell_server_static ${WESTEROS_SIMPLE_SHELL_SERVER_LIBS})
target_include_directories(westeros_simpleshell_server_static PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_server_static PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_server_static PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES})
target_compile_definitions(westeros_simpleshell_server_static PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES_PUBLIC})
add_dependencies(westeros_simpleshell_server_static westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_server_static)
set_target_properties(westeros_simpleshell_server_static PROPERTIES OUTPUT_NAME westeros_simpleshell_server)
show_target_properties(westeros_simpleshell_server_static)

install(FILES simpleshell/westeros-simpleshell.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

## compositor

set(WESTEROS_COMPOSITOR_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-nested.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc-protocol.c)
set(WESTEROS_COMPOSITOR_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.h
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.h
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc-client-protocol.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/westeros-simpleshell.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-client-protocol.h)
set(WESTEROS_COMPOSITOR_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_COMPOSITOR_LIBS
    wayland-client
    wayland-server
    xkbcommon
    westeros_simpleshell_server_shared
    pthread
    dl)
set(WESTEROS_COMPOSITOR_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol)
set(WESTEROS_COMPOSITOR_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_COMPOSITOR_DEFINES )
set(WESTEROS_COMPOSITOR_DEFINES_PUBLIC ${STANDARD_DEFINES})

if (NOT USE_GLEW)
    set(WESTEROS_COMPOSITOR_DEFINES ${WESTEROS_COMPOSITOR_DEFINES} WESTEROS_PLATFORM_EMBEDDED)
endif()
if (HAVE_WAYLAND_EGL)
    set(WESTEROS_COMPOSITOR_DEFINES ${WESTEROS_COMPOSITOR_DEFINES} WESTEROS_HAVE_WAYLAND_EGL)
    set(WESTEROS_COMPOSITOR_LIBS ${WESTEROS_COMPOSITOR_LIBS} wayland-egl GLESv2)
else()
    set(WESTEROS_COMPOSITOR_LIBS ${WESTEROS_COMPOSITOR_LIBS} westeros_egl)
endif()
if (ENABLE_WESTEROS_SBPROTOCOL)
    set(WESTEROS_COMPOSITOR_DEFINES ${WESTEROS_COMPOSITOR_DEFINES} ENABLE_SBPROTOCOL)
    set(WESTEROS_RENDER_EMBEDDED_HEADERS ${WESTEROS_RENDER_EMBEDDED_HEADERS}
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer.h
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-client-protocol.h)
    set(WESTEROS_COMPOSITOR_LIBS ${WESTEROS_COMPOSITOR_LIBS} westeros_simplebuffer_server_shared)
endif()

if (ENABLE_XDG_V4)
    set(WESTEROS_COMPOSITOR_DEFINES ${WESTEROS_COMPOSITOR_DEFINES} USE_XDG_VERSION4)
    set(WESTEROS_COMPOSITOR_SOURCES ${WESTEROS_COMPOSITOR_SOURCES} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell-protocol.c)
    set(WESTEROS_COMPOSITOR_HEADERS ${WESTEROS_COMPOSITOR_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell-server-protocol.h)
    set(WESTEROS_COMPOSITOR_INCLUDE_DIRS ${WESTEROS_COMPOSITOR_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4)
endif()

if (ENABLE_XDG_V5)
    set(WESTEROS_COMPOSITOR_DEFINES ${WESTEROS_COMPOSITOR_DEFINES} USE_XDG_VERSION5)
    set(WESTEROS_COMPOSITOR_SOURCES ${WESTEROS_COMPOSITOR_SOURCES} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell-protocol.c)
    set(WESTEROS_COMPOSITOR_HEADERS ${WESTEROS_COMPOSITOR_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell-server-protocol.h)
    set(WESTEROS_COMPOSITOR_INCLUDE_DIRS ${WESTEROS_COMPOSITOR_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5)
endif()

add_library(westeros_compositor_shared SHARED
    ${WESTEROS_COMPOSITOR_SOURCES}
    ${WESTEROS_COMPOSITOR_HEADERS})
target_link_libraries(westeros_compositor_shared ${WESTEROS_COMPOSITOR_LIBS})
target_include_directories(westeros_compositor_shared PRIVATE ${WESTEROS_COMPOSITOR_INCLUDE_DIRS})
target_include_directories(westeros_compositor_shared PUBLIC ${WESTEROS_COMPOSITOR_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_compositor_shared PRIVATE ${WESTEROS_COMPOSITOR_DEFINES})
target_compile_definitions(westeros_compositor_shared PUBLIC ${WESTEROS_COMPOSITOR_DEFINES_PUBLIC})
if (ENABLE_WESTEROS_SBPROTOCOL)
    add_dependencies(westeros_compositor_shared westeros_simplebuffer_server_shared)
endif()
if (ENABLE_XDG_V4)
    add_dependencies(westeros_compositor_shared westeros-xdgshell-v4-protocol)
endif()

if (ENABLE_XDG_V5)
    add_dependencies(westeros_compositor_shared westeros-xdgshell-v5-protocol)
endif()
add_dependencies(westeros_compositor_shared westeros-vpc-protocol westeros_simpleshell_server_shared)
setup_target_properties_library(westeros_compositor_shared)
set_target_properties(westeros_compositor_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_compositor_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_compositor_shared PROPERTIES OUTPUT_NAME westeros_compositor)
show_target_properties(westeros_compositor_shared)

add_library(westeros_compositor_static STATIC
    ${WESTEROS_COMPOSITOR_SOURCES}
    ${WESTEROS_COMPOSITOR_HEADERS})
target_link_libraries(westeros_compositor_static ${WESTEROS_COMPOSITOR_LIBS})
target_include_directories(westeros_compositor_static PRIVATE ${WESTEROS_COMPOSITOR_INCLUDE_DIRS})
target_include_directories(westeros_compositor_static PUBLIC ${WESTEROS_COMPOSITOR_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_compositor_static PRIVATE ${WESTEROS_COMPOSITOR_DEFINES})
target_compile_definitions(westeros_compositor_static PUBLIC ${WESTEROS_COMPOSITOR_DEFINES_PUBLIC})
if (ENABLE_WESTEROS_SBPROTOCOL)
    add_dependencies(westeros_compositor_static westeros_simplebuffer_server_static)
endif()
if (ENABLE_XDG_V4)
    add_dependencies(westeros_compositor_static westeros-xdgshell-v4-protocol)
endif()

if (ENABLE_XDG_V5)
    add_dependencies(westeros_compositor_static westeros-xdgshell-v5-protocol)
endif()
add_dependencies(westeros_compositor_static westeros-vpc-protocol westeros_simpleshell_server_static)
setup_target_properties_library(westeros_compositor_static)
set_target_properties(westeros_compositor_static PROPERTIES OUTPUT_NAME westeros_compositor)
show_target_properties(westeros_compositor_static)

configure_file(westeros-compositor.pc.in ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.pc)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.pc
    DESTINATION ${CMAKE_PKG_CONFIG_PATH})
install(FILES westeros-compositor.h westeros-render.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

## westeros_gl

if (NOT USE_GLEW)
    set(WESTEROS_GL_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.c)
    set(WESTEROS_GL_HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h)
    set(WESTEROS_GL_LIB_DIRS ${STANDARD_LIB_DIRS})
    set(WESTEROS_GL_LIBS
        drm
        gbm)
    set(WESTEROS_GL_INCLUDE_DIRS
        ${includedir}/libdrm)
    set(WESTEROS_GL_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
    set(WESTEROS_GL_DEFINES _GNU_SOURCE)
    set(WESTEROS_GL_DEFINES_PUBLIC ${STANDARD_DEFINES})

    add_library(westeros_gl_shared SHARED
        ${WESTEROS_GL_SOURCES}
        ${WESTEROS_GL_HEADERS})
    target_link_libraries(westeros_gl_shared ${WESTEROS_GL_LIBS})
    target_include_directories(westeros_gl_shared PRIVATE ${WESTEROS_GL_INCLUDE_DIRS})
    target_include_directories(westeros_gl_shared PUBLIC ${WESTEROS_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_gl_shared PRIVATE ${WESTEROS_GL_DEFINES})
    target_compile_definitions(westeros_gl_shared PUBLIC ${WESTEROS_GL_DEFINES_PUBLIC})
    setup_target_properties_library(westeros_gl_shared)
    set_target_properties(westeros_gl_shared PROPERTIES SOVERSION 1)
    set_target_properties(westeros_gl_shared PROPERTIES VERSION ${PACKAGE_VERSION})
    set_target_properties(westeros_gl_shared PROPERTIES OUTPUT_NAME westeros_gl)
    show_target_properties(westeros_gl_shared)

    add_library(westeros_gl_static STATIC
        ${WESTEROS_GL_SOURCES}
        ${WESTEROS_GL_HEADERS})
    target_link_libraries(westeros_gl_static ${WESTEROS_GL_LIBS})
    target_include_directories(westeros_gl_static PRIVATE ${WESTEROS_GL_INCLUDE_DIRS})
    target_include_directories(westeros_gl_static PUBLIC ${WESTEROS_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_gl_static PRIVATE ${WESTEROS_GL_DEFINES})
    target_compile_definitions(westeros_gl_static PUBLIC ${WESTEROS_GL_DEFINES_PUBLIC})
    setup_target_properties_library(westeros_gl_static)
    set_target_properties(westeros_gl_static PROPERTIES OUTPUT_NAME westeros_gl)
    show_target_properties(westeros_gl_static)
    install(FILES drm/westeros-gl/westeros-gl.h
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
endif()

## render-embedded

set(WESTEROS_RENDER_EMBEDDED_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render-embedded.cpp)
set(WESTEROS_RENDER_EMBEDDED_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.h)
set(WESTEROS_RENDER_EMBEDDED_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_RENDER_EMBEDDED_LIBS
    wayland-client
    wayland-server
    xkbcommon
    westeros_simpleshell_server_shared
    pthread
    dl)
set(WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
set(WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_RENDER_EMBEDDED_DEFINES )
set(WESTEROS_RENDER_EMBEDDED_DEFINES_PUBLIC ${STANDARD_DEFINES})

if (USE_GLEW)
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} EGL glut GL GLEW wayland-server)
else()
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} EGL westeros_gl_shared wayland-server)
    set(WESTEROS_RENDER_EMBEDDED_DEFINES ${WESTEROS_RENDER_EMBEDDED_DEFINES} WESTEROS_PLATFORM_EMBEDDED)
    set(WESTEROS_RENDER_EMBEDDED_HEADERS ${WESTEROS_RENDER_EMBEDDED_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h)
    set(WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl)
endif()
if (NOT USE_GLEW AND HAVE_WAYLAND_EGL)
    set(WESTEROS_RENDER_EMBEDDED_DEFINES ${WESTEROS_RENDER_EMBEDDED_DEFINES} WESTEROS_HAVE_WAYLAND_EGL)
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} wayland-egl GLESv2)
else()
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} westeros_egl)
endif()
if (ENABLE_WESTEROS_SBPROTOCOL)
    set(WESTEROS_RENDER_EMBEDDED_DEFINES ${WESTEROS_RENDER_EMBEDDED_DEFINES} ENABLE_SBPROTOCOL)
    set(WESTEROS_RENDER_EMBEDDED_HEADERS ${WESTEROS_RENDER_EMBEDDED_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer)
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} westeros_simplebuffer_server_shared)
endif()

add_library(westeros_render_embedded_shared SHARED
    ${WESTEROS_RENDER_EMBEDDED_SOURCES}
    ${WESTEROS_RENDER_EMBEDDED_HEADERS})
target_link_libraries(westeros_render_embedded_shared ${WESTEROS_RENDER_EMBEDDED_LIBS})
target_include_directories(westeros_render_embedded_shared PRIVATE ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS})
target_include_directories(westeros_render_embedded_shared PUBLIC ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_render_embedded_shared PRIVATE ${WESTEROS_RENDER_EMBEDDED_DEFINES})
target_compile_definitions(westeros_render_embedded_shared PUBLIC ${WESTEROS_RENDER_EMBEDDED_DEFINES_PUBLIC})
if (NOT USE_GLEW)
    add_dependencies(westeros_render_embedded_shared westeros_gl_shared)
endif()
if (ENABLE_WESTEROS_SBPROTOCOL)
    add_dependencies(westeros_render_embedded_shared westeros_simplebuffer_server_shared)
endif()
setup_target_properties_library(westeros_render_embedded_shared)
set_target_properties(westeros_render_embedded_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_render_embedded_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_render_embedded_shared PROPERTIES OUTPUT_NAME westeros_render_embedded)
show_target_properties(westeros_render_embedded_shared)

add_library(westeros_render_embedded_static STATIC
    ${WESTEROS_RENDER_EMBEDDED_SOURCES}
    ${WESTEROS_RENDER_EMBEDDED_HEADERS})
target_link_libraries(westeros_render_embedded_static ${WESTEROS_RENDER_EMBEDDED_LIBS})
target_include_directories(westeros_render_embedded_static PRIVATE ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS})
target_include_directories(westeros_render_embedded_static PUBLIC ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_render_embedded_static PRIVATE ${WESTEROS_RENDER_EMBEDDED_DEFINES})
target_compile_definitions(westeros_render_embedded_static PUBLIC ${WESTEROS_RENDER_EMBEDDED_DEFINES_PUBLIC})
if (NOT USE_GLEW)
    add_dependencies(westeros_render_embedded_static westeros_gl_static)
endif()
if (ENABLE_WESTEROS_SBPROTOCOL)
    add_dependencies(westeros_render_embedded_static westeros_simplebuffer_server_static)
endif()
setup_target_properties_library(westeros_render_embedded_static)
set_target_properties(westeros_render_embedded_static PROPERTIES OUTPUT_NAME westeros_render_embedded)
show_target_properties(westeros_render_embedded_static)

## render-gl

IF (ENABLE_WESTEROS_RENDERERGL)
    set(WESTEROS_RENDER_GL_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render-gl.cpp)
    set(WESTEROS_RENDER_GL_HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.h)
    set(WESTEROS_RENDER_GL_LIB_DIRS ${STANDARD_LIB_DIRS})
    set(WESTEROS_RENDER_GL_LIBS
        wayland-client
        wayland-server
        xkbcommon
        westeros_simpleshell_server_shared
        pthread
        dl)
    set(WESTEROS_RENDER_GL_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
    set(WESTEROS_RENDER_GL_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
    set(WESTEROS_RENDER_GL_DEFINES )
    set(WESTEROS_RENDER_GL_DEFINES_PUBLIC ${STANDARD_DEFINES})

    if (USE_GLEW)
        set(WESTEROS_RENDER_GL_LIBS ${WESTEROS_RENDER_GL_LIBS} EGL GL GLEW wayland-server)
    else()
        set(WESTEROS_RENDER_GL_LIBS ${WESTEROS_RENDER_GL_LIBS} EGL westeros_gl_shared wayland-server)
        set(WESTEROS_RENDER_GL_DEFINES ${WESTEROS_RENDER_GL_DEFINES} WESTEROS_PLATFORM_EMBEDDED)
        set(WESTEROS_RENDER_GL_HEADERS ${WESTEROS_RENDER_GL_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h)
        set(WESTEROS_RENDER_GL_INCLUDE_DIRS ${WESTEROS_RENDER_GL_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl)
    endif()
    if (HAVE_WAYLAND_EGL)
        set(WESTEROS_RENDER_GL_DEFINES ${WESTEROS_RENDER_GL_DEFINES} WESTEROS_HAVE_WAYLAND_EGL)
        set(WESTEROS_RENDER_GL_LIBS ${WESTEROS_RENDER_GL_LIBS} wayland-egl GLESv2)
    else()
        set(WESTEROS_RENDER_GL_LIBS ${WESTEROS_RENDER_GL_LIBS} westeros_egl)
    endif()
    if (ENABLE_WESTEROS_SBPROTOCOL)
        set(WESTEROS_RENDER_GL_DEFINES ${WESTEROS_RENDER_GL_DEFINES} ENABLE_SBPROTOCOL)
        set(WESTEROS_RENDER_GL_HEADERS ${WESTEROS_RENDER_GL_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer)
        set(WESTEROS_RENDER_GL_LIBS ${WESTEROS_RENDER_GL_LIBS} westeros_simplebuffer_server_shared)
    endif()

    add_library(westeros_render_gl_shared SHARED
        ${WESTEROS_RENDER_GL_SOURCES}
        ${WESTEROS_RENDER_GL_HEADERS})
    target_link_libraries(westeros_render_gl_shared ${WESTEROS_RENDER_GL_LIBS})
    target_include_directories(westeros_render_gl_shared PRIVATE ${WESTEROS_RENDER_GL_INCLUDE_DIRS})
    target_include_directories(westeros_render_gl_shared PUBLIC ${WESTEROS_RENDER_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_render_gl_shared PRIVATE ${WESTEROS_RENDER_GL_DEFINES})
    target_compile_definitions(westeros_render_gl_shared PUBLIC ${WESTEROS_RENDER_GL_DEFINES_PUBLIC})
    if (NOT USE_GLEW)
        add_dependencies(westeros_render_gl_shared westeros_gl_shared)
    endif()
    if (ENABLE_WESTEROS_SBPROTOCOL)
        add_dependencies(westeros_render_gl_shared westeros_simplebuffer_server_shared)
    endif()
    setup_target_properties_library(westeros_render_gl_shared)
    set_target_properties(westeros_render_gl_shared PROPERTIES SOVERSION 1)
    set_target_properties(westeros_render_gl_shared PROPERTIES VERSION ${PACKAGE_VERSION})
    set_target_properties(westeros_render_gl_shared PROPERTIES OUTPUT_NAME westeros_render_gl)
    show_target_properties(westeros_render_gl_shared)

    add_library(westeros_render_gl_static STATIC
        ${WESTEROS_RENDER_GL_SOURCES}
        ${WESTEROS_RENDER_GL_HEADERS})
    target_link_libraries(westeros_render_gl_static ${WESTEROS_RENDER_GL_LIBS})
    target_include_directories(westeros_render_gl_static PRIVATE ${WESTEROS_RENDER_GL_INCLUDE_DIRS})
    target_include_directories(westeros_render_gl_static PUBLIC ${WESTEROS_RENDER_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_render_gl_static PRIVATE ${WESTEROS_RENDER_GL_DEFINES})
    target_compile_definitions(westeros_render_gl_static PUBLIC ${WESTEROS_RENDER_GL_DEFINES_PUBLIC})
    if (NOT USE_GLEW)
        add_dependencies(westeros_render_gl_static westeros_gl_static)
    endif()
    if (ENABLE_WESTEROS_SBPROTOCOL)
        add_dependencies(westeros_render_gl_static westeros_simplebuffer_server_static)
    endif()
    setup_target_properties_library(westeros_render_gl_static)
    set_target_properties(westeros_render_gl_static PROPERTIES OUTPUT_NAME westeros_render_gl)
    show_target_properties(westeros_render_gl_static)
endif()


set(WESTEROS_SOC_SOURCES
    drm/westeros-soc/westeros-sink-soc.c)
set(WESTEROS_SOC_HEADERS
    drm/westeros-soc/westeros-sink-soc.h)
#add_library(westeros_soc_shared SHARED
#    ${WESTEROS_RENDER_SOC_SOURCES}
#    ${WESTEROS_RENDER_SOC_HEADERS})
#add_library(westeros_soc_static STATIC
#    ${WESTEROS_SOC_SOURCES}
#    ${WESTEROS_SOC_HEADERS})

set(WESTEROS_SOURCES
    westeros-main.cpp)
set(WESTEROS_HEADERS
    )
#add_executable(westeros
#    ${WESTEROS_SOURCES}
#    ${WESTEROS_HEADERS})

set(WESTEROS_TEST_SOURCES
    westeros-test.cpp)
set(WESTEROS_TEST_HEADERS
    )
#add_executable(westeros_test
#    ${WESTEROS_TEST_SOURCES}
#    ${WESTEROS_TEST_HEADERS})

set(WESTEROS_PLAYER_SOURCES
    westeros-player.cpp)
set(WESTEROS_PLAYER_HEADERS
    )
#add_executable(westeros-player
#    ${WESTEROS_PLAYER_SOURCES}
#    ${WESTEROS_PLAYER_HEADERS})


set(WESTEROS_LINK_LIBS
    -lglut -lGL -lGLEW -lX11 -lEGL)
set(WESTEROS_CXXFLAGS
    -I./include
    -I${CMAKE_SYSROOT}/include/wayland
    ${WAYLAND_CLIENT_CFLAGS}
    ${WAYLAND_SERVER_CFLAGS}
    ${XKBCOMMON_CFLAGS}
    -DWESTEROS_PLATFORM_EMBEDDED
    -DWESTEROS_HAVE_WAYLAND_EGL
    -DENABLE_SBPROTOCOL
    -DUSE_XDG_VERSION4 -I./protocol/version4
    -DUSE_XDG_VERSION5 -I./protocol/version5)
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
