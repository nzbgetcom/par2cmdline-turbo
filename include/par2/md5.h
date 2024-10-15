//  This file is part of par2cmdline (a PAR 2.0 compatible file verification and
//  repair tool). See http://parchive.sourceforge.net for details of PAR 2.0.
//
//  Copyright (c) 2003 Peter Brian Clements
//  Copyright (c) 2019 Michael D. Nahas
//
//  par2cmdline is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  par2cmdline is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

#ifndef __MD5_H__
#define __MD5_H__

#include <ostream>
#include <string>
// MD5 computation context with 64 byte buffer
#include <par2/hasher/hasher.h>

#ifdef _WIN32
#pragma pack(push, 1)
#define PACKED
#else
#define PACKED __attribute__ ((packed))
#endif

// This file defines the MD5Hash and MD5Context objects which are used
// to compute and manipulate the MD5 Hash values for a block of data.

//  Usage:
//
//  MD5Context context;
//  context.Update(buffer, length);
//
//  MD5Hash hash;
//  context.Final(hash);


namespace Par2
{

// MD5 Hash value

struct MD5Hash;
std::ostream& operator<<(std::ostream &s, const MD5Hash &hash);

struct MD5Hash
{
  // Comparison operators
  bool operator==(const MD5Hash &other) const;
  bool operator!=(const MD5Hash &other) const;

  bool operator<(const MD5Hash &other) const;
  bool operator>=(const MD5Hash &other) const;
  bool operator>(const MD5Hash &other) const;
  bool operator<=(const MD5Hash &other) const;

  // Convert value to hex
  friend std::ostream& operator<<(std::ostream &s, const MD5Hash &hash);
  std::string print(void) const;

  u8 hash[16]; // 16 byte MD5 Hash value
} PACKED;


class MD5Context
{
  MD5Single base;
public:
  inline void Reset(void) {
    base.reset();
  }

  // Process data from a buffer
  inline void Update(const void *buffer, size_t length) {
    base.update(buffer, length);
  }

  // Process 0 bytes
  void Update(size_t length) {
    base.updateZero(length);
  }

  // Compute the final hash value
  inline void Final(MD5Hash &output) {
    base.end(output.hash);
  }
};

// Compare hash values

inline bool MD5Hash::operator==(const MD5Hash &other) const
{
  return (0==memcmp(&hash, &other.hash, sizeof(hash)));
}
inline bool MD5Hash::operator!=(const MD5Hash &other) const
{
  return !operator==(other);
}

inline bool MD5Hash::operator<(const MD5Hash &other) const
{
  size_t index = 15;
  while (index > 0 && hash[index] == other.hash[index])
  {
    index--;
  }

  return hash[index] < other.hash[index];
}
inline bool MD5Hash::operator>=(const MD5Hash &other) const
{
  return !operator<(other);
}
inline bool MD5Hash::operator>(const MD5Hash &other) const
{
  return other.operator<(*this);
}
inline bool MD5Hash::operator<=(const MD5Hash &other) const
{
  return !other.operator<(*this);
}

#ifdef _WIN32
#pragma pack(pop)
#endif
#undef PACKED

}

#endif // __MD5_H__
