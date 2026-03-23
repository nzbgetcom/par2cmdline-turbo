add_compile_definitions(
    _DARWIN_C_SOURCE
    _GNU_SOURCE
    _DEFAULT_SOURCE
)

check_include_files("dirent.h" HAVE_DIRENT_H)
check_include_files("endian.h" HAVE_ENDIAN_H)
check_include_files("getopt.h" HAVE_GETOPT_H)
check_include_files("inttypes.h" HAVE_INTTYPES_H)
check_include_files("limits.h" HAVE_LIMITS_H)
check_include_files("ndir.h" HAVE_NDIR_H)
check_include_files("stdbool.h" HAVE_STDBOOL_H)
check_include_files("stdio.h" HAVE_STDIO_H)
check_include_files("stdlib.h" HAVE_STDLIB_H)
check_include_files("strings.h" HAVE_STRINGS_H)
check_include_files("string.h" HAVE_STRING_H)
check_include_files("sys/dir.h" HAVE_SYS_DIR_H)
check_include_files("sys/ndir.h" HAVE_SYS_NDIR_H)
check_include_files("sys/stat.h" HAVE_SYS_STAT_H)
check_include_files("sys/types.h" HAVE_SYS_TYPES_H)
check_include_files("unistd.h" HAVE_UNISTD_H)
check_include_files("memory.h" HAVE_MEMORY_H)

if(HAVE_STDLIB_H AND HAVE_STRING_H)
    set(STDC_HEADERS 1)
endif()

if(IS_ARM OR ANDROID)
  check_include_files("cpu-features.h" HAVE_CPU_FEATURES)
endif()

# Function/Symbol Checks
check_function_exists(getopt HAVE_GETOPT)
check_function_exists(getopt_long HAVE_GETOPT_LONG)
check_function_exists(memcpy HAVE_MEMCPY)
check_function_exists(strcasecmp HAVE_STRCASECMP)
check_function_exists(strchr HAVE_STRCHR)
check_function_exists(stricmp HAVE_STRICMP)
check_function_exists(fseeko HAVE_FSEEKO)
check_cxx_source_compiles("
    #include <cstdlib>
    int main() {
        void* ptr = std::aligned_alloc(16, 128);
        std::free(ptr);
        return 0;
    }
" HAVE_STD_ALIGNED_ALLOC)
check_cxx_source_compiles("
    #include <stdlib.h>
    int main() {
        void* ptr;
        posix_memalign(&ptr, 16, 128);
        free(ptr);
        return 0;
    }
" HAVE_DECL_POSIX_MEMALIGN)

# Types
check_type_size("_Bool" HAVE__BOOL)

# Threading
if(Threads_FOUND)
    set(HAVE_PTHREAD 1)
endif()

# Byte Order
test_big_endian(WORDS_BIGENDIAN)

# Large File Support (LFS)
if (NOT TOOLCHAIN_PREFIX MATCHES "android")
  add_compile_definitions(_FILE_OFFSET_BITS=64 _LARGEFILE_SOURCE _LARGE_FILES)
endif()
