cmake_minimum_required(VERSION 3.13)

if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
    message(FATAL_ERROR "In-source builds are not allowed. You should create separate directory for build files.")
endif()

set(VERSION "1.2.0")
set(PACKAGE "par2")
set(PAR2_LIB_VERSION ${VERSION})

project(
    ${PACKAGE}
    VERSION ${VERSION}
    DESCRIPTION "par2cmdline-turbo is a PAR 2.0 compatible file verification and repair tool with improved performance on x86/ARM platforms."
    LANGUAGES C CXX ASM_MASM
)

option(BUILD_TOOL "Build only the executable Par2 tool" ON)
option(BUILD_LIB "Build only the Par2 library" OFF)
#option(WITH_TESTS "Build tests" OFF)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

find_package(Threads REQUIRED)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_C_EXTENSIONS OFF)

set(par2_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE PATH "")

set(LIBS Threads::Threads CACHE INTERNAL "")

set(PAR2_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/commandline.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crc.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/creatorpacket.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/criticalpacket.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/datablock.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/descriptionpacket.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/diskfile.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/filechecksummer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/galois.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/libpar2.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/mainpacket.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/md5.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par1fileformat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par1repairer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par1repairersourcefile.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par2cmdline.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par2creator.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par2creatorsourcefile.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par2fileformat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par2repairer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/par2repairersourcefile.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/recoverypacket.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/reedsolomon.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/verificationhashtable.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/verificationpacket.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/utf8.cpp
)

if(BUILD_LIB)
    add_library(${PACKAGE} STATIC ${PAR2_SRC})
else()
    add_executable(${PACKAGE} ${PAR2_SRC})
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/common.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/parpar/hasher.cmake)

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.h.in
    ${CMAKE_CURRENT_BINARY_DIR}/config.h
)

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/version.h.in
    ${par2_INCLUDE_DIR}/par2/version.h
)

target_link_libraries(${PACKAGE} PUBLIC ${LIBS})
target_include_directories(${PACKAGE}  
    PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}
    PUBLIC
        ${par2_INCLUDE_DIR}
)
