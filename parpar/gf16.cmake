set(GF16_LIBRARY "gf16")
set(LIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16)

set(GF16_LIBRARY_SRC 
    ${LIB_DIR}/gf16mul.cpp
    ${LIB_DIR}/gfmat_coeff.c
    ${LIB_DIR}/gfmat_inv.cpp
    ${LIB_DIR}/gf16pmul.cpp
    ${LIB_DIR}/gf16_affine_avx512.c
    ${LIB_DIR}/gf16_affine_avx2.c
    ${LIB_DIR}/gf16_affine_gfni.c
    ${LIB_DIR}/gf16_affine_avx10.c
    ${LIB_DIR}/gf16_lookup.c
    ${LIB_DIR}/gf16_lookup_sse2.c
    ${LIB_DIR}/gf16_shuffle_avx.c
    ${LIB_DIR}/gf16_shuffle_avx2.c
    ${LIB_DIR}/gf16_shuffle_avx512.c
    ${LIB_DIR}/gf16_shuffle_vbmi.c
    ${LIB_DIR}/gf16_shuffle_neon.c
    ${LIB_DIR}/gf16_shuffle128_sve.c
    ${LIB_DIR}/gf16_shuffle128_sve2.c
    ${LIB_DIR}/gf16_shuffle2x128_sve2.c
    ${LIB_DIR}/gf16_shuffle512_sve2.c
    ${LIB_DIR}/gf16_shuffle128_rvv.c
    ${LIB_DIR}/gf16_clmul_rvv.c
    ${LIB_DIR}/gf16_clmul_neon.c
    ${LIB_DIR}/gf16_clmul_sha3.c
    ${LIB_DIR}/gf16_clmul_sve2.c
    ${LIB_DIR}/gf16_shuffle_ssse3.c
    ${LIB_DIR}/gf16_xor_avx2.c
    ${LIB_DIR}/gf16_xor_avx512.c
    ${LIB_DIR}/gf16_xor_sse2.c
    ${LIB_DIR}/gf_add_sse2.c
    ${LIB_DIR}/gf_add_avx2.c
    ${LIB_DIR}/gf_add_avx512.c
    ${LIB_DIR}/gf_add_avx10.c
    ${LIB_DIR}/gf_add_neon.c
    ${LIB_DIR}/gf_add_sve.c
    ${LIB_DIR}/gf_add_sve2.c
    ${LIB_DIR}/gf_add_rvv.c
    ${LIB_DIR}/gf_add_generic.c
    ${LIB_DIR}/gf16_cksum_sse2.c
    ${LIB_DIR}/gf16_cksum_avx2.c
    ${LIB_DIR}/gf16_cksum_avx512.c
    ${LIB_DIR}/gf16_cksum_neon.c
    ${LIB_DIR}/gf16_cksum_sve.c
    ${LIB_DIR}/gf16_cksum_rvv.c
    ${LIB_DIR}/gf16_cksum_generic.c
    ${LIB_DIR}/gf16pmul_sse.c
    ${LIB_DIR}/gf16pmul_avx2.c
    ${LIB_DIR}/gf16pmul_vpclmul.c
    ${LIB_DIR}/gf16pmul_vpclgfni.c
    ${LIB_DIR}/gf16pmul_neon.c
    ${LIB_DIR}/gf16pmul_sve2.c
    ${LIB_DIR}/gf16pmul_rvv.c
    ${LIB_DIR}/controller.cpp
    ${LIB_DIR}/controller_cpu.cpp
    ${LIB_DIR}/platform_warnings.c
)

if (MSVC AND IS_X64)
    set(GF16_LIBRARY_SRC ${GF16_LIBRARY_SRC} ${LIB_DIR}/xor_jit_stub_masm64.asm)
endif()

