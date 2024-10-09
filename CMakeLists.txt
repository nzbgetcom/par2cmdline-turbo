cmake_minimum_required(VERSION 3.13)

if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
	message(FATAL_ERROR "In-source builds are not allowed. You should create separate directory for build files.")
endif()

set(VERSION "1.1.1")
set(PACKAGE "par2")

project(
	${PACKAGE}
	VERSION ${VERSION}
	DESCRIPTION "par2cmdline-turbo is a PAR 2.0 compatible file verification and repair tool with improved performance on x86/ARM platforms."
	LANGUAGES C CXX
)

find_package(Threads REQUIRED)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_C_EXTENSIONS OFF)

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

add_library(${PACKAGE} STATIC ${PAR2_SRC})
target_link_libraries(${PACKAGE} PUBLIC 
	gf16
	hasher
	Threads::Threads
)
target_include_directories(${PACKAGE} PUBLIC 
	${CMAKE_CURRENT_SOURCE_DIR}/src
	${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16
	${CMAKE_CURRENT_SOURCE_DIR}/parpar/hasher
)
# add_compile_definitions(
# 	PARPAR_ENABLE_HASHER_MD5CRC=1 
#     PACKAGE=${PACKAGE} 
#     VERSION=${VERSION}
# 	_CONSOLE=1
# 	NDEBUG=1
# )
add_definitions(-DUNICODE -DWIN32 -DNDEBUG -D_CONSOLE -DPARPAR_ENABLE_HASHER_MD5CRC -DPACKAGE="${PACKAGE}" -DVERSION="${VERSION}")
if(WIN32)
    include(cmake/windows.cmake)
    include(parpar/gf16.cmake)
    include(parpar/hasher.cmake)
endif()
