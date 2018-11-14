AC_INIT([CoGAPS], [3.3.7])
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
    [simd_version=$enableval], [simd_version=avx])

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

# set openmp flags, disable only if requested
AC_ARG_ENABLE(openmp, [AC_HELP_STRING([--enable-openmp],
    [compile with openMP support if available])],
    [use_openmp=$enableval], [use_openmp=yes])

AX_OPENMP
if test "x$use_openmp" != "xno" ; then
    GAPS_CXX_FLAGS+=" $OPENMP_CXXFLAGS "
    GAPS_LIBS+=" $OPENMP_CXXFLAGS "
fi

echo "building on $ax_cv_cxx_compiler_vendor compiler version $ax_cv_cxx_compiler_version"

# set compile flags for debug build
if test "x$build_debug" = "xyes" ; then
    echo "Building Debug Version of CoGAPS"
    GAPS_CPP_FLAGS+=" -DGAPS_DEBUG "
elif test "x$build_debug" = "xno" ; then
    echo "Building Release Version of CoGAPS"
elif test "x$build_debug" = "xasan" ; then
    GAPS_CXX_FLAGS+=" -fsanitize=address -fno-omit-frame-pointer "
    GAPS_LD_FLAGS+=" -fsanitize=address "
elif test "x$build_debug" = "xubsan" ; then
    GAPS_CXX_FLAGS+=" -fsanitize=undefined -fno-omit-frame-pointer "
    GAPS_LD_FLAGS+=" -fsanitize=undefined "
elif test "x$build_debug" = "xlsan" ; then
    GAPS_CXX_FLAGS+=" -fsanitize=leak -fno-omit-frame-pointer "
    GAPS_LD_FLAGS+=" -fsanitize=leak "
elif test "x$build_debug" = "xtsan" ; then
    GAPS_CXX_FLAGS+=" -fsanitize=thread -fno-omit-frame-pointer "
    GAPS_LD_FLAGS+=" -fsanitize=thread "
else
    echo "Error: Invalid Debug Options"
    exit -1
fi

# set compile flags if warnings enabled
if test "x$warnings" = "xyes" ; then
    if test "x$ax_cv_cxx_compiler_vendor" = "xgnu" || test "x$ax_cv_cxx_compiler_vendor" = "xclang"; then
        GAPS_CXX_FLAGS+=" -Wall -Wextra -Werror -Wno-unused-parameter "
    fi
fi

if test "x$use_simd" = "xno" ; then
    echo "Building without SIMD instructions"
fi

if test "x$use_simd" != "xno" ; then
    GAPS_CXX_FLAGS+=" -march=native "
fi

# export variables containing flags
AC_SUBST(GAPS_CPP_FLAGS)
AC_SUBST(GAPS_CXX_FLAGS)
AC_SUBST(GAPS_LDFLAGS)
AC_SUBST(GAPS_LIBS)

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT