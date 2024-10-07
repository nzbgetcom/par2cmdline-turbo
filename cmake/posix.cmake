include(CheckIncludeFiles)
include(CheckLibraryExists)
include(CheckCompilerFlag)
include(CheckCCompilerFlag)
include(CheckFunctionExists)

add_compile_definitions(
    _DARWIN_C_SOURCE
    _GNU_SOURCE
    _DEFAULT_SOURCE
)

check_include_file(dirent.h HAVE_DIRENT_H)
check_include_file(stdbool.h HAVE_STDBOOL_H)
check_include_file(stdio.h HAVE_STDIO_H)
check_include_file(endian.h HAVE_ENDIAN_H)
check_include_file(getopt.h HAVE_GETOPT_H)
check_include_file(limits.h HAVE_LIMITS_H)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(memory.h HAVE_MEMORY_H)
check_include_file(ndir.h HAVE_NDIR_H)
check_include_file(sys/ndir.h HAVE_SYS_NDIR_H)
check_include_file(sys/ndir.h HAVE_SYS_NDIR_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(string.h HAVE_STRING_H)
check_include_file(sys/stat.h HAVE_SYS_STAT_H)
check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(unistd.h HAVE_UNISTD_H)
check_include_file(unistd.h HAVE_UNISTD_H)

check_function_exists(fseeko HAVE_FSEEKO)
check_function_exists(memcmp HAVE_MEMCMP)
check_function_exists(stricmp HAVE_STRICMP)
check_function_exists(strcasecmp HAVE_STRCASECMP)
check_function_exists(strchr HAVE_STRCHR)
check_function_exists(memcpy HAVE_MEMCPY)
check_function_exists(getopt_long HAVE_GETOPT_LONG)
check_function_exists(getopt HAVE_GETOPT)
