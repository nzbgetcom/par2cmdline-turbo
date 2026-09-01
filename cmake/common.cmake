if (CMAKE_SYSTEM_PROCESSOR MATCHES "i386|i686|x86|x86_64|x64|amd64|AMD64|win32|Win32")
    set(IS_X86 TRUE)
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|x64|amd64|AMD64")
        set(IS_X64 TRUE)
    endif()
endif()
if (CMAKE_SYSTEM_PROCESSOR MATCHES "arm|ARM|aarch64|arm64|ARM64|armeb|aarch64be|aarch64_be")
    set(IS_ARM TRUE)
endif()
if (CMAKE_SYSTEM_PROCESSOR MATCHES "riscv64|rv64")
    set(IS_RISCV64 TRUE)
endif()
if (CMAKE_SYSTEM_PROCESSOR MATCHES "riscv32|rv32")
    set(IS_RISCV32 TRUE)
endif()

include(CheckCXXCompilerFlag)
include(CheckIncludeFileCXX)
include(CheckCXXSymbolExists)
include(CheckIncludeFiles)
include(CheckFunctionExists)
include(CheckSymbolExists)
include(CheckTypeSize)
include(TestBigEndian)
include(CheckLibraryExists)

find_package(Threads REQUIRED)

add_compile_definitions(HAVE_CONFIG_H PARPAR_ENABLE_HASHER_MD5CRC PARPAR_INVERT_SUPPORT PARPAR_SLIM_GF16)

if(MSVC)
    enable_language(ASM_MASM)
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|AppleClang")
        add_compile_options(-Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic)
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        add_compile_options(-Wall -Wextra)
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        add_compile_options(/MTd /Zi /MP /W4 /utf-8)
    endif()

elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        add_compile_options(/MT /Oi /MP /utf-8 /guard:cf)
        add_link_options(/guard:cf /OPT:REF /OPT:ICF)
    else()
        add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-rtti> -ffunction-sections -fdata-sections -Wno-unused-function)
    endif()

    if(CMAKE_SYSTEM_NAME MATCHES "Darwin")
        add_link_options(-Wl,-dead_strip)
    else()
        add_link_options(-Wl,--gc-sections)
    endif()

    check_cxx_compiler_flag("-fstack-protector-strong" HAVE_STACK_PROTECT)
    if(HAVE_STACK_PROTECT AND NOT CMAKE_SYSTEM_PROCESSOR STREQUAL "powerpc")
      add_compile_options(-fstack-protector-strong)
    endif()
endif()

if(USE_SANITIZERS)
    if(MSVC)
        add_compile_options(/fsanitize=address)
        add_link_options(/fsanitize=address)
    else()
        add_compile_options(
            -fsanitize=${USE_SANITIZERS}
            -fno-omit-frame-pointer
            -fno-sanitize-recover=all
        )
        add_link_options(
            -fsanitize=${USE_SANITIZERS}
        )
    endif()
endif()
