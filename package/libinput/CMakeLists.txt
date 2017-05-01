project(libinput)

set(LIBINPUT_VERSION 1.7.0)
set(LIBINPUT_REQUIRED_VERSION ${LIBINPUT_VERSION})
set(LIBINPUT_NAME ${PROJECT_NAME})
set(LIBINPUT_BASE ${LIBINPUT_NAME}-${LIBINPUT_VERSION})

find_package(LibInput QUIET)

if (NOT LIBINPUT_FOUND)
    set(LIBINPUT_EXTENSION tar.xz)
    set(LIBINPUT_FULLNAME ${LIBINPUT_BASE}.${LIBINPUT_EXTENSION})
    set(LIBINPUT_SITE http://www.freedesktop.org/software/libinput)
    set(LIBINPUT_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBINPUT_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBINPUT_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBINPUT_SITE}
        ${LIBINPUT_FULLNAME}
        ${LIBINPUT_BASE}
        ${LIBINPUT_BASE}
        ""
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-tests --disable-libwacom --disable-event-gui"
        "make"
        "make check"
        "make install")
    add_dependencies(${LIBINPUT_BASE} libevdev-1.5.6 mtdev-1.1.5)
else()
    add_custom_target(${LIBINPUT_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
