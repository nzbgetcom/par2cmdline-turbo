//  This file is part of par2cmdline (a PAR 2.0 compatible file verification and
//  repair tool). See https://parchive.sourceforge.net for details of PAR 2.0.
//
//  Copyright (c) 2024-2026 Denis <denis@nzbget.com>
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

#ifndef __UTF8_H__
#define __UTF8_H__

#include <string_view>
#include <optional>
#include <codecvt>

namespace Par2::utf8
{
  std::string Latin1ToUtf8(std::string_view latin1Str);

#ifdef _WIN32
  inline constexpr int MAX_ARGS = 127;
  inline constexpr size_t MAX_DIR_PATH = 248;
  inline constexpr int STACK_BUFFER_SIZE = 1024;

  std::optional<std::wstring> Utf8ToWide(std::string_view str);
  std::optional<std::string> WideToUtf8(std::wstring_view str);

  class WideToUtf8ArgsAdapter final
  {
  public:
    WideToUtf8ArgsAdapter(int argc, wchar_t* argv_[]) noexcept(false);

    const char* const* GetUtf8Args() const noexcept;

    WideToUtf8ArgsAdapter() = delete;
    WideToUtf8ArgsAdapter(const WideToUtf8ArgsAdapter&) = delete;
    WideToUtf8ArgsAdapter(WideToUtf8ArgsAdapter&&) = delete;
    WideToUtf8ArgsAdapter& operator=(const WideToUtf8ArgsAdapter&) = delete;
    WideToUtf8ArgsAdapter& operator=(WideToUtf8ArgsAdapter&&) = delete;

    ~WideToUtf8ArgsAdapter();

  private:
    char** m_argv;
    int m_argc;
  };
#endif
}

#endif // __UTF8_H__
