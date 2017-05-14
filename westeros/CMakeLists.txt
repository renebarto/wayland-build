project(westeros)

include(show_target_properties)
include(setup_target_properties_library)
include(setup_target_properties_executable)

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/uninstall.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/uninstall.cmake
    IMMEDIATE @ONLY)

add_custom_target(uninstall_${PROJECT_NAME}
    COMMAND ${CMAKE_COMMAND} -DCOMPONENT=${PROJECT_NAME} -P ${CMAKE_CURRENT_BINARY_DIR}/uninstall.cmake
    COMMENT "Uninstalling ${PROJECT_NAME}")

add_custom_target(install_${PROJECT_NAME}
    COMMAND ${CMAKE_COMMAND} -DCOMPONENT=${PROJECT_NAME} -P ${CMAKE_BINARY_DIR}/cmake_install.cmake
    COMMENT "Installing ${PROJECT_NAME}")

add_dependencies(install-components install_${PROJECT_NAME})

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

set(STANDARD_CXX_FLAGS -g -O2 -fPIC -DPIC)
set(STANDARD_C_FLAGS -g -O2 -fPIC -DPIC)
set(STANDARD_DEFINES HAVE_CONFIG_H _LARGEFILE_SOURCE _LARGEFILE64_SOURCE _FILE_OFFSET_BITS=64)
set(STANDARD_INCLUDE_DIRS . ${includedir} /usr/include /usr/local/include /usr/include/x86_64-linux-gnu)
set(STANDARD_LIB_DIRS . ${libdir} ${LIBRARY_OUTPUT_DIRECTORY} ${ARCHIVE_OUTPUT_DIRECTORY} /usr/lib /usr/local/lib)
if (NOT USE_GLEW)
    set(STANDARD_DEFINES ${STANDARD_DEFINES} WESTEROS_PLATFORM_EMBEDDED)
endif()
if (HAVE_WAYLAND_EGL)
    set(STANDARD_DEFINES ${STANDARD_DEFINES} WESTEROS_HAVE_WAYLAND_EGL)
    set(WESTEROS_EGL_LIBS wayland-egl GLESv2)
else()
    set(WESTEROS_EGL_LIBS westeros_egl)
endif()
if (ENABLE_WESTEROS_SBPROTOCOL)
    set(STANDARD_DEFINES ${STANDARD_DEFINES} ENABLE_SBPROTOCOL)
endif()
if (ENABLE_XDG_V4)
    set(STANDARD_DEFINES ${STANDARD_DEFINES} USE_XDG_VERSION4)
endif()
if (ENABLE_XDG_V5)
    set(STANDARD_DEFINES ${STANDARD_DEFINES} USE_XDG_VERSION5)
endif()

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

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-client-protocol.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    COMPONENT ${PROJECT_NAME})
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    COMPONENT ${PROJECT_NAME})

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

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-client-protocol.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    COMPONENT ${PROJECT_NAME})
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/westeros-simpleshell.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    COMPONENT ${PROJECT_NAME})

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

set(WESTEROS_SIMPLE_BUFFER_CLIENT_C_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-protocol.c)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-client-protocol.h)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_BUFFER_CLIENT_LIBS
    wayland-client
    ffi
    rt
    m)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES )
set(WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES_PUBLIC ${STANDARD_DEFINES})
set(WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_C -pthread)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_C_PUBLIC ${STANDARD_C_FLAGS})
set(WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_CXX -pthread)
set(WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_CXX_PUBLIC ${STANDARD_CXX_FLAGS})

add_library(westeros_simplebuffer_client_shared SHARED
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_C_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS})
target_include_directories(westeros_simplebuffer_client_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_client_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_client_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES})
target_compile_definitions(westeros_simplebuffer_client_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES_PUBLIC})
target_compile_options(westeros_simplebuffer_client_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_C})
target_compile_options(westeros_simplebuffer_client_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simplebuffer_client_shared westeros-simplebuffer-protocol)
target_link_libraries(westeros_simplebuffer_client_shared
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_LIBS})
setup_target_properties_library(westeros_simplebuffer_client_shared)
set_target_properties(westeros_simplebuffer_client_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simplebuffer_client_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simplebuffer_client_shared PROPERTIES OUTPUT_NAME westeros_simplebuffer_client)
show_target_properties(westeros_simplebuffer_client_shared)

add_library(westeros_simplebuffer_client_static STATIC
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_C_SOURCES}
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_HEADERS})
target_include_directories(westeros_simplebuffer_client_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_client_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_client_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES})
target_compile_definitions(westeros_simplebuffer_client_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_DEFINES_PUBLIC})
target_compile_options(westeros_simplebuffer_client_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_C})
target_compile_options(westeros_simplebuffer_client_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_CLIENT_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simplebuffer_client_static westeros-simplebuffer-protocol)
target_link_libraries(westeros_simplebuffer_client_static
    <TARGET_OBJECTS:westeros_simplebuffer_client_simplebuffer_protocol>
    ${WESTEROS_SIMPLE_BUFFER_CLIENT_LIBS})
setup_target_properties_library(westeros_simplebuffer_client_static)
set_target_properties(westeros_simplebuffer_client_static PROPERTIES OUTPUT_NAME westeros_simplebuffer_client)
show_target_properties(westeros_simplebuffer_client_static)

install(TARGETS westeros_simplebuffer_client_shared
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME}
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
install(TARGETS westeros_simplebuffer_client_static
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME})

## simple-buffer server

set(WESTEROS_SIMPLE_BUFFER_SERVER_C_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-protocol.c)
set(WESTEROS_SIMPLE_BUFFER_SERVER_CXX_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer.cpp)
set(WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-server-protocol.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer.h)
set(WESTEROS_SIMPLE_BUFFER_SERVER_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_BUFFER_SERVER_LIBS
    wayland-client
    wayland-server
    ffi
    rt
    stdc++
    m
    c
    gcc_s)
