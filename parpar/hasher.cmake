set(HASHER_LIBRARY "hasher")
set(LIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/parpar/hasher)

set(HASHER_LIBRARY_SRC 
    ${LIB_DIR}/crc_zeropad.c
    ${LIB_DIR}/hasher.cpp
    ${LIB_DIR}/hasher_scalar.cpp
    ${LIB_DIR}/hasher_input.cpp
    ${LIB_DIR}/hasher_md5crc.cpp
    ${LIB_DIR}/tables.cpp
    ${LIB_DIR}/md5-final.c
    ${LIB_DIR}/hasher_sse.cpp
    ${LIB_DIR}/hasher_clmul.cpp
    ${LIB_DIR}/hasher_xop.cpp
    ${LIB_DIR}/hasher_bmi1.cpp
    ${LIB_DIR}/hasher_avx2.cpp
    ${LIB_DIR}/hasher_avx512.cpp
    ${LIB_DIR}/hasher_avx512vl.cpp
    ${LIB_DIR}/hasher_armcrc.cpp
    ${LIB_DIR}/hasher_neon.cpp
    ${LIB_DIR}/hasher_neoncrc.cpp
    ${LIB_DIR}/hasher_sve2.cpp
    ${LIB_DIR}/hasher_rvzbc.cpp
)

if(NOT MSVC OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    if(IS_X86)
        set_source_files_properties(${LIB_DIR}/hasher_avx2.cpp PROPERTIES COMPILE_OPTIONS -mavx2)
        set_source_files_properties(${LIB_DIR}/hasher_avx512.cpp PROPERTIES COMPILE_OPTIONS "-mavx512f")
        CHECK_CXX_COMPILER_FLAG("-mno-evex512" COMPILER_SUPPORTS_AVX10)
        if(COMPILER_SUPPORTS_AVX10)
            set_source_files_properties(${LIB_DIR}/hasher_avx512vl.cpp PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw;-mbmi2;-mpclmul;-mno-evex512")
        else()
            set_source_files_properties(${LIB_DIR}/hasher_avx512vl.cpp PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw;-mbmi2;-mpclmul")
        endif()
        set_source_files_properties(${LIB_DIR}/hasher_bmi1.cpp PROPERTIES COMPILE_OPTIONS "-mpclmul;-mavx;-mbmi")
        set_source_files_properties(${LIB_DIR}/hasher_clmul.cpp PROPERTIES COMPILE_OPTIONS "-mpclmul;-msse4.1")
        set_source_files_properties(${LIB_DIR}/hasher_sse.cpp PROPERTIES COMPILE_OPTIONS -msse2)
        set_source_files_properties(${LIB_DIR}/hasher_xop.cpp PROPERTIES COMPILE_OPTIONS "-mxop;-mavx")
    endif()
    
    if(IS_ARM)
        CHECK_CXX_COMPILER_FLAG("-mfpu=neon -march=armv7-a" COMPILER_SUPPORTS_ARM32_NEON)
        if(COMPILER_SUPPORTS_ARM32_NEON)
            set_source_files_properties(${LIB_DIR}/hasher_neon.cpp PROPERTIES COMPILE_OPTIONS "-mfpu=neon;-march=armv7-a")
            set_source_files_properties(${LIB_DIR}/hasher_neoncrc.cpp PROPERTIES COMPILE_OPTIONS "-mfpu=neon;-march=armv8-a+crc")
            set_source_files_properties(${LIB_DIR}/hasher_armcrc.cpp PROPERTIES COMPILE_OPTIONS "-mfpu=fp-armv8;-march=armv8-a+crc")
        else()
            CHECK_CXX_COMPILER_FLAG("-march=armv8-a+crc" COMPILER_SUPPORTS_ARM_CRC)
            if(COMPILER_SUPPORTS_ARM_CRC)
                set_source_files_properties(${LIB_DIR}/hasher_neoncrc.cpp PROPERTIES COMPILE_OPTIONS -march=armv8-a+crc)
                set_source_files_properties(${LIB_DIR}/hasher_armcrc.cpp PROPERTIES COMPILE_OPTIONS -march=armv8-a+crc)
            endif()
        endif()
        CHECK_CXX_COMPILER_FLAG("-march=armv8-a+sve2" COMPILER_SUPPORTS_SVE2)
        if(COMPILER_SUPPORTS_SVE2)
            set_source_files_properties(${LIB_DIR}/hasher_sve2.cpp PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve2)
        endif()
    endif()
    
    if(IS_RISCV64)
        CHECK_CXX_COMPILER_FLAG("-march=rv64gc_zbkc" COMPILER_SUPPORTS_RVZBKC)
        if(COMPILER_SUPPORTS_RVZBKC)
            set_source_files_properties(${LIB_DIR}/hasher_rvzbc.cpp PROPERTIES COMPILE_OPTIONS -march=rv64gc_zbkc)
        endif()
    endif()
    if(IS_RISCV32)
        CHECK_CXX_COMPILER_FLAG("-march=rv32gc_zbkc" COMPILER_SUPPORTS_RVZBKC)
        if(COMPILER_SUPPORTS_RVZBKC)
            set_source_files_properties(${LIB_DIR}/hasher_rvzbc.cpp PROPERTIES COMPILE_OPTIONS -march=rv32gc_zbkc)
        endif()
    endif()
endif()

add_library(${HASHER_LIBRARY} STATIC ${HASHER_LIBRARY_SRC})
target_include_directories(${HASHER_LIBRARY} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

set(LIBS ${LIBS} ${HASHER_LIBRARY})
