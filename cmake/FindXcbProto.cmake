# - Try to find XcbProto
# Once done this will define
#  XCB_PROTO_FOUND - System has XcbProto
#  XCB_PROTO_INCLUDE_DIR - The XcbProto include directories
#  XCB_PROTO_LIBRARIES - The libraries needed to use XcbProto
#  XCB_PROTO_DEFINITIONS - Compiler switches required for using XcbProto

find_package(PkgConfig)
pkg_check_modules(PC_XCB_PROTO QUIET xcb-proto)
set(XCB_PROTO_DEFINITIONS ${PC_XCB_PROTO_CFLAGS_OTHER})

if(PC_XCB_PROTO_FOUND)
    set(FOUND_TEXT "Found")
    set(XCB_PROTO_FOUND TRUE)
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "xcb-proto      : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_XCB_PROTO_VERSION}")
message(STATUS "  cflags       : ${PC_XCB_PROTO_CFLAGS}")
message(STATUS "  cflags other : ${PC_XCB_PROTO_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_XCB_PROTO_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_XCB_PROTO_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_XCB_PROTO_LIBRARIES}")

if (XCB_PROTO_FOUND)
    if(XCB_PROTO_REQUIRED_VERSION)
        if (NOT "${XCB_PROTO_REQUIRED_VERSION}" STREQUAL "${PC_XCB_PROTO_VERSION}")
            message(WARNING "Incorrect version, please install xcb-proto-${XCB_PROTO_REQUIRED_VERSION}")
            unset(XCB_PROTO_FOUND)
        endif()
    else()
        message(STATUS "Found xcb-proto")
    endif()
else()
    message(WARNING "Could not find xcb-proto, please install: sudo apt-get install xcb-proto")
endif()

mark_as_advanced(XCB_PROTO_INCLUDE_DIR XCB_PROTO_LIBRARY)
