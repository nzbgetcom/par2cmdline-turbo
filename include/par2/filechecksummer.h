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

#ifndef __FILECHECKSUMMER_H__
#define __FILECHECKSUMMER_H__

#include <par2/md5.h>
#include <par2/diskfile.h>

namespace Par2
{

#ifndef MIN
# define MIN(a, b) ((a)<(b) ? (a) : (b))
#endif

// This source file defines the FileCheckSummer object which is used
// when scanning a data file to find blocks of undamaged data.
//
// The object uses a "window" into the data file and slides that window
// along the file computing the CRC of the data in that window as it
// goes. If the computed CRC matches the value for a block of data
// from a target data file, then the MD5 Hash value is also computed
// and compared with the value for that block of data. When a match
// has been confirmed, the object jumps forward to where the next
// block of data is expected to start. Whilst the file is being scanned
// the object also computes the MD5 Hash of the whole file and of
// the first 16k of the file for later tests.


class FileCheckSummer
{
public:
  FileCheckSummer(DiskFile   *diskfile,
                  u64         blocksize,
                  const u32 (&windowtable)[256]);
  ~FileCheckSummer(void);

  // Start reading the file at the beginning
  bool Start(void);

  // Jump ahead the specified distance
  bool Jump(u64 distance);

  // Step forward one byte
  bool Step(void);

  // Return the current checksum
  u32 Checksum(void) const;

  // Compute and return the current hash
  MD5Hash Hash(void);

  // Compute short values of checksum and hash
  u32 ShortChecksum(u64 blocklength);
  MD5Hash ShortHash(u64 blocklength);

  // Do we have less than a full block of data
  bool ShortBlock(void) const;
  u64 BlockLength(void) const;

  // Return the current file offset
  u64 Offset(void) const;

  // Return the full file hash and the 16k file hash
  void GetFileHashes(MD5Hash &hashfull, MD5Hash &hash16k);

  // Which disk file is this
  const DiskFile* GetDiskFile(void) const {return diskfile;}

protected:
  DiskFile   *diskfile;
  u64         blocksize;
  const u32 (&windowtable)[256];

  u64         filesize;

  u64         currentoffset; // file offset for current window position
  char       *buffer;        // buffer for reading from the file
  char       *outpointer;    // position in buffer of scan window
  char       *inpointer;     // &outpointer[blocksize];
  char       *tailpointer;   // after last valid data in buffer

  // File offset for next read
  u64         readoffset;

  // Current block checksum/hash
  u32         checksum;
  MD5Hash     blockhash;
  bool        hasblockhash;  // if blockhash is valid

  // MD5 hash of whole file and of first 16k
  MD5Single   contextfull;
  MD5Single   context16k;
  IHasherInput* hasher;     // multi-hash context

protected:
  //void ComputeCurrentCRC(void);
  void UpdateHashes(u64 offset, const void *buffer, size_t length);

  //// Fill the buffers with more data from disk
  // Set longfill = true to force fill the whole buffer
  bool Fill(bool longfill = false);

  // Stop using the multi-hash context due to file/block hash desync
  void StopHasher(void);

  // Compute block hash/checksum after Jump
  void ComputeCurrentChecksum(bool domd5);

private:
  // private copy constructor to prevent any misuse.
  FileCheckSummer(const FileCheckSummer &);
  FileCheckSummer& operator=(const FileCheckSummer &);
};

// Return the current checksum

inline u32 FileCheckSummer::Checksum(void) const
{
  return checksum;
}

// Return the current block length

inline u64 FileCheckSummer::BlockLength(void) const
{
  return MIN(blocksize, filesize-currentoffset);
}

// Return whether or not the current block is a short one.
inline bool FileCheckSummer::ShortBlock(void) const
{
  return BlockLength() < blocksize;
}

// Return the current file offset
inline u64 FileCheckSummer::Offset(void) const
{
  return currentoffset;
}

// Step forward one byte
inline bool FileCheckSummer::Step(void)
{
  // Are we already at the end of the file
  if (currentoffset >= filesize)
    return false;

  // The block hash won't be in sync with the file hash any more
  StopHasher();

  // We don't have a cached block hash any more
  hasblockhash = false;

  // Advance the file offset and check to see if
  // we have reached the end of the file
  if (++currentoffset >= filesize)
  {
    currentoffset = filesize;
    tailpointer = outpointer = buffer;
    memset(buffer, 0, (size_t)blocksize);
    checksum = 0;

    return true;
  }

  // Ensure we have enough data in the buffer
  if (tailpointer <= inpointer)
    if(!Fill(true))
      return false;

  // Get the incoming and outgoing characters
  char inch = *inpointer++;
  char outch = *outpointer++;

  // Update the checksum
  checksum = CRCSlideChar(checksum, inch, outch, windowtable);

  // Can the window slide further
  if (outpointer < &buffer[blocksize])
    return true;

  assert(outpointer == &buffer[blocksize]);

  // Copy the data back to the beginning of the buffer
  memcpy(buffer, outpointer, (size_t)blocksize);
  inpointer = outpointer;
  outpointer = buffer;
  tailpointer -= blocksize;

  return true;
}

}

#endif // __FILECHECKSUMMER_H__