set(WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
set(WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES )
set(WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES_PUBLIC ${STANDARD_DEFINES})
set(WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_C -pthread)
set(WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_C_PUBLIC ${STANDARD_C_FLAGS})
set(WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_CXX -pthread)
set(WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_CXX_PUBLIC ${STANDARD_CXX_FLAGS})

add_library(westeros_simplebuffer_server_cxx_objects OBJECT
    ${WESTEROS_SIMPLE_BUFFER_SERVER_CXX_SOURCES})
target_include_directories(westeros_simplebuffer_server_cxx_objects PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_server_cxx_objects PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_server_cxx_objects PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES})
target_compile_definitions(westeros_simplebuffer_server_cxx_objects PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES_PUBLIC})
target_compile_options(westeros_simplebuffer_server_cxx_objects PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_CXX})
target_compile_options(westeros_simplebuffer_server_cxx_objects PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_CXX_PUBLIC})

add_library(westeros_simplebuffer_server_shared SHARED
    ${WESTEROS_SIMPLE_BUFFER_SERVER_C_SOURCES}
    $<TARGET_OBJECTS:westeros_simplebuffer_server_cxx_objects>
    ${WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS})
target_link_libraries(westeros_simplebuffer_server_shared ${WESTEROS_SIMPLE_BUFFER_SERVER_LIBS})
target_include_directories(westeros_simplebuffer_server_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_server_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_server_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES})
target_compile_definitions(westeros_simplebuffer_server_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES_PUBLIC})
target_compile_options(westeros_simplebuffer_server_shared PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_C})
target_compile_options(westeros_simplebuffer_server_shared PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simplebuffer_server_shared westeros-simplebuffer-protocol)
setup_target_properties_library(westeros_simplebuffer_server_shared)
set_target_properties(westeros_simplebuffer_server_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simplebuffer_server_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simplebuffer_server_shared PROPERTIES OUTPUT_NAME westeros_simplebuffer_server)
show_target_properties(westeros_simplebuffer_server_shared)

add_library(westeros_simplebuffer_server_static STATIC
    ${WESTEROS_SIMPLE_BUFFER_SERVER_C_SOURCES}
    $<TARGET_OBJECTS:westeros_simplebuffer_server_cxx_objects>
    ${WESTEROS_SIMPLE_BUFFER_SERVER_HEADERS})
target_link_libraries(westeros_simplebuffer_server_static ${WESTEROS_SIMPLE_BUFFER_SERVER_LIBS})
target_include_directories(westeros_simplebuffer_server_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simplebuffer_server_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simplebuffer_server_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES})
target_compile_definitions(westeros_simplebuffer_server_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_DEFINES_PUBLIC})
target_compile_options(westeros_simplebuffer_server_static PRIVATE ${WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_C})
target_compile_options(westeros_simplebuffer_server_static PUBLIC ${WESTEROS_SIMPLE_BUFFER_SERVER_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simplebuffer_server_static westeros-simplebuffer-protocol)
setup_target_properties_library(westeros_simplebuffer_server_static)
set_target_properties(westeros_simplebuffer_server_static PROPERTIES OUTPUT_NAME westeros_simplebuffer_server)
show_target_properties(westeros_simplebuffer_server_static)

install(TARGETS westeros_simplebuffer_server_shared
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME}
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
install(TARGETS westeros_simplebuffer_server_static
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME})

## simple-shell client

set(WESTEROS_SIMPLE_SHELL_CLIENT_C_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-protocol.c)
set(WESTEROS_SIMPLE_SHELL_CLIENT_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-client-protocol.h)
set(WESTEROS_SIMPLE_SHELL_CLIENT_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_SHELL_CLIENT_LIBS
    wayland-client
    ffi
    rt
    m)
set(WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol)
set(WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES )
set(WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES_PUBLIC ${STANDARD_DEFINES})
set(WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_C -pthread)
set(WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_C_PUBLIC ${STANDARD_C_FLAGS})
set(WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_CXX -pthread)
set(WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_CXX_PUBLIC ${STANDARD_CXX_FLAGS})

add_library(westeros_simpleshell_client_shared SHARED
    ${WESTEROS_SIMPLE_SHELL_CLIENT_C_SOURCES}
    ${WESTEROS_SIMPLE_SHELL_CLIENT_HEADERS})
target_link_libraries(westeros_simpleshell_client_shared ${WESTEROS_SIMPLE_SHELL_CLIENT_LIBS})
target_include_directories(westeros_simpleshell_client_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_client_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_client_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES})
target_compile_definitions(westeros_simpleshell_client_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES_PUBLIC})
target_compile_options(westeros_simpleshell_client_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_C})
target_compile_options(westeros_simpleshell_client_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simpleshell_client_shared westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_client_shared)
set_target_properties(westeros_simpleshell_client_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simpleshell_client_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simpleshell_client_shared PROPERTIES OUTPUT_NAME westeros_simpleshell_client)
show_target_properties(westeros_simpleshell_client_shared)

add_library(westeros_simpleshell_client_static STATIC
    ${WESTEROS_SIMPLE_SHELL_CLIENT_C_SOURCES}
    ${WESTEROS_SIMPLE_SHELL_CLIENT_HEADERS})
target_link_libraries(westeros_simpleshell_client_static ${WESTEROS_SIMPLE_SHELL_CLIENT_LIBS})
target_include_directories(westeros_simpleshell_client_static PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_client_static PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_client_static PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES})
target_compile_definitions(westeros_simpleshell_client_static PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_DEFINES_PUBLIC})
target_compile_options(westeros_simpleshell_client_static PRIVATE ${WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_C})
target_compile_options(westeros_simpleshell_client_static PUBLIC ${WESTEROS_SIMPLE_SHELL_CLIENT_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simpleshell_client_static westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_client_static)
set_target_properties(westeros_simpleshell_client_static PROPERTIES OUTPUT_NAME westeros_simpleshell_client)
show_target_properties(westeros_simpleshell_client_static)

install(TARGETS westeros_simpleshell_client_shared
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME}
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
install(TARGETS westeros_simpleshell_client_static
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME})

