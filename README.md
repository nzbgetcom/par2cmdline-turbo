This is a *simple* fork of [par2cmdline](https://github.com/Parchive/par2cmdline) which replaces core computation routines with [ParPar’s](https://github.com/animetosho/ParPar) processing backend, improving par2cmdline’s performance on x86/ARM platforms.

The original par2cmdline README [can be found here](https://github.com/Parchive/par2cmdline/blob/master/README.md), which covers more info including build and usage instructions.

# Differences with par2cmdline

par2cmdline-turbo aims to keep close with its upstream and only differs in the following areas related to performance. As such, the scope of this project covers:

* GF16, MD5 and CRC32 computation, using ParPar’s implementation
* Use ParPar’s internal checksumming to detect RAM errors during GF16 computation
* Adopts ParPar’s stitched hashing approach

Note that this fork isn’t intended to change too much of par2cmdline itself, meaning that there’s some degree of performance left on the table.

This fork is also *not* aimed at fixing bugs or functionality improvements - reports and requests should be directed at the [upstream project](https://github.com/Parchive/par2cmdline).

## Threading & OpenMP

par2cmdline uses OpenMP to manage threading. ParPar’s GF16 backend has its own threading support, using C++11’s `std::thread`, which means that threading will generally be available even if OpenMP is enabled. However, par2cmdline does use OpenMP in a number of other places (such as file processing), which are still present in this fork.

This does have a flow on effect that the `-t` flag and libpar2’s *threads* parameter will be present and work, even if OpenMP is not enabled.

## Compared to other par2cmdline forks

I know of two other forks to par2cmdline: [par2cmdline-tbb](https://web.archive.org/web/20150526072258/http://www.chuchusoft.com/par2_tbb) and [phpar2](http://www.paulhoule.com/phpar2/index.php), both of which focus on performance (like this fork). Key changes of those forks, over the original upstream par2cmdline, from what I can gather:

**par2cmdline-tbb**

* adds multi-threading via TBB
* adds MMX optimized routines for GF16 computation (from phpar2)
* adds support for concurrency during creation/verification/repair
* adds experimental CUDA (GPU) support
* async I/O
* only available on x86 platforms, due to use of Intel TBB and x86 assembly

**phpar2**

* adds multi-threading
* adds MMX optimized routines for GF16 computation
* assembly optimized MD5 routine
* only available on x86 Windows platforms, due to use of x86 assembly and Windows API reliance

**par2cmdline-turbo** differences:

* the above forks were based off the original par2cmdline (0.4?), whereas this fork is based off (at time of writing) the latest ‘mainline’ fork (0.8.1 with unreleased changes)
* faster GF16 techniques, taking advantage of modern SIMD extensions, are used instead of MMX
* faster CRC32 implementations
* uses stitched MD5+CRC32 hashing
* does not add support for async I/O, though it might get some due to the async nature of ParPar’s GF16 backend
* does not add GPU computation (but ParPar has elementary OpenCL support, so might arrive in the future)
* optimizations for ARM CPUs
* cross-platform support

## Benchmarks

Some speed comparisons posted by others:

* [PAR2 create](https://github.com/animetosho/ParPar/blob/master/benchmarks/info.md)
* [PAR2 create](https://github.com/animetosho/par2cmdline-turbo/issues/4#issue-1640569835) (v0.9.0)
* [PAR2 verification/repair](https://gist.github.com/thezoggy/3c243b712f0cc960fa4dd78ff1ab56e7) (multiple machines/OSes)

# Relation with ParPar

[ParPar](https://github.com/animetosho/ParPar) is a from-scratch PAR2 implementation, different from par2cmdline, but only focuses on PAR2 creation.

Key reasons to use par2cmdline-turbo over ParPar:

* drop-in par2cmdline replacement
* par2cmdline supports verification and repair, where ParPar does not

Key reasons to use ParPar over par2cmdline-turbo:

* par2cmdline-turbo doesn’t implement all performance optimisations in ParPar, such as async I/O, streaming hash computation etc
* features unique to ParPar, such as auto-slice size scaling
* currently ParPar is more actively maintained than par2cmdline; changes common to these two projects will first be made in ParPar before being ported to par2cmdline-turbo

# Installation

Pre-built binaries for common systems are available on the [releases page](https://github.com/animetosho/par2cmdline-turbo/releases).

## Packages

* Arch Linux: [AUR](https://aur.archlinux.org/packages/par2cmdline-turbo) ([git](https://aur.archlinux.org/packages/par2cmdline-turbo-git))

## Building

* Relatively recent compilers are recommended to take advantage of recent SIMD support (e.g. MSVC >=2019, GCC >=10)
* ParPar backend requires C++11 support

See [original README](https://github.com/Parchive/par2cmdline/blob/master/README.md#compiling-par2cmdline) for build instructions.

# Issues & Bugs

If you have an issue, please test with the original par2cmdline. If the issue is present there, please report it to the par2cmdline repository. Only report issues specific to par2cmdline-turbo here.

Similarly, questions should also be directed to the par2cmdline repository, unless it *specifically* relates to par2cmdline-turbo.