if(MSVC)
    if(IS_X86)
        set_source_files_properties(${LIB_DIR}/gf_add_avx2.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf_add_avx10.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf_add_avx512.c PROPERTIES COMPILE_OPTIONS /arch:AVX512)
        set_source_files_properties(${LIB_DIR}/gf16_affine_avx2.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf16_affine_avx10.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf16_affine_avx512.c PROPERTIES COMPILE_OPTIONS /arch:AVX512)
        set_source_files_properties(${LIB_DIR}/gf16_cksum_avx2.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf16_cksum_avx512.c PROPERTIES COMPILE_OPTIONS /arch:AVX512)
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_avx.c PROPERTIES COMPILE_OPTIONS /arch:AVX)
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_avx2.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_avx512.c PROPERTIES COMPILE_OPTIONS /arch:AVX512)
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_vbmi.c PROPERTIES COMPILE_OPTIONS /arch:AVX512)
        set_source_files_properties(${LIB_DIR}/gf16_xor_avx2.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf16_xor_avx512.c PROPERTIES COMPILE_OPTIONS /arch:AVX512)
        set_source_files_properties(${LIB_DIR}/gf16pmul_avx2.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf16pmul_vpclgfni.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
        set_source_files_properties(${LIB_DIR}/gf16pmul_vpclmul.c PROPERTIES COMPILE_OPTIONS /arch:AVX2)
    endif()
endif()
if(NOT MSVC OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    if(IS_X86)
        set_source_files_properties(${LIB_DIR}/gf_add_avx2.c PROPERTIES COMPILE_OPTIONS -mavx2)
        set_source_files_properties(${LIB_DIR}/gf_add_avx512.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw")
        set_source_files_properties(${LIB_DIR}/gf_add_sse2.c PROPERTIES COMPILE_OPTIONS -msse2)
        set_source_files_properties(${LIB_DIR}/gf16_cksum_avx2.c PROPERTIES COMPILE_OPTIONS -mavx2)
        set_source_files_properties(${LIB_DIR}/gf16_cksum_avx512.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw")
        set_source_files_properties(${LIB_DIR}/gf16_cksum_sse2.c PROPERTIES COMPILE_OPTIONS -msse2)
        set_source_files_properties(${LIB_DIR}/gf16_lookup_sse2.c PROPERTIES COMPILE_OPTIONS -msse2)
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_avx.c PROPERTIES COMPILE_OPTIONS -mavx)
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_avx2.c PROPERTIES COMPILE_OPTIONS -mavx2)
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_avx512.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw")
        set_source_files_properties(${LIB_DIR}/gf16_shuffle_ssse3.c PROPERTIES COMPILE_OPTIONS -mssse3)
        set_source_files_properties(${LIB_DIR}/gf16_xor_avx2.c PROPERTIES COMPILE_OPTIONS -mavx2)
        set_source_files_properties(${LIB_DIR}/gf16_xor_avx512.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw")
        set_source_files_properties(${LIB_DIR}/gf16_xor_sse2.c PROPERTIES COMPILE_OPTIONS -msse2)
        set_source_files_properties(${LIB_DIR}/gf16pmul_avx2.c PROPERTIES COMPILE_OPTIONS "-mavx2;-mpclmul")
        set_source_files_properties(${LIB_DIR}/gf16pmul_sse.c PROPERTIES COMPILE_OPTIONS "-msse4.1;-mpclmul")
        
        CHECK_CXX_COMPILER_FLAG("-mavx512vl -mavx512bw -mavx512vbmi" COMPILER_SUPPORTS_VBMI)
        if(COMPILER_SUPPORTS_VBMI)
            set_source_files_properties(${LIB_DIR}/gf16_shuffle_vbmi.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw;-mavx512vbmi")
        endif()
        CHECK_CXX_COMPILER_FLAG("-mgfni" COMPILER_SUPPORTS_GFNI)
        if(COMPILER_SUPPORTS_GFNI)
            set_source_files_properties(${LIB_DIR}/gf16_affine_avx2.c PROPERTIES COMPILE_OPTIONS "-mavx2;-mgfni")
            set_source_files_properties(${LIB_DIR}/gf16_affine_avx512.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw;-mgfni")
            set_source_files_properties(${LIB_DIR}/gf16_affine_gfni.c PROPERTIES COMPILE_OPTIONS "-mssse3;-mgfni")
            
            set_source_files_properties(${SRC_DIR}/platform_warnings.c PROPERTIES COMPILE_OPTIONS "-mavx2;-mgfni")
        endif()
        CHECK_CXX_COMPILER_FLAG("-mno-evex512" COMPILER_SUPPORTS_AVX10)
        if(COMPILER_SUPPORTS_AVX10 AND COMPILER_SUPPORTS_GFNI)
            set_source_files_properties(${LIB_DIR}/gf16_affine_avx10.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mavx512bw;-mgfni;-mno-evex512")
        endif()
        if(COMPILER_SUPPORTS_AVX10)
            set_source_files_properties(${LIB_DIR}/gf_add_avx10.c PROPERTIES COMPILE_OPTIONS "-mavx512vl;-mno-evex512")
        endif()
        
        CHECK_CXX_COMPILER_FLAG("-mvpclmulqdq" COMPILER_SUPPORTS_VPCLMULQDQ)
        if(COMPILER_SUPPORTS_VPCLMULQDQ)
            set_source_files_properties(${LIB_DIR}/gf16pmul_vpclmul.c PROPERTIES COMPILE_OPTIONS "-mavx2;-mvpclmulqdq")
        endif()
        if(COMPILER_SUPPORTS_VPCLMULQDQ AND COMPILER_SUPPORTS_GFNI)
            set_source_files_properties(${LIB_DIR}/gf16pmul_vpclgfni.c PROPERTIES COMPILE_OPTIONS "-mavx2;-mvpclmulqdq;-mgfni")
        endif()
    endif()
    
    if(IS_ARM)
        CHECK_CXX_COMPILER_FLAG("-mfpu=neon -march=armv7-a" COMPILER_SUPPORTS_ARM32_NEON)
        if(COMPILER_SUPPORTS_ARM32_NEON)
            set_source_files_properties(${LIB_DIR}/gf_add_neon.c PROPERTIES COMPILE_OPTIONS "-mfpu=neon;-march=armv7-a")
            set_source_files_properties(${LIB_DIR}/gf16_cksum_neon.c PROPERTIES COMPILE_OPTIONS "-mfpu=neon;-march=armv7-a")
            set_source_files_properties(${LIB_DIR}/gf16_clmul_neon.c PROPERTIES COMPILE_OPTIONS "-mfpu=neon;-march=armv7-a")
            set_source_files_properties(${LIB_DIR}/gf16_shuffle_neon.c PROPERTIES COMPILE_OPTIONS "-mfpu=neon;-march=armv7-a")
            set_source_files_properties(${LIB_DIR}/gf16pmul_neon.c PROPERTIES COMPILE_OPTIONS "-mfpu=neon;-march=armv7-a")
        endif()
        CHECK_CXX_COMPILER_FLAG("-march=armv8.2-a+sha3" COMPILER_SUPPORTS_SHA3)
        if(COMPILER_SUPPORTS_SHA3)
            set_source_files_properties(${LIB_DIR}/gf16_clmul_sha3.c PROPERTIES COMPILE_OPTIONS -march=armv8.2-a+sha3)
        endif()
        
        CHECK_CXX_COMPILER_FLAG("-march=armv8-a+sve" COMPILER_SUPPORTS_SVE)
        if(COMPILER_SUPPORTS_SVE)
            set_source_files_properties(${LIB_DIR}/gf_add_sve.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve)
            set_source_files_properties(${LIB_DIR}/gf16_cksum_sve.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve)
            set_source_files_properties(${LIB_DIR}/gf16_shuffle128_sve.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve)
        endif()
        
        CHECK_CXX_COMPILER_FLAG("-march=armv8-a+sve2" COMPILER_SUPPORTS_SVE2)
        if(COMPILER_SUPPORTS_SVE2)
            set_source_files_properties(${LIB_DIR}/gf_add_sve2.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve2)
            set_source_files_properties(${LIB_DIR}/gf16_clmul_sve2.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve2)
            set_source_files_properties(${LIB_DIR}/gf16_shuffle2x128_sve2.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve2)
            set_source_files_properties(${LIB_DIR}/gf16_shuffle128_sve2.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve2)
            set_source_files_properties(${LIB_DIR}/gf16_shuffle512_sve2.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve2)
            set_source_files_properties(${LIB_DIR}/gf16pmul_sve2.c PROPERTIES COMPILE_OPTIONS -march=armv8-a+sve2)
        endif()
    endif()
    
    if(IS_RISCV64)
        CHECK_CXX_COMPILER_FLAG("-march=rv64gcv" COMPILER_SUPPORTS_RVV)
        if(COMPILER_SUPPORTS_RVV)
            set_source_files_properties(${LIB_DIR}/gf_add_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv64gcv)
            set_source_files_properties(${LIB_DIR}/gf16_cksum_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv64gcv)
            set_source_files_properties(${LIB_DIR}/gf16_shuffle128_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv64gcv)
            
            CHECK_CXX_COMPILER_FLAG("-march=rv64gcv_zvbc1" COMPILER_SUPPORTS_RVV_ZVBC)
            if(COMPILER_SUPPORTS_RVV_ZVBC)
                set_source_files_properties(${LIB_DIR}/gf16_clmul_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv64gcv_zvbc1)
                set_source_files_properties(${LIB_DIR}/gf16pmul_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv64gcv_zvbc1)
            endif()
        endif()
    endif()
    if(IS_RISCV32)
        CHECK_CXX_COMPILER_FLAG("-march=rv32gcv" COMPILER_SUPPORTS_RVV)
        if(COMPILER_SUPPORTS_RVV)
            set_source_files_properties(${LIB_DIR}/gf_add_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv32gcv)
            set_source_files_properties(${LIB_DIR}/gf16_cksum_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv32gcv)
            set_source_files_properties(${LIB_DIR}/gf16_shuffle128_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv32gcv)
            
            CHECK_CXX_COMPILER_FLAG("-march=rv32gcv_zvbc1" COMPILER_SUPPORTS_RVV_ZVBC)
            if(COMPILER_SUPPORTS_RVV_ZVBC)
                set_source_files_properties(${LIB_DIR}/gf16_clmul_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv32gcv_zvbc1)
                set_source_files_properties(${LIB_DIR}/gf16pmul_rvv.c PROPERTIES COMPILE_OPTIONS -march=rv32gcv_zvbc1)
            endif()
        endif()
    endif()
endif()

add_library(${GF16_LIBRARY} STATIC ${GF16_LIBRARY_SRC})
target_link_libraries(${GF16_LIBRARY} PRIVATE Threads::Threads)
target_include_directories(${GF16_LIBRARY} PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${LIB_DIR}/gf16/opencl-include
)
target_compile_definitions(${GF16_LIBRARY} PRIVATE  
    PARPAR_INVERT_SUPPORT
    PARPAR_SLIM_GF16
)

set(LIBS ${LIBS} ${GF16_LIBRARY})
