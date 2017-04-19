function(mkdir name)
    execute_process(COMMAND mkdir -pv ${name})
endfunction()

function(setup_mkdir_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(DOWNLOAD_DIR TARGET ${name}      PROPERTY _PKG_DOWNLOAD_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)
    get_property(STAGING_DIR TARGET ${name}       PROPERTY _PKG_STAGING_DIR)

    set(STAMP_MKDIR ${STAMP_DIR}/stamp_mkdir)
    add_custom_command(
        OUTPUT ${STAMP_MKDIR}
        COMMAND mkdir -p ${STAMP_DIR}
        COMMAND mkdir -p ${DOWNLOAD_DIR}
        COMMAND mkdir -p ${BUILD_DIR}
        COMMAND mkdir -p ${STAGING_DIR}
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_MKDIR}
        COMMENT "Creating directories"
        VERBATIM)
    message(STATUS "setup_mkdir_command")
endfunction()

function(setup_download_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(DOWNLOAD_DIR TARGET ${name}      PROPERTY _PKG_DOWNLOAD_DIR)
    get_property(SITE TARGET ${name}              PROPERTY _PKG_SITE)
    get_property(FULLNAME TARGET ${name}          PROPERTY _PKG_FULLNAME)

    set(STAMP_MKDIR ${STAMP_DIR}/stamp_mkdir)
    set(STAMP_DOWNLOAD ${STAMP_DIR}/stamp_download)
    add_custom_command(
        OUTPUT ${STAMP_DOWNLOAD}
        DEPENDS ${STAMP_MKDIR}
        COMMAND wget ${SITE}/${FULLNAME}
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_DOWNLOAD}
        COMMENT "Downloading ${name}"
        WORKING_DIRECTORY ${DOWNLOAD_DIR}
        VERBATIM)
    message(STATUS "setup_download_command")
endfunction()

function(setup_extract_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(DOWNLOAD_DIR TARGET ${name}      PROPERTY _PKG_DOWNLOAD_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)
    get_property(FULLNAME TARGET ${name}          PROPERTY _PKG_FULLNAME)

    set(STAMP_DOWNLOAD ${STAMP_DIR}/stamp_download)
    set(STAMP_EXTRACT ${STAMP_DIR}/stamp_extract)
    add_custom_command(
        OUTPUT ${STAMP_EXTRACT}
        DEPENDS ${STAMP_DOWNLOAD}
        COMMAND tar xf ${DOWNLOAD_DIR}/${FULLNAME} -C .
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_EXTRACT}
        COMMENT "Extracting ${name}"
        WORKING_DIRECTORY ${BUILD_DIR}
        VERBATIM)
    message(STATUS "setup_extract_command")
endfunction()

function(setup_patch_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)
    get_property(PACKAGE_DIR TARGET ${name}       PROPERTY _PKG_PACKAGE_DIR)
    get_property(PATCH_LIST TARGET ${name}        PROPERTY _PKG_PATCH_LIST)

    set(STAMP_EXTRACT ${STAMP_DIR}/stamp_extract)
    set(STAMP_PATCH ${STAMP_DIR}/stamp_patch)
    add_custom_target(${name}-patches)
    foreach(VAL ${PATCH_LIST})
        set(STAMP_PATCH_VAL ${STAMP_DIR}/stamp_patch-${VAL})
        message(STATUS "PATCH ${VAL}")
        add_custom_target(patch_${VAL}
            COMMAND patch -p0 -i ${PACKAGE_DIR}/${VAL}
            DEPENDS ${STAMP_EXTRACT}
            COMMENT "Applying patch ${VAL}"
            WORKING_DIRECTORY ${BUILD_DIR}/${name}
            VERBATIM)
        add_dependencies(${name}-patches patch_${VAL})
    endforeach()
    add_custom_command(
        OUTPUT ${STAMP_PATCH}
        DEPENDS ${STAMP_EXTRACT} ${name}-patches
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_PATCH}
        COMMENT "Patching ${name}"
        WORKING_DIRECTORY ${BUILD_DIR}/${name}
        VERBATIM)
    message(STATUS "setup_patch_command")
endfunction()

function(setup_configure_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)
    get_property(CONFIGURE_COMMAND TARGET ${name} PROPERTY _PKG_CONFIGURE_COMMAND)

    set(STAMP_PATCH ${STAMP_DIR}/stamp_patch)
    set(STAMP_CONFIGURE ${STAMP_DIR}/stamp_configure)
    add_custom_command(
        OUTPUT ${STAMP_CONFIGURE}
        DEPENDS ${STAMP_PATCH}
        COMMAND sh -c ${CONFIGURE_COMMAND}
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_CONFIGURE}
        COMMENT "Configuring ${name}"
        WORKING_DIRECTORY ${BUILD_DIR}/${name}
        VERBATIM)
    message(STATUS "setup_configure_command")
endfunction()

function(setup_make_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)

    set(STAMP_CONFIGURE ${STAMP_DIR}/stamp_configure)
    set(STAMP_MAKE ${STAMP_DIR}/stamp_make)
    add_custom_command(
        OUTPUT ${STAMP_MAKE}
        DEPENDS ${STAMP_CONFIGURE}
        COMMAND make
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_MAKE}
        COMMENT "Building ${name}"
        WORKING_DIRECTORY ${BUILD_DIR}/${name}
        VERBATIM)
    message(STATUS "setup_make_command")
