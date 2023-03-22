dnl  This file is part of par2cmdline (a PAR 2.0 compatible file verification and
dnl  repair tool). See http://parchive.sourceforge.net for details of PAR 2.0.
dnl
dnl  Copyright (c) 2003-2015 Peter Brian Clements
dnl  Copyright (c) 2011-2012 Marcel Partap
dnl  Copyright (c) 2012-2015 Ike Devolder
dnl  Copyright (c) 2019 Michael D. Nahas
dnl
dnl  par2cmdline is free software; you can redistribute it and/or modify
dnl  it under the terms of the GNU General Public License as published by
dnl  the Free Software Foundation; either version 2 of the License, or
dnl  (at your option) any later version.
dnl
dnl  par2cmdline is distributed in the hope that it will be useful,
dnl  but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl  GNU General Public License for more details.
dnl
dnl  You should have received a copy of the GNU General Public License
dnl  along with this program; if not, write to the Free Software
dnl  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
dnl                                               -*- Autoconf -*-
dnl Process this file with autoconf to produce a configure script.

AC_PREREQ(2.62)
AC_INIT([par2cmdline-turbo], [0.9.0])
AC_CONFIG_SRCDIR([src/par2cmdline.cpp])

AC_CANONICAL_HOST

AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE


dnl Checks for programs.
AC_PROG_CXX
AC_PROG_INSTALL

dnl Need to define RANLIB used in making static library.
AC_PROG_RANLIB
dnl gnu.org says the following may be needed for Microsoft libraries.
AM_PROG_AR


dnl Set language to C++
AC_LANG(C++)

dnl Checks for header files.
AC_HEADER_DIRENT
AC_HEADER_STDBOOL
AC_HEADER_STDC
AC_CHECK_HEADERS([stdio.h] [endian.h])
AC_CHECK_HEADERS([getopt.h] [limits.h])

dnl Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_SIZE_T
AC_C_BIGENDIAN
AC_C_CONST
AC_C_INLINE
AC_SYS_LARGEFILE
AC_FUNC_FSEEKO

dnl Check for OpenMP
AC_OPENMP

dnl Checks for library functions.
AC_FUNC_MEMCMP
AC_CHECK_FUNCS([stricmp] [strcasecmp])
AC_CHECK_FUNCS([strchr] [memcpy])

AC_CHECK_FUNCS([getopt] [getopt_long])

dnl Platform detection / flags supported by compiler
m4_include([m4/ax_check_compile_flag.m4])
AX_CHECK_COMPILE_FLAG([-msse2], , , [-Werror])
AM_CONDITIONAL([HAS_SSE2], [test x$ax_cv_check_cxxflags__Werror__msse2 = xyes])
AM_COND_IF([HAS_SSE2], [AC_SUBST(CFLAGS_SSE2, "-msse2")])
AX_CHECK_COMPILE_FLAG([-mssse3], , , [-Werror])
AM_CONDITIONAL([HAS_SSSE3], [test x$ax_cv_check_cxxflags__Werror__mssse3 = xyes])
AM_COND_IF([HAS_SSSE3], [AC_SUBST(CFLAGS_SSSE3, "-mssse3")])
AX_CHECK_COMPILE_FLAG([-mpclmul], , , [-Werror])
AM_CONDITIONAL([HAS_PCLMUL], [test x$ax_cv_check_cxxflags__Werror__mpclmul = xyes])
AM_COND_IF([HAS_PCLMUL], [AC_SUBST(CFLAGS_PCLMUL, "-mpclmul -msse4.1")])
AX_CHECK_COMPILE_FLAG([-mavx], , , [-Werror])
AM_CONDITIONAL([HAS_AVX], [test x$ax_cv_check_cxxflags__Werror__mavx = xyes])
AM_COND_IF([HAS_AVX], [AC_SUBST(CFLAGS_AVX, "-mavx")])
AX_CHECK_COMPILE_FLAG([-mxop], , , [-Werror])
AM_CONDITIONAL([HAS_XOP], [test x$ax_cv_check_cxxflags__Werror__mxop = xyes])
AM_COND_IF([HAS_XOP], [AC_SUBST(CFLAGS_XOP, "-mavx -mxop")])
AX_CHECK_COMPILE_FLAG([-mavx2], , , [-Werror])
AM_CONDITIONAL([HAS_AVX2], [test x$ax_cv_check_cxxflags__Werror__mavx2 = xyes])
AM_COND_IF([HAS_AVX2], [AC_SUBST(CFLAGS_AVX2, "-mavx2")])
AX_CHECK_COMPILE_FLAG([-mavx512vl -mavx512bw], , , [-Werror])
AM_CONDITIONAL([HAS_AVX512], [test x$ax_cv_check_cxxflags__Werror__mavx512vl__mavx512bw = xyes])
AM_COND_IF([HAS_AVX512], [AC_SUBST(CFLAGS_AVX512, "-mavx512vl -mavx512bw")])
AM_COND_IF([HAS_AVX512], [AC_SUBST(CFLAGS_AVX512F, "-mavx512f")])
AM_COND_IF([HAS_AVX512], [AC_SUBST(CFLAGS_AVX512_HASHER, "-mavx512vl -mavx512bw -mbmi2 -mpclmul")])
AX_CHECK_COMPILE_FLAG([-mavx512vbmi], , , [-Werror])
AM_CONDITIONAL([HAS_VBMI], [test x$ax_cv_check_cxxflags__Werror__mavx512vbmi = xyes])
AM_COND_IF([HAS_VBMI], [AC_SUBST(CFLAGS_VBMI, "-mavx512vl -mavx512vbmi")])
AX_CHECK_COMPILE_FLAG([-mgfni], , , [-Werror])
AM_CONDITIONAL([HAS_GFNI], [test x$ax_cv_check_cxxflags__Werror__mgfni = xyes])
AM_COND_IF([HAS_GFNI], [AC_SUBST(CFLAGS_GFNI, "-mgfni -mssse3")])
AX_CHECK_COMPILE_FLAG([-mfpu=neon -march=armv7-a], , , [-Werror])
AM_CONDITIONAL([HAS_NEON], [test x$ax_cv_check_cxxflags__Werror__mfpu_neon = xyes])
AM_COND_IF([HAS_NEON], [AC_SUBST(CFLAGS_NEON, "-mfpu=neon -fno-lto -march=armv7-a")])
AX_CHECK_COMPILE_FLAG([-march=armv8-a+sve], , , [-Werror])
AM_CONDITIONAL([HAS_SVE], [test x$ax_cv_check_cxxflags__Werror__march_armv8_apsve = xyes])
AM_COND_IF([HAS_SVE], [AC_SUBST(CFLAGS_SVE, "-march=armv8-a+sve")])
AX_CHECK_COMPILE_FLAG([-march=armv8-a+sve2], , , [-Werror])
AM_CONDITIONAL([HAS_SVE2], [test x$ax_cv_check_cxxflags__Werror__march_armv8_apsve2 = xyes])
AM_COND_IF([HAS_SVE2], [AC_SUBST(CFLAGS_SVE2, "-march=armv8-a+sve2")])
AX_CHECK_COMPILE_FLAG([-march=armv8-a+crc], , , [-Werror])
AM_CONDITIONAL([HAS_ARMCRC], [test x$ax_cv_check_cxxflags__Werror__march_armv8_apcrc = xyes])
AM_COND_IF([HAS_ARMCRC], [AC_SUBST(CFLAGS_ARMCRC, "-march=armv8-a+crc")])

AC_CONFIG_FILES([stamp-h], [echo timestamp > stamp-h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