## simple-shell server

set(WESTEROS_SIMPLE_SHELL_SERVER_C_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-protocol.c)
set(WESTEROS_SIMPLE_SHELL_SERVER_CXX_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/westeros-simpleshell.cpp)
set(WESTEROS_SIMPLE_SHELL_SERVER_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-server-protocol.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/westeros-simpleshell.h)
set(WESTEROS_SIMPLE_SHELL_SERVER_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_SIMPLE_SHELL_SERVER_LIBS
    wayland-client
    wayland-server
    ffi
    rt
    stdc++
    m
    c
    gcc_s)
set(WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol)
set(WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_SIMPLE_SHELL_SERVER_DEFINES )
set(WESTEROS_SIMPLE_SHELL_SERVER_DEFINES_PUBLIC ${STANDARD_DEFINES})
set(WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_C -pthread)
set(WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_C_PUBLIC ${STANDARD_C_FLAGS})
set(WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_CXX -pthread)
set(WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_CXX_PUBLIC ${STANDARD_CXX_FLAGS})

add_library(westeros_simpleshell_server_cxx_objects OBJECT
    ${WESTEROS_SIMPLE_SHELL_SERVER_CXX_SOURCES})
target_include_directories(westeros_simpleshell_server_cxx_objects PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_server_cxx_objects PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_server_cxx_objects PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES})
target_compile_definitions(westeros_simpleshell_server_cxx_objects PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES_PUBLIC})
target_compile_options(westeros_simpleshell_server_cxx_objects PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_CXX})
target_compile_options(westeros_simpleshell_server_cxx_objects PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_CXX_PUBLIC})

add_library(westeros_simpleshell_server_shared SHARED
    ${WESTEROS_SIMPLE_SHELL_SERVER_C_SOURCES}
    $<TARGET_OBJECTS:westeros_simpleshell_server_cxx_objects>
    ${WESTEROS_SIMPLE_SHELL_SERVER_HEADERS})
target_link_libraries(westeros_simpleshell_server_shared ${WESTEROS_SIMPLE_SHELL_SERVER_LIBS})
target_include_directories(westeros_simpleshell_server_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_server_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_server_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES})
target_compile_definitions(westeros_simpleshell_server_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES_PUBLIC})
target_compile_options(westeros_simpleshell_server_shared PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_C})
target_compile_options(westeros_simpleshell_server_shared PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simpleshell_server_shared westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_server_shared)
set_target_properties(westeros_simpleshell_server_shared PROPERTIES SOVERSION 1)
set_target_properties(westeros_simpleshell_server_shared PROPERTIES VERSION ${PACKAGE_VERSION})
set_target_properties(westeros_simpleshell_server_shared PROPERTIES OUTPUT_NAME westeros_simpleshell_server)
show_target_properties(westeros_simpleshell_server_shared)

add_library(westeros_simpleshell_server_static STATIC
    ${WESTEROS_SIMPLE_SHELL_SERVER_C_SOURCES}
    $<TARGET_OBJECTS:westeros_simpleshell_server_cxx_objects>
    ${WESTEROS_SIMPLE_SHELL_SERVER_HEADERS})
target_link_libraries(westeros_simpleshell_server_static ${WESTEROS_SIMPLE_SHELL_SERVER_LIBS})
target_include_directories(westeros_simpleshell_server_static PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS})
target_include_directories(westeros_simpleshell_server_static PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_simpleshell_server_static PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES})
target_compile_definitions(westeros_simpleshell_server_static PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_DEFINES_PUBLIC})
target_compile_options(westeros_simpleshell_server_static PRIVATE ${WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_C})
target_compile_options(westeros_simpleshell_server_static PUBLIC ${WESTEROS_SIMPLE_SHELL_SERVER_OPTIONS_C_PUBLIC})
add_dependencies(westeros_simpleshell_server_static westeros-simpleshell-protocol)
setup_target_properties_library(westeros_simpleshell_server_static)
set_target_properties(westeros_simpleshell_server_static PROPERTIES OUTPUT_NAME westeros_simpleshell_server)
show_target_properties(westeros_simpleshell_server_static)

install(TARGETS westeros_simpleshell_server_shared
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME}
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
install(TARGETS westeros_simpleshell_server_static
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME})

## westeros_gl

