cmake_minimum_required(VERSION 3.13)

if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
    message(FATAL_ERROR "In-source builds are not allowed. You should create separate directory for build files.")
endif()

set(VERSION "1.2.0")
set(PACKAGE "par2")
set(PAR2_LIBRARY "par2-turbo")
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

set(par2_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)

set(LIBS Threads::Threads)

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

if(BUILD_TOOL)
    add_executable(${PACKAGE} ${PAR2_SRC})
endif()

if(BUILD_LIB)
    add_library(${PAR2_LIBRARY} STATIC ${PAR2_SRC})
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/common.cmake)

if(WIN32)
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/windows.cmake)
else()
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/posix.cmake)
endif()

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

if(BUILD_TOOL)
    target_link_libraries(${PACKAGE} PRIVATE ${LIBS})
    target_include_directories(${PACKAGE} PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}
        ${par2_INCLUDE_DIR}
    )
endif()

if(BUILD_LIB)
    target_link_libraries(${PAR2_LIBRARY} PUBLIC ${LIBS})
    target_include_directories(${PAR2_LIBRARY}  
        PRIVATE
            ${CMAKE_CURRENT_BINARY_DIR}
        PUBLIC
            ${par2_INCLUDE_DIR}
    )

    install(
        TARGETS ${PAR2_LIBRARY} ${GF16_LIBRARY} ${HASHER_LIBRARY}
        EXPORT "${PAR2_LIBRARY}Config"
        ARCHIVE DESTINATION ${CMAKE_BINARY_DIR}/lib
        LIBRARY DESTINATION ${CMAKE_BINARY_DIR}/lib
        INCLUDES DESTINATION ${par2_INCLUDE_DIR}
    )

    export(
        TARGETS ${PAR2_LIBRARY} ${GF16_LIBRARY} ${HASHER_LIBRARY}
        NAMESPACE ${PAR2_LIBRARY}::
        FILE "${CMAKE_BINARY_DIR}/${PAR2_LIBRARY}Config.cmake"
    )

endif()
