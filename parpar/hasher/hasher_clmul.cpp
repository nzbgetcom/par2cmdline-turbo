#include <par2/osinfo/platform.h>

#define _FNCRC(f) f##_clmul

#define HasherInput HasherInput_ClMulSSE
#define _FNMD5x2(f) f##_sse

#if defined(__PCLMUL__) && defined(__SSSE3__) && defined(__SSE4_1__)
# include <par2/hasher/crc_clmul.h>
# include <par2/hasher/md5x2-sse.h>
# include <par2/hasher/hasher_input_base.h>
#else
# include <par2/hasher/hasher_input_stub.h>
#endif

#undef HasherInput
#undef _FNMD5x2
#define HasherInput HasherInput_ClMulScalar
#define CRC32Impl(n) n##_ClMul
#define MD5CRC(f) MD5CRC_##f##_ClMul
#define _FNMD5(f) f##_scalar
#define _FNMD5x2(f) f##_scalar

#if defined(__PCLMUL__) && defined(__SSSE3__) && defined(__SSE4_1__)
# include <par2/hasher/md5x2-scalar.h>
# include <par2/hasher/md5-scalar.h>
# include <par2/hasher/hasher_input_base.h>
# include <par2/hasher/hasher_md5crc_base.h>
#else
# include <par2/hasher/hasher_input_stub.h>
# include <par2/hasher/hasher_md5crc_stub.h>
#endif

#undef MD5CRC
#undef _FNMD5
#undef CRC32Impl


#define MD5SingleVer(f) MD5Single_##f##_NoLEA
#define MD5CRC(f) MD5CRC_##f##_NoLEA
#define _FNMD5(f) f##_nolea

#if defined(__PCLMUL__) && defined(__SSSE3__) && defined(__SSE4_1__) && defined(MD5_HAS_NOLEA)
# include <par2/hasher/hasher_md5crc_base.h>
#else
# include <par2/hasher/hasher_md5crc_stub.h>
#endif