if (NOT USE_GLEW)
    set(WESTEROS_GL_C_SOURCES
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
    set(WESTEROS_GL_OPTIONS_C -pthread)
    set(WESTEROS_GL_OPTIONS_C_PUBLIC ${STANDARD_C_FLAGS})
    set(WESTEROS_GL_OPTIONS_CXX -pthread)
    set(WESTEROS_GL_OPTIONS_CXX_PUBLIC ${STANDARD_CXX_FLAGS})

    add_library(westeros_gl_shared SHARED
        ${WESTEROS_GL_C_SOURCES}
        ${WESTEROS_GL_HEADERS})
    target_link_libraries(westeros_gl_shared ${WESTEROS_GL_LIBS})
    target_include_directories(westeros_gl_shared PRIVATE ${WESTEROS_GL_INCLUDE_DIRS})
    target_include_directories(westeros_gl_shared PUBLIC ${WESTEROS_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_gl_shared PRIVATE ${WESTEROS_GL_DEFINES})
    target_compile_definitions(westeros_gl_shared PUBLIC ${WESTEROS_GL_DEFINES_PUBLIC})
    target_compile_options(westeros_gl_shared PRIVATE ${WESTEROS_GL_OPTIONS_C})
    target_compile_options(westeros_gl_shared PUBLIC ${WESTEROS_GL_OPTIONS_C_PUBLIC})
    setup_target_properties_library(westeros_gl_shared)
    set_target_properties(westeros_gl_shared PROPERTIES SOVERSION 1)
    set_target_properties(westeros_gl_shared PROPERTIES VERSION ${PACKAGE_VERSION})
    set_target_properties(westeros_gl_shared PROPERTIES OUTPUT_NAME westeros_gl)
    show_target_properties(westeros_gl_shared)

    add_library(westeros_gl_static STATIC
        ${WESTEROS_GL_C_SOURCES}
        ${WESTEROS_GL_HEADERS})
    target_link_libraries(westeros_gl_static ${WESTEROS_GL_LIBS})
    target_include_directories(westeros_gl_static PRIVATE ${WESTEROS_GL_INCLUDE_DIRS})
    target_include_directories(westeros_gl_static PUBLIC ${WESTEROS_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_gl_static PRIVATE ${WESTEROS_GL_DEFINES})
    target_compile_definitions(westeros_gl_static PUBLIC ${WESTEROS_GL_DEFINES_PUBLIC})
    target_compile_options(westeros_gl_static PRIVATE ${WESTEROS_GL_OPTIONS_C})
    target_compile_options(westeros_gl_static PUBLIC ${WESTEROS_GL_OPTIONS_C_PUBLIC})
    setup_target_properties_library(westeros_gl_static)
    set_target_properties(westeros_gl_static PROPERTIES OUTPUT_NAME westeros_gl)
    show_target_properties(westeros_gl_static)
    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include
        COMPONENT ${PROJECT_NAME})
    install(TARGETS westeros_gl_shared
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        COMPONENT ${PROJECT_NAME}
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
    install(TARGETS westeros_gl_static
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        COMPONENT ${PROJECT_NAME})
endif()

## compositor

set(WESTEROS_COMPOSITOR_C_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc-protocol.c)
set(WESTEROS_COMPOSITOR_CXX_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-nested.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.cpp)
set(WESTEROS_COMPOSITOR_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.h
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.h
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol/vpc-client-protocol.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/westeros-simpleshell.h
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-client-protocol.h)
set(WESTEROS_COMPOSITOR_LIB_DIRS ${STANDARD_LIB_DIRS})
set(WESTEROS_COMPOSITOR_LIBS
    wayland-egl
    xkbcommon
    westeros_simpleshell_server_shared
    pthread
    dl)
if (ENABLE_WESTEROS_SBPROTOCOL)
    set(WESTEROS_COMPOSITOR_LIBS ${WESTEROS_COMPOSITOR_LIBS} westeros_simplebuffer_server_shared)
endif()
set(WESTEROS_COMPOSITOR_LIBS ${WESTEROS_COMPOSITOR_LIBS}
    wayland-client
    wayland-server
    ffi
    stdc++
    m
    c
    gcc_s)

set(WESTEROS_COMPOSITOR_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell
    ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol
    ${CMAKE_CURRENT_SOURCE_DIR}/protocol)
set(WESTEROS_COMPOSITOR_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_COMPOSITOR_DEFINES WESTEROS_PLATFORM_DRM)
set(WESTEROS_COMPOSITOR_DEFINES_PUBLIC ${STANDARD_DEFINES})
set(WESTEROS_COMPOSITOR_OPTIONS_C -pthread)
set(WESTEROS_COMPOSITOR_OPTIONS_C_PUBLIC ${STANDARD_C_FLAGS})
set(WESTEROS_COMPOSITOR_OPTIONS_CXX -pthread)
set(WESTEROS_COMPOSITOR_OPTIONS_CXX_PUBLIC ${STANDARD_CXX_FLAGS})

if (ENABLE_XDG_V4)
    set(WESTEROS_COMPOSITOR_C_SOURCES ${WESTEROS_COMPOSITOR_C_SOURCES} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell-protocol.c)
    set(WESTEROS_COMPOSITOR_HEADERS ${WESTEROS_COMPOSITOR_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell-server-protocol.h)
    set(WESTEROS_COMPOSITOR_INCLUDE_DIRS ${WESTEROS_COMPOSITOR_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4)
endif()

if (ENABLE_XDG_V5)
    set(WESTEROS_COMPOSITOR_C_SOURCES ${WESTEROS_COMPOSITOR_C_SOURCES} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell-protocol.c)
    set(WESTEROS_COMPOSITOR_HEADERS ${WESTEROS_COMPOSITOR_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell-server-protocol.h)
    set(WESTEROS_COMPOSITOR_INCLUDE_DIRS ${WESTEROS_COMPOSITOR_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5)
endif()

if (ENABLE_WESTEROS_SBPROTOCOL)
    set(WESTEROS_RENDER_EMBEDDED_HEADERS ${WESTEROS_RENDER_EMBEDDED_HEADERS}
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer.h
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol/simplebuffer-client-protocol.h)
    set(WESTEROS_COMPOSITOR_LIBS ${WESTEROS_COMPOSITOR_LIBS} westeros_simplebuffer_server_shared)
endif()

add_library(westeros_compositor_cxx_objects OBJECT
    ${WESTEROS_COMPOSITOR_CXX_SOURCES})
target_include_directories(westeros_compositor_cxx_objects PRIVATE ${WESTEROS_COMPOSITOR_INCLUDE_DIRS})
target_include_directories(westeros_compositor_cxx_objects PUBLIC ${WESTEROS_COMPOSITOR_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_compositor_cxx_objects PRIVATE ${WESTEROS_COMPOSITOR_DEFINES})
target_compile_definitions(westeros_compositor_cxx_objects PUBLIC ${WESTEROS_COMPOSITOR_DEFINES_PUBLIC})
target_compile_options(westeros_compositor_cxx_objects PRIVATE ${WESTEROS_COMPOSITOR_OPTIONS_CXX})
target_compile_options(westeros_compositor_cxx_objects PUBLIC ${WESTEROS_COMPOSITOR_OPTIONS_CXX_PUBLIC})

add_library(westeros_compositor_shared SHARED
    ${WESTEROS_COMPOSITOR_C_SOURCES}
    $<TARGET_OBJECTS:westeros_compositor_cxx_objects>
    ${WESTEROS_COMPOSITOR_HEADERS})
target_link_libraries(westeros_compositor_shared ${WESTEROS_COMPOSITOR_LIBS})
target_include_directories(westeros_compositor_shared PRIVATE ${WESTEROS_COMPOSITOR_INCLUDE_DIRS})
target_include_directories(westeros_compositor_shared PUBLIC ${WESTEROS_COMPOSITOR_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_compositor_shared PRIVATE ${WESTEROS_COMPOSITOR_DEFINES})
target_compile_definitions(westeros_compositor_shared PUBLIC ${WESTEROS_COMPOSITOR_DEFINES_PUBLIC})
target_compile_options(westeros_compositor_shared PRIVATE ${WESTEROS_COMPOSITOR_OPTIONS_C})
target_compile_options(westeros_compositor_shared PUBLIC ${WESTEROS_COMPOSITOR_OPTIONS_C_PUBLIC})
set_target_properties(westeros_compositor_shared PROPERTIES LINK_FLAGS -nostdlib)
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
    ${WESTEROS_COMPOSITOR_C_SOURCES}
    $<TARGET_OBJECTS:westeros_compositor_cxx_objects>
    ${WESTEROS_COMPOSITOR_HEADERS})
target_link_libraries(westeros_compositor_static ${WESTEROS_COMPOSITOR_LIBS})
target_include_directories(westeros_compositor_static PRIVATE ${WESTEROS_COMPOSITOR_INCLUDE_DIRS})
target_include_directories(westeros_compositor_static PUBLIC ${WESTEROS_COMPOSITOR_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_compositor_static PRIVATE ${WESTEROS_COMPOSITOR_DEFINES})
target_compile_definitions(westeros_compositor_static PUBLIC ${WESTEROS_COMPOSITOR_DEFINES_PUBLIC})
target_compile_options(westeros_compositor_static PRIVATE ${WESTEROS_COMPOSITOR_OPTIONS_C})
target_compile_options(westeros_compositor_static PUBLIC ${WESTEROS_COMPOSITOR_OPTIONS_C_PUBLIC})
set_target_properties(westeros_compositor_static PROPERTIES LINK_FLAGS -nostdlib)
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
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/pkgconfig
    COMPONENT ${PROJECT_NAME})
install(FILES westeros-compositor.h westeros-render.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    COMPONENT ${PROJECT_NAME})
install(TARGETS westeros_compositor_shared
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME}
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
install(TARGETS westeros_compositor_static
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME})

## render-embedded

set(WESTEROS_RENDER_EMBEDDED_CXX_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render-embedded.cpp)
set(WESTEROS_RENDER_EMBEDDED_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.h)
set(WESTEROS_RENDER_EMBEDDED_LIB_DIRS ${STANDARD_LIB_DIRS})
if (USE_GLEW)
    set(WESTEROS_RENDER_EMBEDDED_LIBS
        EGL
        glut
        GL
        GLEW
        pthread
        gbm
        expat
        dl
        drm
        gbm
        wayland-client
        wayland-server      # WAYLAND_SERVER_LIBS
        ffi
        rt
        stdc++
        m
        c
        gcc_s)
else()
    set(WESTEROS_RENDER_EMBEDDED_LIBS
        ${WESTEROS_EGL_LIBS}
        glapi
        EGL
        pthread
        gbm
        expat
        dl
        westeros_gl_shared
        drm
        gbm
        wayland-client
        wayland-server      # WAYLAND_SERVER_LIBS
        ffi
        rt
        stdc++
        m
        c
        gcc_s)
endif()
set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS}
    westeros_simplebuffer_server_shared)
set(WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer
    ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
set(WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
set(WESTEROS_RENDER_EMBEDDED_DEFINES WESTEROS_PLATFORM_DRM)
set(WESTEROS_RENDER_EMBEDDED_DEFINES_PUBLIC ${STANDARD_DEFINES})

if (NOT USE_GLEW)
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} EGL westeros_gl_shared wayland-server)
    set(WESTEROS_RENDER_EMBEDDED_HEADERS ${WESTEROS_RENDER_EMBEDDED_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h)
    set(WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl)
endif()
if (NOT USE_GLEW AND HAVE_WAYLAND_EGL)
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} wayland-egl GLESv2)
else()
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} westeros_egl)
endif()
if (ENABLE_WESTEROS_SBPROTOCOL)
    set(WESTEROS_RENDER_EMBEDDED_HEADERS ${WESTEROS_RENDER_EMBEDDED_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer)
    set(WESTEROS_RENDER_EMBEDDED_LIBS ${WESTEROS_RENDER_EMBEDDED_LIBS} westeros_simplebuffer_server_shared)
endif()
add_library(westeros_render_embedded_shared SHARED
    ${WESTEROS_RENDER_EMBEDDED_CXX_SOURCES}
    ${WESTEROS_RENDER_EMBEDDED_HEADERS})
target_link_libraries(westeros_render_embedded_shared ${WESTEROS_RENDER_EMBEDDED_LIBS})
target_include_directories(westeros_render_embedded_shared PRIVATE ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS})
target_include_directories(westeros_render_embedded_shared PUBLIC ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_render_embedded_shared PRIVATE ${WESTEROS_RENDER_EMBEDDED_DEFINES})
target_compile_definitions(westeros_render_embedded_shared PUBLIC ${WESTEROS_RENDER_EMBEDDED_DEFINES_PUBLIC})
target_compile_options(westeros_render_embedded_shared PRIVATE ${WESTEROS_RENDER_EMBEDDED_OPTIONS_CXX})
target_compile_options(westeros_render_embedded_shared PUBLIC ${WESTEROS_RENDER_EMBEDDED_OPTIONS_CXX_PUBLIC})
set_target_properties(westeros_render_embedded_shared PROPERTIES LINK_FLAGS -nostdlib)
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
    ${WESTEROS_RENDER_EMBEDDED_CXX_SOURCES}
    ${WESTEROS_RENDER_EMBEDDED_HEADERS})
target_link_libraries(westeros_render_embedded_static ${WESTEROS_RENDER_EMBEDDED_LIBS})
target_include_directories(westeros_render_embedded_static PRIVATE ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS})
target_include_directories(westeros_render_embedded_static PUBLIC ${WESTEROS_RENDER_EMBEDDED_INCLUDE_DIRS_PUBLIC})
target_compile_definitions(westeros_render_embedded_static PRIVATE ${WESTEROS_RENDER_EMBEDDED_DEFINES})
target_compile_definitions(westeros_render_embedded_static PUBLIC ${WESTEROS_RENDER_EMBEDDED_DEFINES_PUBLIC})
target_compile_options(westeros_render_embedded_static PRIVATE ${WESTEROS_RENDER_EMBEDDED_OPTIONS_CXX})
target_compile_options(westeros_render_embedded_static PUBLIC ${WESTEROS_RENDER_EMBEDDED_OPTIONS_CXX_PUBLIC})
set_target_properties(westeros_render_embedded_static PROPERTIES LINK_FLAGS -nostdlib)
if (NOT USE_GLEW)
    add_dependencies(westeros_render_embedded_static westeros_gl_static)