endfunction()

function(setup_check_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)

    set(STAMP_MAKE ${STAMP_DIR}/stamp_make)
    set(STAMP_CHECK ${STAMP_DIR}/stamp_check)
    add_custom_command(
        OUTPUT ${STAMP_CHECK}
        DEPENDS ${STAMP_MAKE}
        COMMAND make
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_CHECK}
        COMMENT "Checking ${name}"
        WORKING_DIRECTORY ${BUILD_DIR}/${name}
        VERBATIM)
    message(STATUS "setup_check_command")
endfunction()

function(setup_staging_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)

    set(STAMP_CHECK ${STAMP_DIR}/stamp_check)
    set(STAMP_STAGING ${STAMP_DIR}/stamp_staging)
    add_custom_command(
        OUTPUT ${STAMP_STAGING}
        DEPENDS ${STAMP_CHECK}
        #    COMMAND make install
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_STAGING}
        COMMENT "Staging ${name} - skipping for now"
        WORKING_DIRECTORY ${BUILD_DIR}/${name}
        VERBATIM)
    message(STATUS "setup_staging_command")
endfunction()

function(setup_install_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)
    get_property(BUILD_DIR TARGET ${name}         PROPERTY _PKG_BUILD_DIR)

    set(STAMP_STAGING ${STAMP_DIR}/stamp_staging)
    set(STAMP_INSTALL ${STAMP_DIR}/stamp_install)
    add_custom_command(
        OUTPUT ${STAMP_INSTALL}
        DEPENDS ${STAMP_STAGING}
        COMMAND make install
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_INSTALL}
        COMMENT "Installing ${name}"
        WORKING_DIRECTORY ${BUILD_DIR}/${name}
        VERBATIM)
    message(STATUS "setup_install_command")
endfunction()

function(setup_complete_command name)
    get_property(STAMP_DIR TARGET ${name}         PROPERTY _PKG_STAMP_DIR)

    set(STAMP_INSTALL ${STAMP_DIR}/stamp_install)
    set(STAMP_COMPLETE ${STAMP_DIR}/stamp_complete)
    add_custom_command(
        OUTPUT ${STAMP_COMPLETE}
        DEPENDS ${STAMP_INSTALL}
        COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_INSTALL}
        COMMENT "Finalizing ${name}"
        VERBATIM)
    message(STATUS "setup_complete_command")
endfunction()

function (setup_package_automake
    DOWNLOAD_DIR BUILD_DIR STAGING_DIR STAMP_DIR PACKAGE_DIR
    SITE FULLNAME MODULE BASE
    PATCH_LIST CONFIGURE_COMMAND)
    set(STAMP_COMPLETE ${STAMP_DIR}/stamp_complete)
    add_custom_target(${BASE} ALL DEPENDS ${STAMP_COMPLETE})
    set_property(TARGET ${BASE} PROPERTY _PKG_DOWNLOAD_DIR ${DOWNLOAD_DIR})
    set_property(TARGET ${BASE} PROPERTY _PKG_BUILD_DIR ${BUILD_DIR})
    set_property(TARGET ${BASE} PROPERTY _PKG_STAGING_DIR ${STAGING_DIR})
    set_property(TARGET ${BASE} PROPERTY _PKG_STAMP_DIR ${STAMP_DIR})
    set_property(TARGET ${BASE} PROPERTY _PKG_PACKAGE_DIR ${PACKAGE_DIR})
    set_property(TARGET ${BASE} PROPERTY _PKG_SITE ${SITE})
    set_property(TARGET ${BASE} PROPERTY _PKG_FULLNAME ${FULLNAME})
    set_property(TARGET ${BASE} PROPERTY _PKG_MODULE ${MODULE})
    set_property(TARGET ${BASE} PROPERTY _PKG_PATCH_LIST ${PATCH_LIST})
    set_property(TARGET ${BASE} PROPERTY _PKG_CONFIGURE_COMMAND ${CONFIGURE_COMMAND})

    message(STATUS "Module ${BASE}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_DOWNLOAD_DIR)
    message(STATUS "  _PKG_DOWNLOAD_DIR      ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_BUILD_DIR)
    message(STATUS "  _PKG_BUILD_DIR         ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_STAGING_DIR)
    message(STATUS "  _PKG_STAGING_DIR       ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_STAMP_DIR)
    message(STATUS "  _PKG_STAMP_DIR         ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_PACKAGE_DIR)
    message(STATUS "  _PKG_PACKAGE_DIR       ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_SITE)
    message(STATUS "  _PKG_SITE              ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_FULLNAME)
    message(STATUS "  _PKG_FULLNAME          ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_MODULE)
    message(STATUS "  _PKG_MODULE            ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_PATCH_LIST)
    message(STATUS "  _PKG_PATCH_LIST        ${PROP}")
    get_property(PROP TARGET ${BASE} PROPERTY _PKG_CONFIGURE_COMMAND)
    message(STATUS "  _PKG_CONFIGURE_COMMAND ${PROP}")

    setup_mkdir_command(${BASE})
    setup_download_command(${BASE})
    setup_extract_command(${BASE})
    setup_patch_command(${BASE})
    setup_configure_command(${BASE})
    setup_make_command(${BASE})
    setup_check_command(${BASE})
    setup_staging_command(${BASE})
    setup_install_command(${BASE})
    setup_complete_command(${BASE})
endfunction()