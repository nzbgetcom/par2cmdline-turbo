#ifndef __HASHER_H__
#define __HASHER_H__

// Wrapper for ParPar's InputHasher

#include <par2/hasher/hasher.h>
#include <par2/md5.h>
#include <par2/libpar2.h>

namespace Par2
{

inline u32 HasherGetBlock(IHasherInput* hasher, MD5Hash& blockhash, u64 zeropad = 0)
{
  u8 md5crc[20];
  hasher->getBlock(md5crc, zeropad);
  memcpy(blockhash.hash, md5crc, 16);
  return md5crc[16] | (md5crc[17] << 8) | (md5crc[18] << 16) | (md5crc[19] << 24);
}

}

#endif // __HASHER_H__
