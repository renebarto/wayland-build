project(wayland-simple-egl)

find_package(Wayland REQUIRED)
find_package(EGL REQUIRED)
find_package(OpenGLES2 REQUIRED)

if (NOT WAYLAND_CLIENT_FOUND)
    message(FATAL_ERROR "Could not find wayland-client")
endif()

message(STATUS ${WAYLAND_CLIENT_INCLUDE_DIR})
message(STATUS ${WAYLAND_CLIENT_LIBRARIES})

set(SOURCE_FILES
        simple-egl.c)
set(HEADER_FILES
        )
set(DATA_FILES
        )

message(STATUS ${SOURCE_FILES})

add_executable(${PROJECT_NAME} ${SOURCE_FILES} ${HEADER_FILES})
target_include_directories(${PROJECT_NAME} PRIVATE ${WAYLAND_CLIENT_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} ${WAYLAND_CLIENT_LIBRARIES})

#add_custom_command(TARGET ${PROJECT_NAME} PRE_BUILD
#        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/${DATA_FILES} $<TARGET_FILE_DIR:${PROJECT_NAME}>)