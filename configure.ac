AC_INIT([CoGAPS], [3.1.3])
AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects])

# Switch to a C++ compiler, and check if it works.
AC_LANG(C++)
AC_REQUIRE_CPP
AC_PROG_CXX

# Check if compiling debug version
AC_ARG_ENABLE(debug, [AC_HELP_STRING([--enable-debug],
    [build debug version of CoGAPS])], [build_debug=$enableval], [build_debug=no])

# Check if compiler warnings should be turned on
AC_ARG_ENABLE(warnings, [AC_HELP_STRING([--enable-warnings],
    [compile CoGAPS with warning messages])], [warnings=yes], [warnings=no])

# Check if specific version of SIMD instructions requested
AC_ARG_ENABLE(simd, [AC_HELP_STRING([--enable-simd],
    [specify simd instruction set (sse, avx)])],
    [simd_version=$enableval], [simd_version=sse])

# default CoGAPS specific flags
GAPS_CPP_FLAGS=" -DBOOST_MATH_PROMOTE_DOUBLE_POLICY=0 "
GAPS_CXX_FLAGS=
GAPS_LDFLAGS=
GAPS_LIBS=

# get compiler info
AX_COMPILER_VENDOR
AX_COMPILER_VERSION

# find boost libraries
AX_BOOST_BASE([1.32])
GAPS_CPP_FLAGS+=" $BOOST_CPPFLAGS "

# set openmp flags
AX_OPENMP
GAPS_CXX_FLAGS+=" $OPENMP_CXXFLAGS "
GAPS_LDFLAGS+=" $OPENMP_CXXFLAGS "

echo "building on $ax_cv_cxx_compiler_vendor compiler version $ax_cv_cxx_compiler_version"

# set compile flags for debug build
if test "x$build_debug" = "xyes" ; then
    echo "Building Debug Version of CoGAPS"
    GAPS_CPP_FLAGS+=" -DGAPS_DEBUG "
elif test "x$build_debug" = "xno" ; then
    echo "Building Release Version of CoGAPS"
elif test "x$build_debug" = "xasan" ; then
    echo "Building Debug Version of CoGAPS with AddressSanitizer"
    AX_CHECK_COMPILE_FLAG([-fsanitize=address],
        [GAPS_CXX_FLAGS+=" -fsanitize=address "])
    AX_CHECK_COMPILE_FLAG([-fsanitize=address],
        [GAPS_LD_FLAGS+=" -fsanitize=address "])
    AX_CHECK_COMPILE_FLAG([-fno-omit-frame-pointer],
        [GAPS_CXX_FLAGS+=" -fno-omit-frame-pointer "])
elif test "x$build_debug" = "xlsan" ; then
    echo "Building Debug Version of CoGAPS with LeakSanitizer"
    AX_CHECK_COMPILE_FLAG([-fsanitize=leak],
        [GAPS_CXX_FLAGS+=" -fsanitize=leak "])
    AX_CHECK_COMPILE_FLAG([-fsanitize=leak],
        [GAPS_LD_FLAGS+=" -fsanitize=leak "])
    AX_CHECK_COMPILE_FLAG([-fno-omit-frame-pointer],
        [GAPS_CXX_FLAGS+=" -fno-omit-frame-pointer "])
elif test "x$build_debug" = "xusan" ; then
    echo "Building Debug Version of CoGAPS with UndefinedBehaviorSanitizer"
    AX_CHECK_COMPILE_FLAG([-fsanitize=undefined],
        [GAPS_CXX_FLAGS+=" -fsanitize=undefined "])
    AX_CHECK_COMPILE_FLAG([-fsanitize=undefined],
        [GAPS_LD_FLAGS+=" -fsanitize=undefined "])
    AX_CHECK_COMPILE_FLAG([-fno-omit-frame-pointer],
        [GAPS_CXX_FLAGS+=" -fno-omit-frame-pointer "])
elif test "x$build_debug" = "xtsan" ; then
    echo "Building Debug Version of CoGAPS with ThreadSanitizer"
    AX_CHECK_COMPILE_FLAG([-fsanitize=thread],
        [GAPS_CXX_FLAGS+=" -fsanitize=thread "])
    AX_CHECK_COMPILE_FLAG([-fsanitize=thread],
        [GAPS_LD_FLAGS+=" -fsanitize=thread "])
    AX_CHECK_COMPILE_FLAG([-fno-omit-frame-pointer],
        [GAPS_CXX_FLAGS+=" -fno-omit-frame-pointer "])
else
    echo "Error: Invalid Debug Options"
    exit -1
fi

# set compile flags if warnings enabled
if test "x$warnings" = "xyes" ; then
    AX_CHECK_COMPILE_FLAG([-Wall], [GAPS_CXX_FLAGS+=" -Wall "])
    AX_CHECK_COMPILE_FLAG([-Wextra], [GAPS_CXX_FLAGS+=" -Wextra "])
    AX_CHECK_COMPILE_FLAG([-Werror], [GAPS_CXX_FLAGS+=" -Werror "])
    AX_CHECK_COMPILE_FLAG([-Wno-unused-parameter],
        [GAPS_CXX_FLAGS+=" -Wno-unused-parameter "])
fi

# set compile flags for SIMD
if test "x$simd_version" = "xyes" ; then
    echo "Building with SSE instructions"
    AX_CHECK_COMPILE_FLAG([-msse4.2], [GAPS_CXX_FLAGS+=" -msse4.2 "])
elif test "x$simd_version" = "xsse" ; then
    echo "Building with SSE instructions"
    AX_CHECK_COMPILE_FLAG([-msse4.2], [GAPS_CXX_FLAGS+=" -msse4.2 "])
elif test "x$simd_version" = "xavx" ; then
    echo "Building with AVX instructions"
    AX_CHECK_COMPILE_FLAG([-mavx], [GAPS_CXX_FLAGS+=" -mavx "])    
elif test "x$simd_version" = "xno" ; then
    echo "Building without SIMD instructions"
else
    echo "Error: Invalid SIMD type"
    exit -1
fi

# export variables containing flags
AC_SUBST(GAPS_CPP_FLAGS)
AC_SUBST(GAPS_CXX_FLAGS)
AC_SUBST(GAPS_LDFLAGS)
AC_SUBST(GAPS_LIBS)

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT