project(hello-wayland)

#find_package(Wayland REQUIRED)

#if (NOT WAYLAND_CLIENT_FOUND)
#    message(FATAL_ERROR "Could not find wayland-client")
#endif()
#
#message(STATUS ${WAYLAND_CLIENT_INCLUDE_DIR})
#message(STATUS ${WAYLAND_CLIENT_LIBRARIES})
#
#set(SOURCE_FILES
#        hello_wayland.c helpers.c)
#set(HEADER_FILES
#        helpers.h)
#set(DATA_FILES
#        images.bin)
#
#message(STATUS ${SOURCE_FILES})

#add_executable(${PROJECT_NAME} ${SOURCE_FILES} ${HEADER_FILES})
#target_include_directories(${PROJECT_NAME} PRIVATE ${WAYLAND_CLIENT_INCLUDE_DIR})
#target_link_libraries(${PROJECT_NAME} ${WAYLAND_CLIENT_LIBRARIES})
#add_custom_command(TARGET ${PROJECT_NAME} PRE_BUILD
#    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/${DATA_FILES} $<TARGET_FILE_DIR:${PROJECT_NAME}>)

#add_custom_target(${PROJECT_NAME} DEPENDS libffi
#    COMMAND ${CMAKE_COMMAND} -E echo Build ${PROJECT_NAME})
add_custom_target(${PROJECT_NAME} ALL
    COMMENT "Command ${PROJECT_NAME}")
#add_dependencies(${PROJECT_NAME}
#    libffi-3.2.1
#    expat-2.2.0
#    libxml2-2.9.4
#    wayland-1.13.0
#    wayland-protocols-1.7
#    libevdev-1.5.6
#    mtdev-1.1.5
#    libinput-1.7.0
#    libxkbcommon-0.7.1
#    pixman-0.34.0
#    libpng-1.6.29
#    freetype-2.7.1
#    fontconfig-2.12.1
#    cairo-1.14.8)
