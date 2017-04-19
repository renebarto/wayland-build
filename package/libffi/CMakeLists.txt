project(libffi)

find_package(LibFFI QUIET)
#include(ExternalProject)

set(MODULE ${PROJECT_NAME})
set(VERSION 3.2.1)
set(EXTENSION tar.gz)
set(BASE ${MODULE}-${VERSION})
set(FULLNAME ${BASE}.${EXTENSION})
set(SITE ftp://sourceware.org/pub/libffi)
set(DOWNLOAD_DIR ${PACKAGE_DOWNLOAD_DIR})
set(STAMP_DIR ${PACKAGE_STAMP_DIR}/${BASE})
mkdir(${STAMP_DIR})
set(STAMP_FILE_DOWNLOAD ${STAMP_DIR}/stamp_download)
message(STATUS "Stamp: " ${STAMP_FILE_DOWNLOAD})
add_custom_command(
    OUTPUT ${STAMP_FILE_DOWNLOAD}
    COMMAND wget ${SITE}/${FULLNAME}
    COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_FILE_DOWNLOAD}
    COMMENT "Downloading ${MODULE}"
    WORKING_DIRECTORY ${DOWNLOAD_DIR}
    VERBATIM
)
set(STAMP_FILE_EXTRACT ${STAMP_DIR}/stamp_extract)
add_custom_command(
    OUTPUT ${STAMP_FILE_EXTRACT}
    DEPENDS ${STAMP_FILE_DOWNLOAD}
    COMMAND tar xf ${PACKAGE_DOWNLOAD_DIR}/${FULLNAME} -C .
    COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_FILE_EXTRACT}
    COMMENT "Extracting sources for ${MODULE}"
    WORKING_DIRECTORY ${PACKAGE_BUILD_DIR}
    VERBATIM
)
set(STAMP_FILE_PATCH ${STAMP_DIR}/stamp_patch)
add_custom_command(
    OUTPUT ${STAMP_FILE_PATCH}
    DEPENDS ${STAMP_FILE_EXTRACT}
    COMMAND sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' -i include/Makefile.in
    COMMAND sed -e '/^includedir/ s/=.*$/=@includedir@/' -e 's/^Cflags: -I${includedir}/Cflags:/' -i libffi.pc.in
    COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_FILE_PATCH}
    COMMENT "Patching sources"
    WORKING_DIRECTORY ${PACKAGE_BUILD_DIR}/${BASE}
    VERBATIM
)

#ExternalProject_Add(libffi-dev
#    DOWNLOAD_DIR ${PACKAGE_DOWNLOAD_DIR}
#    STAMP_DIR ${PACKAGE_STAMP_DIR}/${BASE}
#    DOWNLOAD_COMMAND wget ${SITE}/${FULLNAME}
#    CONFIGURE_COMMAND ${PACKAGE_BUILD_DIR}/${BASE}/configure --prefix=${CMAKE_PREFIX_PATH}
#    )
#ExternalProject_Add_Step(libffi-dev extract
#    DEPENDEES download
#    COMMAND echo tar xf ${PACKAGE_DOWNLOAD_DIR}/${FULLNAME} -C ${PACKAGE_BUILD_DIR}
#    COMMAND tar xf ${PACKAGE_DOWNLOAD_DIR}/${FULLNAME} -C ${PACKAGE_BUILD_DIR}
#    COMMENT "Extracting sources"
#    STAMP_DIR ${PACKAGE_STAMP_DIR}/${BASE})
#ExternalProject_Add_StepTargets(libffi-dev extract)
#ExternalProject_Add_Step(libffi-dev patch1
#    DEPENDEES extract
#    DEPENDERS configure
#    VERBATIM COMMAND sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' -i ${PACKAGE_BUILD_DIR}/${BASE}/include/Makefile.in
#    VERBATIM COMMAND sed -e '/^includedir/ s/=.*$/=@includedir@/' -e 's/^Cflags: -I${includedir}/Cflags:/' -i ${PACKAGE_BUILD_DIR}/${BASE}/libffi.pc.in
#    COMMENT "Patching sources"
#    )
#ExternalProject_Add_StepTargets(libffi-dev patch)
#ExternalProject_Add_Step(libffi-dev configure
#    COMMAND "echo configure"
#    COMMENT "Configuring")
#ExternalProject_Add_Step(libffi-dev build
#    COMMAND "echo build"
#    COMMENT "Building")
#ExternalProject_Add_Step(libffi-dev check
#    COMMAND "echo check"
#    COMMENT "Checking")
#ExternalProject_Add_StepTargets(libffi-dev check stage)
#ExternalProject_Add_Step(libffi-dev libffi-dev-stage
#    COMMAND "echo stage"
#    COMMENT "Staging")
#ExternalProject_Add_StepTargets(libffi-dev-stage libffi-dev-build)
#ExternalProject_Add_Step(libffi-dev install
#    COMMAND "echo install"
#    COMMENT "Installing")
#    URL ${SITE}/${FULLNAME}
#    SOURCE_DIR ${PACKAGE_BUILD_DIR}/${BASE}
#    INSTALL_DIR ${CMAKE_PREFIX_PATH}
#    DOWNLOAD_NAME ${FULLNAME}
#    DOWNLOAD_NO_PROGRESS OFF
#    PATCH_COMMAND sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' -i include/Makefile.in && sed -e '/^includedir/ s/=.*$/=@includedir@/' -e 's/^Cflags: -I${includedir}/Cflags:/' -i libffi.pc.in
#    UPDATE_COMMAND tar xf ${PACKAGE_DOWNLOAD_DIR}/${FULLNAME} -C ${PACKAGE_BUILD_DIR}
#    CONFIGURE_COMMAND ${PACKAGE_BUILD_DIR}/${BASE}/configure --prefix=${CMAKE_PREFIX_PATH})

if (NOT LIBFFI_FOUND)
    add_custom_target(libffi DEPENDS ${STAMP_FILE_PATCH}
        COMMAND ${CMAKE_COMMAND} -E echo Building libffi
        COMMENT "Build libffi")
else()
    add_custom_target(libffi)
endif()