project(libffi)

find_package(LibFFI QUIET)
include(ExternalProject)

set(VERSION 3.2.1)
set(EXTENSION tar.gz)
set(BASE ${PROJECT_NAME}-${VERSION})
set(FULLNAME ${BASE}.${EXTENSION})
set(SITE ftp://sourceware.org/pub/libffi)
ExternalProject_Add(libffi-dev
    URL ${SITE}/${FULLNAME}
    DOWNLOAD_DIR ${PACKAGE_DOWNLOAD_DIR}
    SOURCE_DIR ${PACKAGE_BUILD_DIR}/${BASE}
    INSTALL_DIR ${CMAKE_PREFIX_PATH}
    DOWNLOAD_NAME ${FULLNAME}
    DOWNLOAD_COMMAND wget ${SITE}/${FULLNAME}
    DOWNLOAD_NO_PROGRESS OFF
    STAMP_DIR ${PACKAGE_STAMP_DIR}/${BASE}
    UPDATE_COMMAND tar xf ${PACKAGE_DOWNLOAD_DIR}/${FULLNAME} -C ${PACKAGE_BUILD_DIR}
    CONFIGURE_COMMAND ${PACKAGE_BUILD_DIR}/${BASE}/configure --prefix=${CMAKE_PREFIX_PATH})

if (NOT LIBFFI_FOUND)
    add_custom_target(libffi DEPENDS libffi-dev)
endif()