endif()
if (ENABLE_WESTEROS_SBPROTOCOL)
    add_dependencies(westeros_render_embedded_static westeros_simplebuffer_server_static)
endif()
setup_target_properties_library(westeros_render_embedded_static)
set_target_properties(westeros_render_embedded_static PROPERTIES OUTPUT_NAME westeros_render_embedded)
show_target_properties(westeros_render_embedded_static)

install(TARGETS westeros_render_embedded_shared
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME}
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
install(TARGETS westeros_render_embedded_static
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT ${PROJECT_NAME})

## render-gl

IF (ENABLE_WESTEROS_RENDERERGL)
    set(WESTEROS_RENDER_GL_CXX_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render-gl.cpp)
    set(WESTEROS_RENDER_GL_HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-render.h)
    set(WESTEROS_RENDER_GL_LIB_DIRS ${STANDARD_LIB_DIRS})
    if (USE_GLEW)
        set(WESTEROS_RENDER_GL_LIBS
            ${WESTEROS_EGL_LIBS}
            glapi
            EGL
            GL
            GLEW
            pthread
            gbm
            expat
            drm
            gbm)
    else()
        set(WESTEROS_RENDER_GL_LIBS
            ${WESTEROS_EGL_LIBS}
            glapi
            EGL
            pthread
            gbm
            expat
            westeros_gl_shared
            drm
            gbm)
    endif()
    if (ENABLE_WESTEROS_SBPROTOCOL)
        set(WESTEROS_RENDER_GL_LIBS ${WESTEROS_RENDER_GL_LIBS} westeros_simplebuffer_server_shared)
    endif()
    set(WESTEROS_RENDER_GL_LIBS ${WESTEROS_RENDER_GL_LIBS}
        wayland-client
        wayland-server
        ffi
        rt
        stdc++
        m
        c
        gcc_s)
    set(WESTEROS_RENDER_GL_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer
        ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/protocol)
    set(WESTEROS_RENDER_GL_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
    set(WESTEROS_RENDER_GL_DEFINES WESTEROS_PLATFORM_DRM)
    set(WESTEROS_RENDER_GL_DEFINES_PUBLIC ${STANDARD_DEFINES})

    if (NOT USE_GLEW)
        set(WESTEROS_RENDER_GL_HEADERS ${WESTEROS_RENDER_GL_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h)
        set(WESTEROS_RENDER_GL_INCLUDE_DIRS ${WESTEROS_RENDER_GL_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl)
    endif()
    if (ENABLE_WESTEROS_SBPROTOCOL)
        set(WESTEROS_RENDER_GL_INCLUDE_DIRS ${WESTEROS_RENDER_GL_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer)
    endif()

    add_library(westeros_render_gl_shared SHARED
        ${WESTEROS_RENDER_GL_CXX_SOURCES}
        ${WESTEROS_RENDER_GL_HEADERS})
    target_link_libraries(westeros_render_gl_shared ${WESTEROS_RENDER_GL_LIBS})
    target_include_directories(westeros_render_gl_shared PRIVATE ${WESTEROS_RENDER_GL_INCLUDE_DIRS})
    target_include_directories(westeros_render_gl_shared PUBLIC ${WESTEROS_RENDER_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_render_gl_shared PRIVATE ${WESTEROS_RENDER_GL_DEFINES})
    target_compile_definitions(westeros_render_gl_shared PUBLIC ${WESTEROS_RENDER_GL_DEFINES_PUBLIC})
    target_compile_options(westeros_render_gl_shared PRIVATE ${WESTEROS_RENDER_GL_OPTIONS_CXX})
    target_compile_options(westeros_render_gl_shared PUBLIC ${WESTEROS_RENDER_GL_OPTIONS_CXX_PUBLIC})
    set_target_properties(westeros_render_gl_shared PROPERTIES LINK_FLAGS -nostdlib)
    if (NOT USE_GLEW)
        add_dependencies(westeros_render_gl_shared westeros_gl_shared)
    endif()
    if (ENABLE_WESTEROS_SBPROTOCOL)
        add_dependencies(westeros_render_gl_shared westeros_simplebuffer_server_shared)
    endif()
    add_dependencies(westeros_render_gl_shared libxkbcommon-0.7.1)

    setup_target_properties_library(westeros_render_gl_shared)
    set_target_properties(westeros_render_gl_shared PROPERTIES SOVERSION 1)
    set_target_properties(westeros_render_gl_shared PROPERTIES VERSION ${PACKAGE_VERSION})
    set_target_properties(westeros_render_gl_shared PROPERTIES OUTPUT_NAME westeros_render_gl)
    show_target_properties(westeros_render_gl_shared)

    add_library(westeros_render_gl_static STATIC
        ${WESTEROS_RENDER_GL_CXX_SOURCES}
        ${WESTEROS_RENDER_GL_HEADERS})
    target_link_libraries(westeros_render_gl_static ${WESTEROS_RENDER_GL_LIBS})
    target_include_directories(westeros_render_gl_static PRIVATE ${WESTEROS_RENDER_GL_INCLUDE_DIRS})
    target_include_directories(westeros_render_gl_static PUBLIC ${WESTEROS_RENDER_GL_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_render_gl_static PRIVATE ${WESTEROS_RENDER_GL_DEFINES})
    target_compile_definitions(westeros_render_gl_static PUBLIC ${WESTEROS_RENDER_GL_DEFINES_PUBLIC})
    target_compile_options(westeros_render_gl_static PRIVATE ${WESTEROS_RENDER_GL_OPTIONS_CXX})
    target_compile_options(westeros_render_gl_static PUBLIC ${WESTEROS_RENDER_GL_OPTIONS_CXX_PUBLIC})
    set_target_properties(westeros_render_gl_static PROPERTIES LINK_FLAGS -nostdlib)
    if (NOT USE_GLEW)
        add_dependencies(westeros_render_gl_static westeros_gl_static)
    endif()
    if (ENABLE_WESTEROS_SBPROTOCOL)
        add_dependencies(westeros_render_gl_static westeros_simplebuffer_server_static)
    endif()
    add_dependencies(westeros_render_gl_static libxkbcommon-0.7.1)
    setup_target_properties_library(westeros_render_gl_static)
    set_target_properties(westeros_render_gl_static PROPERTIES OUTPUT_NAME westeros_render_gl)
    show_target_properties(westeros_render_gl_static)

    install(TARGETS westeros_render_gl_shared
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        COMPONENT ${PROJECT_NAME}
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
    install(TARGETS westeros_render_gl_static
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        COMPONENT ${PROJECT_NAME})
endif()

## main

IF (ENABLE_WESTEROS_APP)
    set(WESTEROS_MAIN_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-main.cpp)
    set(WESTEROS_MAIN_HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.h
        ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h)
    set(WESTEROS_MAIN_LIB_DIRS ${STANDARD_LIB_DIRS})
    set(WESTEROS_MAIN_LIBS
        westeros_compositor_shared
        wayland-egl
        xkbcommon
        westeros_simpleshell_server_shared)
    if (ENABLE_WESTEROS_SBPROTOCOL)
        set(WESTEROS_MAIN_LIBS ${WESTEROS_MAIN_LIBS}
            westeros_simplebuffer_server_shared)
    endif()
    set(WESTEROS_MAIN_LIBS ${WESTEROS_MAIN_LIBS}
        EGL
        gbm
        westeros_gl_shared
        gbm
        expat
        wayland-client
        wayland-server
        ffi
        rt
        GLESv2
        drm
        m
        dl
        glapi
        pthread)
    set(WESTEROS_MAIN_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl)
    set(WESTEROS_MAIN_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
    set(WESTEROS_MAIN_DEFINES )
    set(WESTEROS_MAIN_DEFINES_PUBLIC ${STANDARD_DEFINES})

    if (ENABLE_WESTEROS_SBPROTOCOL)
        set(WESTEROS_COMPOSITOR_INCLUDE_DIRS ${WESTEROS_COMPOSITOR_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/simplebuffer/westeros-simplebuffer)
    endif()
    if (ENABLE_XDG_V4)
        set(WESTEROS_COMPOSITOR_HEADERS ${WESTEROS_COMPOSITOR_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4/xdg-shell-server-protocol.h)
        set(WESTEROS_COMPOSITOR_INCLUDE_DIRS ${WESTEROS_COMPOSITOR_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version4)
    endif()

    if (ENABLE_XDG_V5)
        set(WESTEROS_COMPOSITOR_HEADERS ${WESTEROS_COMPOSITOR_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5/xdg-shell-server-protocol.h)
        set(WESTEROS_COMPOSITOR_INCLUDE_DIRS ${WESTEROS_COMPOSITOR_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/protocol/version5)
    endif()

    add_executable(westeros_main
        ${WESTEROS_MAIN_SOURCES}
        ${WESTEROS_MAIN_HEADERS})
    target_link_libraries(westeros_main ${WESTEROS_MAIN_LIBS})
    target_include_directories(westeros_main PRIVATE ${WESTEROS_MAIN_INCLUDE_DIRS})
    target_include_directories(westeros_main PUBLIC ${WESTEROS_MAIN_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_main PRIVATE ${WESTEROS_MAIN_DEFINES})
    target_compile_definitions(westeros_main PUBLIC ${WESTEROS_MAIN_DEFINES_PUBLIC})
    add_dependencies(westeros_main wayland-1.13.0 westeros_compositor_shared westeros_gl_shared)
    if (ENABLE_XDG_V4)
        add_dependencies(westeros_main westeros-xdgshell-v4-protocol)
    endif()
    if (ENABLE_XDG_V5)
        add_dependencies(westeros_main westeros-xdgshell-v5-protocol)
    endif()
    setup_target_properties_executable(westeros_main)
    set_target_properties(westeros_main PROPERTIES VERSION ${PACKAGE_VERSION})
    set_target_properties(westeros_main PROPERTIES OUTPUT_NAME westeros)
    show_target_properties(westeros_main)

    install(TARGETS westeros_main
        DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        COMPONENT ${PROJECT_NAME}
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endif()

## test

IF (ENABLE_WESTEROS_TEST)
    set(WESTEROS_TEST_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-test.cpp)
    set(WESTEROS_TEST_HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol/simpleshell-client-protocol.h)
    set(WESTEROS_TEST_LIB_DIRS ${STANDARD_LIB_DIRS})
    set(WESTEROS_TEST_LIBS
        westeros_simpleshell_client_shared
        wayland-egl
        GLESv2
        glapi
        EGL
        pthread
        gbm
        wayland-client
        wayland-server
        ffi
        rt
        expat
        dl
        drm
        m)
    set(WESTEROS_TEST_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/simpleshell/protocol)
    set(WESTEROS_TEST_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
    set(WESTEROS_TEST_DEFINES )
    set(WESTEROS_TEST_DEFINES_PUBLIC ${STANDARD_DEFINES})

    add_executable(westeros_test
        ${WESTEROS_TEST_SOURCES}
        ${WESTEROS_TEST_HEADERS})
    target_link_libraries(westeros_test ${WESTEROS_TEST_LIBS})
    target_include_directories(westeros_test PRIVATE ${WESTEROS_TEST_INCLUDE_DIRS})
    target_include_directories(westeros_test PUBLIC ${WESTEROS_TEST_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_test PRIVATE ${WESTEROS_TEST_DEFINES})
    target_compile_definitions(westeros_test PUBLIC ${WESTEROS_TEST_DEFINES_PUBLIC})
    add_dependencies(westeros_test wayland-1.13.0 westeros_simpleshell_client_shared)
    setup_target_properties_executable(westeros_test)
    set_target_properties(westeros_test PROPERTIES VERSION ${PACKAGE_VERSION})
    set_target_properties(westeros_test PROPERTIES OUTPUT_NAME westeros_test)
    show_target_properties(westeros_test)

    install(TARGETS westeros_test
        DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        COMPONENT ${PROJECT_NAME}
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endif()

## player

IF (ENABLE_WESTEROS_PLAYER)
    set(WESTEROS_PLAYER_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-player.cpp)
    set(WESTEROS_PLAYER_HEADERS
        ${CMAKE_CURRENT_SOURCE_DIR}/westeros-compositor.h
        ${CMAKE_CURRENT_SOURCE_DIR}/drm/westeros-gl/westeros-gl.h)
    set(WESTEROS_PLAYER_LIB_DIRS ${STANDARD_LIB_DIRS})
    set(WESTEROS_PLAYER_LIBS
        wayland-server
        gstreamer-1.0
        gobject-2.0
        glib-2.0
        wayland-client
        ${WESTEROS_EGL_LIBS}
        EGL
        pthread
        rt
        dl)
    set(WESTEROS_PLAYER_INCLUDE_DIRS
        ${CMAKE_INSTALL_PREFIX}/include/gstreamer-1.0
        ${CMAKE_INSTALL_PREFIX}/include/glib-2.0
        ${CMAKE_INSTALL_PREFIX}/lib/glib-2.0/include)
    set(WESTEROS_PLAYER_INCLUDE_DIRS_PUBLIC ${STANDARD_INCLUDE_DIRS})
    set(WESTEROS_PLAYER_DEFINES )
    set(WESTEROS_PLAYER_DEFINES_PUBLIC ${STANDARD_DEFINES})

    add_executable(westeros_player
        ${WESTEROS_PLAYER_SOURCES}
        ${WESTEROS_PLAYER_HEADERS})
    target_link_libraries(westeros_player ${WESTEROS_PLAYER_LIBS})
    target_include_directories(westeros_player PRIVATE ${WESTEROS_PLAYER_INCLUDE_DIRS})
    target_include_directories(westeros_player PUBLIC ${WESTEROS_PLAYER_INCLUDE_DIRS_PUBLIC})
    target_compile_definitions(westeros_player PRIVATE ${WESTEROS_PLAYER_DEFINES})
    target_compile_definitions(westeros_player PUBLIC ${WESTEROS_PLAYER_DEFINES_PUBLIC})
    add_dependencies(westeros_player wayland-1.13.0 gstreamer-1.10.4)
    setup_target_properties_executable(westeros_player)
    set_target_properties(westeros_player PROPERTIES VERSION ${PACKAGE_VERSION})
    set_target_properties(westeros_player PROPERTIES OUTPUT_NAME westeros_player)
    show_target_properties(westeros_player)

    install(TARGETS westeros_player
        DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        COMPONENT ${PROJECT_NAME}
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endif()

add_custom_target(${WESTEROS_BASE}
    COMMENT "Westeros")
#add_dependencies(${WESTEROS_BASE}
#    wayland-1.13.0
#    wayland-protocols-1.7
#    libevdev-1.5.6
#    libxkbcommon-0.7.1
#    cairo-1.14.8
#    libjpeg-turbo-1.5.1
#    mesa-17.0.4
#    mtdev-1.1.5
#    libXcursor-1.1.14
#    libXrender-0.9.10
#    glib-2.52.1
#    gstreamer-1.10.4
#    gst-plugins-base-1.10.4
#    gst-plugins-good-1.10.4
#    gst-plugins-bad-1.10.4
#    gstreamer-1.10.4
#    westeros-simplebuffer-protocol
#    westeros-simpleshell-protocol
#    westeros-xdgshell-v4-protocol
#    westeros-xdgshell-v5-protocol
#    westeros-vpc-protocol
#    )
add_dependencies(install_${PROJECT_NAME}
    westeros-simplebuffer-protocol
    westeros-simpleshell-protocol
    westeros_simplebuffer_client_shared
    westeros_simplebuffer_client_static
    westeros_simplebuffer_server_shared
    westeros_simplebuffer_server_static
    westeros_simpleshell_client_shared
    westeros_simpleshell_client_static
    westeros_simpleshell_server_shared
    westeros_simpleshell_server_static
    westeros_gl_shared
    westeros_gl_static
    westeros_compositor_shared
    westeros_compositor_static
    westeros_render_embedded_shared
    westeros_render_embedded_static
    westeros_render_gl_shared
    westeros_render_gl_static)
if (ENABLE_WESTEROS_APP)
    add_dependencies(install_${PROJECT_NAME} westeros_main)
endif()
if (ENABLE_WESTEROS_TEST)
    add_dependencies(install_${PROJECT_NAME} westeros_test)
endif()
if (ENABLE_WESTEROS_PLAYER)
    add_dependencies(install_${PROJECT_NAME} westeros_player)
endif()