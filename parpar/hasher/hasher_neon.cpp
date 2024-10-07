#include <par2/osinfo/platform.h>
#include <par2/hasher/crc_slice4.h>


#define HasherInput HasherInput_NEON
#define _FNMD5x2(f) f##_neon
#define _FNCRC(f) f##_slice4
#define MD5Multi MD5Multi_NEON
#define _FNMD5mb(f) f##_neon
#define _FNMD5mb2(f) f##_neon
#define md5mb_base_regions md5mb_regions_neon
#define md5mb_alignment md5mb_alignment_neon
#define CLEAR_VEC (void)0

#ifdef __ARM_NEON
# include <par2/hasher/md5x2-neon.h>
# include <par2/hasher/md5mb-neon.h>
# include <par2/hasher/hasher_input_base.h>
# include <par2/hasher/hasher_md5mb_base.h>
#else
# include <par2/hasher/hasher_input_stub.h>
# include <par2/hasher/hasher_md5mb_stub.h>
#endif

#undef MD5Multi
#undef _FNMD5mb2
#define MD5Multi MD5Multi2_NEON
#define _FNMD5mb2(f) f##2_neon
#define md5mb_interleave 2

#ifdef __ARM_NEON
# include <par2/hasher/hasher_md5mb_base.h>
#else
# include <par2/hasher/hasher_md5mb_stub.h>
#endif
