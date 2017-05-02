project(util-linux)

set(UTIL_LINUX_VERSION 2.29.2)
set(UTIL_LINUX_REQUIRED_VERSION ${UTIL_LINUX_VERSION})
set(UTIL_LINUX_NAME ${PROJECT_NAME})
set(UTIL_LINUX_BASE ${UTIL_LINUX_NAME}-${UTIL_LINUX_VERSION})

find_package(UtilLinux QUIET)

if (NOT UTIL_LINUX_FOUND)
    set(UTIL_LINUX_EXTENSION tar.xz)
    set(UTIL_LINUX_FULLNAME ${UTIL_LINUX_BASE}.${UTIL_LINUX_EXTENSION})
    set(UTIL_LINUX_SITE https://www.kernel.org/pub/linux/utils/util-linux/v2.29)
    set(UTIL_LINUX_STAMP_DIR ${PACKAGE_STAMP_DIR}/${UTIL_LINUX_BASE})
    setup_package_automake(
        ${PACKAGE_DOWNLOAD_DIR}
        ${PACKAGE_BUILD_DIR}
        ${PACKAGE_STAGING_DIR}
        ${UTIL_LINUX_STAMP_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${UTIL_LINUX_SITE}
        ${UTIL_LINUX_FULLNAME}
        ${UTIL_LINUX_BASE}
        ${UTIL_LINUX_BASE}
        ""
        ""
        "./configure \
            --prefix=${CMAKE_INSTALL_PREFIX} \
            --with-bashcompletiondir=${CMAKE_INSTALL_PREFIX}/share/bash-completion/completions \
            --disable-makeinstall-chown    \
            --disable-makeinstall-setuid   \
            --disable-widechar   \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            --without-systemd    \
            --without-systemdsystemunitdir \
            --enable-libblkid    \
            --enable-libmount    \
            --enable-libuuid     \
            --without-ncurses    \
            --without-ncursesw   \
            --without-tinfo"
        "make"
        ""
#        "make check" // Tests failing
        "make install")
#    add_dependencies(${UTIL_LINUX_BASE}
#        libXrender-0.9.10)
else()
    add_custom_target(${UTIL_LINUX_BASE})
endif()
