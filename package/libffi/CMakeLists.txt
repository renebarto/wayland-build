project(libffi)

find_package(LibFFI QUIET)

set(LIBFFI_FOUND false)

set(LIBFFI_MODULE ${PROJECT_NAME})
set(LIBFFI_VERSION 3.2.1)
set(LIBFFI_BASE ${LIBFFI_MODULE}-${LIBFFI_VERSION})

if (NOT LIBFFI_FOUND)
    set(LIBFFI_EXTENSION tar.gz)
    set(LIBFFI_FULLNAME ${LIBFFI_BASE}.${LIBFFI_EXTENSION})
    set(LIBFFI_SITE ftp://sourceware.org/pub/libffi)
    set(LIBFFI_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBFFI_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBFFI_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBFFI_SITE}
        ${LIBFFI_FULLNAME}
        ${LIBFFI_MODULE}
        ${LIBFFI_BASE}
        "0001-Patch-for-correct-header-export.patch"
        "./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-static")
else()
    add_custom_target(${LIBFFI_BASE})
endif()