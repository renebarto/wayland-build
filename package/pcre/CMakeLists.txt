project(pcre)

set(LIBPCRE_VERSION 8.40)
set(LIBPCRE_REQUIRED_VERSION ${LIBPCRE_VERSION})
set(LIBPCRE_NAME ${PROJECT_NAME})
set(LIBPCRE_BASE ${LIBPCRE_NAME}-${LIBPCRE_VERSION})

find_package(LibPCRE QUIET)

if (NOT LIBPCRE_FOUND)
    set(LIBPCRE_EXTENSION tar.bz2)
    set(LIBPCRE_FULLNAME ${LIBPCRE_BASE}.${LIBPCRE_EXTENSION})
    set(LIBPCRE_SITE ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre)
    set(LIBPCRE_STAMP_DIR ${PACKAGE_STAMP_DIR}/${LIBPCRE_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${LIBPCRE_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${LIBPCRE_SITE}
        ${LIBPCRE_FULLNAME}
        ${LIBPCRE_BASE}
        ${LIBPCRE_BASE}
        ""
        ""
        "CFLAGS=-I${CMAKE_INSTALL_PREFIX}/include LDFLAGS=-L${CMAKE_INSTALL_PREFIX}/lib ./configure \
            --prefix=${CMAKE_INSTALL_PREFIX} \
            --docdir=${CMAKE_INSTALL_PREFIX}/share/doc/pcre-8.40 \
            --enable-unicode-properties       \
            --enable-utf8                     \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --disable-pcretest-libreadline    \
            --disable-static"
        "make"
        "make check"
        "make install")
    add_dependencies(${LIBPCRE_BASE}
        bzip2-1.0.6)
else()
    add_custom_target(${LIBPCRE_BASE})
endif()
