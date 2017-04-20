project(libinput)

find_package(LibInput QUIET)

set(LIBINPUT_FOUND false)

set(LIBINPUT_MODULE ${PROJECT_NAME})
set(LIBINPUT_VERSION 1.7.0)
set(LIBINPUT_BASE ${LIBINPUT_MODULE}-${LIBINPUT_VERSION})

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
        ${LIBINPUT_MODULE}
        ${LIBINPUT_BASE}
        ""
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-tests --disable-libwacom --disable-event-gui")
else()
    add_custom_target(${LIBINPUT_BASE})
endif()

#"0001-Patch-for-correct-header-export.patch"
