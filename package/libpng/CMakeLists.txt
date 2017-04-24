project(libpng)

set(LIBPNG_VERSION 1.6.29)
set(LIBPNG_REQUIRED_VERSION ${LIBPNG_VERSION})
set(LIBPNG_NAME ${PROJECT_NAME})
set(LIBPNG_BASE ${LIBPNG_NAME}-${LIBPNG_VERSION})

find_package(LibPNG QUIET)

if (NOT LIBPNG_FOUND)
    set(LIBPNG_EXTENSION tar.xz)
    set(LIBPNG_FULLNAME ${LIBPNG_BASE}.${LIBPNG_EXTENSION})
    set(LIBPNG_SITE  http://downloads.sourceforge.net/libpng)
    set(LIBPNG_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBPNG_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBPNG_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBPNG_SITE}
        ${LIBPNG_FULLNAME}
        ${LIBPNG_BASE}
        ${LIBPNG_BASE}
        "libpng-1.6.29-apng.patch"
        ""
        "LIBS=-lpthread ./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static")
    add_dependencies(${LIBPNG_BASE} zlib-1.2.11)
else()
    add_custom_target(${LIBPNG_BASE})
endif()
