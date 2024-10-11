#include <par2/osinfo/platform.h>

// disable CRC on GCC versions with broken arm_acle.h
#if defined(__ARM_FEATURE_CRC32) && defined(HEDLEY_GCC_VERSION)
# if !defined(__aarch64__) && HEDLEY_GCC_VERSION_CHECK(7,0,0) && !HEDLEY_GCC_VERSION_CHECK(8,1,1)
#  undef __ARM_FEATURE_CRC32
# endif
# if defined(__aarch64__) && HEDLEY_GCC_VERSION_CHECK(9,4,0) && !HEDLEY_GCC_VERSION_CHECK(9,5,0)
#  undef __ARM_FEATURE_CRC32
# endif
#endif
#if defined(__ARM_FEATURE_CRC32) && defined(__has_include)
# if !__has_include(<arm_acle.h>)
#  undef __ARM_FEATURE_CRC32
# endif
#endif


#define HasherInput HasherInput_NEONCRC
#define _FNMD5x2(f) f##_neon
#define _FNCRC(f) f##_arm

#if (defined(__ARM_FEATURE_CRC32) && defined(__ARM_NEON)) || (defined(_M_ARM64) && !defined(__clang__)) // MSVC doesn't support CRC for ARM32
# include <par2/hasher/crc_arm.h>
# include <par2/hasher/md5x2-neon.h>
# include <par2/hasher/hasher_input_base.h>
#else
# include <par2/hasher/hasher_input_stub.h>
#endif
