# - Try to find Nasm
# Once done this will define
#  NASM_FOUND - System has Nasm
#  NASM_VERSION - The version of Nasm

execute_process(COMMAND nasm -v OUTPUT_VARIABLE VERSION_STRING)
if(VERSION_STRING)
    string(REGEX MATCH "NASM version ([0-9]+.[0-9]+.[0-9]+)" NASM_VERSION ${VERSION_STRING})
    set(NASM_VERSION ${CMAKE_MATCH_1})
    set(NASM_FOUND TRUE)
endif()

if(NASM_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "nasm           : ${FOUND_TEXT}")
message(STATUS "  version      : ${NASM_VERSION}")

if (NASM_FOUND)
    if(NASM_REQUIRED_VERSION)
        if (NOT "${NASM_REQUIRED_VERSION}" STREQUAL "${NASM_VERSION}")
            message(WARNING "Incorrect version, please install nasm-${NASM_REQUIRED_VERSION}")
            unset(NASM_FOUND)
        endif()
    else()
        message(STATUS "Found nasm")
    endif()
else()
    message(WARNING "Could not find nasm, please install: sudo apt-get install nasm")
endif()

