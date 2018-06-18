AC_INIT([CoGAPS], [3.0])
AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects])

# Switch to a C++ compiler, and check if it works.
AC_LANG(C++)
AC_REQUIRE_CPP
AC_PROG_CXX

AX_BOOST_BASE([1.32])
AX_BOOST_PROGRAM_OPTIONS

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT