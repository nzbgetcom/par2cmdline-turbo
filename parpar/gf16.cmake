set(GF16_LIBRARY "gf16")
set(HASHER_LIBRARY "hasher")
set(PP_DEFINITIONS
    /W3
    /D_CONSOLE 
    /DPARPAR_INVERT_SUPPORT
    /DPARPAR_SLIM_GF16 
    /wd4267 
)

set(GF16_LIBRARY_SRC 
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16mul.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gfmat_coeff.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gfmat_inv.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx512.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_gfni.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx10.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_lookup.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_lookup_sse2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx512.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_vbmi.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_neon.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle128_sve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle128_sve2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle2x128_sve2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle512_sve2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle128_rvv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_clmul_rvv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_clmul_neon.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_clmul_sha3.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_clmul_sve2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_ssse3.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_avx2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_avx512.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_sse2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_sse2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx512.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx10.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_neon.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_sve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_sve2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_rvv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_generic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_sse2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_avx2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_avx512.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_neon.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_sve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_rvv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_generic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_sse.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_avx2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclmul.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclgfni.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_neon.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_sve2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_rvv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/controller.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/controller_cpu.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/src/platform_warnings.c
)

set(GF16_LIBRARY_SRC ${GF16_LIBRARY_SRC} ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/xor_jit_stub_masm64.asm)

# if (CMAKE_CXX_COMPILER_ID  MATCHES "Clang|AppleClang")
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mgfni)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx2.c PROPERTIES COMPILE_FLAGS -mavx2 -mgfni)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_gfni.c PROPERTIES COMPILE_FLAGS -mssse3 -mgfni)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx10.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mgfni -mno-evex512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_vbmi.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mavx512vbmi)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_ssse3.c PROPERTIES COMPILE_FLAGS -mssse3)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx10.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mno-evex512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_sse.c PROPERTIES COMPILE_FLAGS -mpclmul)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_avx2.c PROPERTIES COMPILE_FLAGS -mavx2 -mpclmul)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclmul.c PROPERTIES COMPILE_FLAGS -mavx2 -mvpclmulqdq)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclgfni.c PROPERTIES COMPILE_FLAGS -mavx2 -mvpclmulqdq -mgfni)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/src/platform_warnings.c PROPERTIES COMPILE_FLAGS -mavx2 -mgfni)
# elseif (CMAKE_CXX_COMPILER_ID  STREQUAL "GNU")
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mgfni)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx2.c PROPERTIES COMPILE_FLAGS -mavx2 -mgfni)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_gfni.c PROPERTIES COMPILE_FLAGS -mssse3 -mgfni)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx10.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mgfni -mno-evex512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_vbmi.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mavx512vbmi)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_ssse3.c PROPERTIES COMPILE_FLAGS -mssse3)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx10.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl -mno-evex512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_avx512.c PROPERTIES COMPILE_FLAGS -mavx512bw -mavx512vl)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_sse.c PROPERTIES COMPILE_FLAGS -mpclmul)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_avx2.c PROPERTIES COMPILE_FLAGS -mavx2 -mpclmul)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclmul.c PROPERTIES COMPILE_FLAGS -mavx2 -mvpclmulqdq)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclgfni.c PROPERTIES COMPILE_FLAGS -mavx2 -mvpclmulqdq -mgfni)
# elseif (CMAKE_CXX_COMPILER_ID  STREQUAL "MSVC")
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx512.c PROPERTIES COMPILE_FLAGS /arch:AVX512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx2.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_gfni.c PROPERTIES COMPILE_FLAGS /arch:SSE2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_affine_avx10.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx512.c PROPERTIES COMPILE_FLAGS /arch:AVX512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_vbmi.c PROPERTIES COMPILE_FLAGS /arch:AVX512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_ssse3.c PROPERTIES COMPILE_FLAGS /arch:SSE2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_avx2.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_avx512.c PROPERTIES COMPILE_FLAGS /arch:AVX512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx2.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx512.c PROPERTIES COMPILE_FLAGS /arch:AVX512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_avx10.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_avx2.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_avx512.c PROPERTIES COMPILE_FLAGS /arch:AVX512)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_avx2.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclmul.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_vpclgfni.c PROPERTIES COMPILE_FLAGS /arch:AVX2)
# endif()

# set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx.c PROPERTIES COMPILE_FLAGS /arch:AVX)
# set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_avx2.c PROPERTIES COMPILE_FLAGS /arch:AVX2)

# if (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86")
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_lookup_sse2.c PROPERTIES COMPILE_FLAGS /arch:SSE2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_xor_sse2.c PROPERTIES COMPILE_FLAGS /arch:SSE2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_sse2.c PROPERTIES COMPILE_FLAGS /arch:SSE2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_sse2.c PROPERTIES COMPILE_FLAGS /arch:SSE2)
#     set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_sse.c PROPERTIES COMPILE_FLAGS /arch:SSE2)
# endif()

# if(CMAKE_SYSTEM_PROCESSOR MATCHES "arm")
#     if (CMAKE_CXX_COMPILER_ID  MATCHES "Clang|AppleClang")
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle_neon.c PROPERTIES COMPILE_FLAGS -mfpu=neon)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_clmul_neon.c PROPERTIES COMPILE_FLAGS -mfpu=neon)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_neon.c PROPERTIES COMPILE_FLAGS -mfpu=neon)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_neon.c PROPERTIES COMPILE_FLAGS -mfpu=neon)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_neon.c PROPERTIES COMPILE_FLAGS -mfpu=neon)
#     endif()

# elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "arm64")
#     if (CMAKE_CXX_COMPILER_ID  MATCHES "Clang|AppleClang")
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle128_sve.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle128_sve2.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve2)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle2x128_sve2.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve2)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_shuffle512_sve2.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve2)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_clmul_sha3.c PROPERTIES COMPILE_FLAGS -march=armv8.2-a+sha3)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_clmul_sve2.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve2)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_sve.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf_add_sve2.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve2)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16_cksum_sve.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve)
#         set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/gf16pmul_sve2.c PROPERTIES COMPILE_FLAGS -march=armv8-a+sve2)
#     endif()
# endif()

add_library(${GF16_LIBRARY} STATIC ${GF16_LIBRARY_SRC})
target_include_directories(${GF16_LIBRARY} PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16
    ${CMAKE_CURRENT_SOURCE_DIR}/parpar/gf16/opencl-include
)
target_link_libraries(${GF16_LIBRARY} PRIVATE Threads::Threads)
target_compile_definitions(${GF16_LIBRARY} PRIVATE PARPAR_SLIM_GF16 /wd4267)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(PP_DEFINITIONS ${PP_DEFINITIONS} 
        /D_DEBUG
        /MTd
        /permissive-
        /GS
        /sdl
    )
elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
    set(PP_DEFINITIONS ${PP_DEFINITIONS} 
        /DNDEBUG
        /MTd
        /permissive-
        /GS-
        /sdl-
    )
    target_link_options(${GF16_LIBRARY} PRIVATE /OPT:REF /Oi)
endif()
target_compile_definitions(${GF16_LIBRARY} PRIVATE ${PP_DEFINITIONS})