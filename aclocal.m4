# generated automatically by aclocal 1.15 -*- Autoconf -*-

# Copyright (C) 1996-2014 Free Software Foundation, Inc.

# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

m4_ifndef([AC_CONFIG_MACRO_DIRS], [m4_defun([_AM_CONFIG_MACRO_DIRS], [])m4_defun([AC_CONFIG_MACRO_DIRS], [_AM_CONFIG_MACRO_DIRS($@)])])
m4_ifndef([AC_AUTOCONF_VERSION],
  [m4_copy([m4_PACKAGE_VERSION], [AC_AUTOCONF_VERSION])])dnl
m4_if(m4_defn([AC_AUTOCONF_VERSION]), [2.69],,
[m4_warning([this file was generated for autoconf 2.69.
You have another version of autoconf.  It may work, but is not guaranteed to.
If you have problems, you may need to regenerate the build system entirely.
To do so, use the procedure documented by the package, typically 'autoreconf'.])])

# ===========================================================================
#       http://www.gnu.org/software/autoconf-archive/ax_boost_base.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_BOOST_BASE([MINIMUM-VERSION], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Test for the Boost C++ libraries of a particular version (or newer)
#
#   If no path to the installed boost library is given the macro searchs
#   under /usr, /usr/local, /opt and /opt/local and evaluates the
#   $BOOST_ROOT environment variable. Further documentation is available at
#   <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_CPPFLAGS) / AC_SUBST(BOOST_LDFLAGS)
#
#   And sets:
#
#     HAVE_BOOST
#
# LICENSE
#
#   Copyright (c) 2008 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2009 Peter Adolphs
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 26

AC_DEFUN([AX_BOOST_BASE],
[
AC_ARG_WITH([boost],
  [AS_HELP_STRING([--with-boost@<:@=ARG@:>@],
    [use Boost library from a standard location (ARG=yes),
     from the specified location (ARG=<path>),
     or disable it (ARG=no)
     @<:@ARG=yes@:>@ ])],
    [
    if test "$withval" = "no"; then
        want_boost="no"
    elif test "$withval" = "yes"; then
        want_boost="yes"
        ac_boost_path=""
    else
        want_boost="yes"
        ac_boost_path="$withval"
    fi
    ],
    [want_boost="yes"])


AC_ARG_WITH([boost-libdir],
        AS_HELP_STRING([--with-boost-libdir=LIB_DIR],
        [Force given directory for boost libraries. Note that this will override library path detection, so use this parameter only if default library detection fails and you know exactly where your boost libraries are located.]),
        [
        if test -d "$withval"
        then
                ac_boost_lib_path="$withval"
        else
                AC_MSG_ERROR(--with-boost-libdir expected directory name)
        fi
        ],
        [ac_boost_lib_path=""]
)

if test "x$want_boost" = "xyes"; then
    boost_lib_version_req=ifelse([$1], ,1.20.0,$1)
    boost_lib_version_req_shorten=`expr $boost_lib_version_req : '\([[0-9]]*\.[[0-9]]*\)'`
    boost_lib_version_req_major=`expr $boost_lib_version_req : '\([[0-9]]*\)'`
    boost_lib_version_req_minor=`expr $boost_lib_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
    boost_lib_version_req_sub_minor=`expr $boost_lib_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
    if test "x$boost_lib_version_req_sub_minor" = "x" ; then
        boost_lib_version_req_sub_minor="0"
        fi
    WANT_BOOST_VERSION=`expr $boost_lib_version_req_major \* 100000 \+  $boost_lib_version_req_minor \* 100 \+ $boost_lib_version_req_sub_minor`
    AC_MSG_CHECKING(for boostlib >= $boost_lib_version_req)
    succeeded=no

    dnl On 64-bit systems check for system libraries in both lib64 and lib.
    dnl The former is specified by FHS, but e.g. Debian does not adhere to
    dnl this (as it rises problems for generic multi-arch support).
    dnl The last entry in the list is chosen by default when no libraries
    dnl are found, e.g. when only header-only libraries are installed!
    libsubdirs="lib"
    ax_arch=`uname -m`
    case $ax_arch in
      x86_64)
        libsubdirs="lib64 libx32 lib lib64"
        ;;
      ppc64|s390x|sparc64|aarch64|ppc64le)
        libsubdirs="lib64 lib lib64 ppc64le"
        ;;
    esac

    dnl allow for real multi-arch paths e.g. /usr/lib/x86_64-linux-gnu. Give
    dnl them priority over the other paths since, if libs are found there, they
    dnl are almost assuredly the ones desired.
    AC_REQUIRE([AC_CANONICAL_HOST])
    libsubdirs="lib/${host_cpu}-${host_os} $libsubdirs"

    case ${host_cpu} in
      i?86)
        libsubdirs="lib/i386-${host_os} $libsubdirs"
        ;;
    esac

    dnl first we check the system location for boost libraries
    dnl this location ist chosen if boost libraries are installed with the --layout=system option
    dnl or if you install boost with RPM
    if test "$ac_boost_path" != ""; then
        BOOST_CPPFLAGS="-I$ac_boost_path/include"
        for ac_boost_path_tmp in $libsubdirs; do
                if test -d "$ac_boost_path"/"$ac_boost_path_tmp" ; then
                        BOOST_LDFLAGS="-L$ac_boost_path/$ac_boost_path_tmp"
                        break
                fi
        done
    elif test "$cross_compiling" != yes; then
        for ac_boost_path_tmp in /usr /usr/local /opt /opt/local ; do
            if test -d "$ac_boost_path_tmp/include/boost" && test -r "$ac_boost_path_tmp/include/boost"; then
                for libsubdir in $libsubdirs ; do
                    if ls "$ac_boost_path_tmp/$libsubdir/libboost_"* >/dev/null 2>&1 ; then break; fi
                done
                BOOST_LDFLAGS="-L$ac_boost_path_tmp/$libsubdir"
                BOOST_CPPFLAGS="-I$ac_boost_path_tmp/include"
                break;
            fi
        done
    fi

    dnl overwrite ld flags if we have required special directory with
    dnl --with-boost-libdir parameter
    if test "$ac_boost_lib_path" != ""; then
       BOOST_LDFLAGS="-L$ac_boost_lib_path"
    fi

    CPPFLAGS_SAVED="$CPPFLAGS"
    CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
    export CPPFLAGS

    LDFLAGS_SAVED="$LDFLAGS"
    LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
    export LDFLAGS

    AC_REQUIRE([AC_PROG_CXX])
    AC_LANG_PUSH(C++)
        AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
    @%:@include <boost/version.hpp>
    ]], [[
    #if BOOST_VERSION >= $WANT_BOOST_VERSION
    // Everything is okay
    #else
    #  error Boost version is too old
    #endif
    ]])],[
        AC_MSG_RESULT(yes)
    succeeded=yes
    found_system=yes
        ],[
        ])
    AC_LANG_POP([C++])



    dnl if we found no boost with system layout we search for boost libraries
    dnl built and installed without the --layout=system option or for a staged(not installed) version
    if test "x$succeeded" != "xyes"; then
        CPPFLAGS="$CPPFLAGS_SAVED"
        LDFLAGS="$LDFLAGS_SAVED"
        BOOST_CPPFLAGS=
        BOOST_LDFLAGS=
        _version=0
        if test "$ac_boost_path" != ""; then
            if test -d "$ac_boost_path" && test -r "$ac_boost_path"; then
                for i in `ls -d $ac_boost_path/include/boost-* 2>/dev/null`; do
                    _version_tmp=`echo $i | sed "s#$ac_boost_path##" | sed 's/\/include\/boost-//' | sed 's/_/./'`
                    V_CHECK=`expr $_version_tmp \> $_version`
                    if test "$V_CHECK" = "1" ; then
                        _version=$_version_tmp
                    fi
                    VERSION_UNDERSCORE=`echo $_version | sed 's/\./_/'`
                    BOOST_CPPFLAGS="-I$ac_boost_path/include/boost-$VERSION_UNDERSCORE"
                done
                dnl if nothing found search for layout used in Windows distributions
                if test -z "$BOOST_CPPFLAGS"; then
                    if test -d "$ac_boost_path/boost" && test -r "$ac_boost_path/boost"; then
                        BOOST_CPPFLAGS="-I$ac_boost_path"
                    fi
                fi
            fi
        else
            if test "$cross_compiling" != yes; then
                for ac_boost_path in /usr /usr/local /opt /opt/local ; do
                    if test -d "$ac_boost_path" && test -r "$ac_boost_path"; then
                        for i in `ls -d $ac_boost_path/include/boost-* 2>/dev/null`; do
                            _version_tmp=`echo $i | sed "s#$ac_boost_path##" | sed 's/\/include\/boost-//' | sed 's/_/./'`
                            V_CHECK=`expr $_version_tmp \> $_version`
                            if test "$V_CHECK" = "1" ; then
                                _version=$_version_tmp
                                best_path=$ac_boost_path
                            fi
                        done
                    fi
                done

                VERSION_UNDERSCORE=`echo $_version | sed 's/\./_/'`
                BOOST_CPPFLAGS="-I$best_path/include/boost-$VERSION_UNDERSCORE"
                if test "$ac_boost_lib_path" = ""; then
                    for libsubdir in $libsubdirs ; do
                        if ls "$best_path/$libsubdir/libboost_"* >/dev/null 2>&1 ; then break; fi
                    done
                    BOOST_LDFLAGS="-L$best_path/$libsubdir"
                fi
            fi

            if test "x$BOOST_ROOT" != "x"; then
                for libsubdir in $libsubdirs ; do
                    if ls "$BOOST_ROOT/stage/$libsubdir/libboost_"* >/dev/null 2>&1 ; then break; fi
                done
                if test -d "$BOOST_ROOT" && test -r "$BOOST_ROOT" && test -d "$BOOST_ROOT/stage/$libsubdir" && test -r "$BOOST_ROOT/stage/$libsubdir"; then
                    version_dir=`expr //$BOOST_ROOT : '.*/\(.*\)'`
                    stage_version=`echo $version_dir | sed 's/boost_//' | sed 's/_/./g'`
                        stage_version_shorten=`expr $stage_version : '\([[0-9]]*\.[[0-9]]*\)'`
                    V_CHECK=`expr $stage_version_shorten \>\= $_version`
                    if test "$V_CHECK" = "1" -a "$ac_boost_lib_path" = "" ; then
                        AC_MSG_NOTICE(We will use a staged boost library from $BOOST_ROOT)
                        BOOST_CPPFLAGS="-I$BOOST_ROOT"
                        BOOST_LDFLAGS="-L$BOOST_ROOT/stage/$libsubdir"
                    fi
                fi
            fi
        fi

        CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
        export CPPFLAGS
        LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
        export LDFLAGS

        AC_LANG_PUSH(C++)
            AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
        @%:@include <boost/version.hpp>
        ]], [[
        #if BOOST_VERSION >= $WANT_BOOST_VERSION
        // Everything is okay
        #else
        #  error Boost version is too old
        #endif
        ]])],[
            AC_MSG_RESULT(yes)
        succeeded=yes
        found_system=yes
            ],[
            ])
        AC_LANG_POP([C++])
    fi

    if test "$succeeded" != "yes" ; then
        if test "$_version" = "0" ; then
            AC_MSG_NOTICE([[We could not detect the boost libraries (version $boost_lib_version_req_shorten or higher). If you have a staged boost library (still not installed) please specify \$BOOST_ROOT in your environment and do not give a PATH to --with-boost option.  If you are sure you have boost installed, then check your version number looking in <boost/version.hpp>. See http://randspringer.de/boost for more documentation.]])
        else
            AC_MSG_NOTICE([Your boost libraries seems to old (version $_version).])
        fi
        # execute ACTION-IF-NOT-FOUND (if present):
        ifelse([$3], , :, [$3])
    else
        AC_SUBST(BOOST_CPPFLAGS)
        AC_SUBST(BOOST_LDFLAGS)
        AC_DEFINE(HAVE_BOOST,,[define if the Boost library is available])
        # execute ACTION-IF-FOUND (if present):
        ifelse([$2], , :, [$2])
    fi

    CPPFLAGS="$CPPFLAGS_SAVED"
    LDFLAGS="$LDFLAGS_SAVED"
fi

])

# ===========================================================================
#   http://www.gnu.org/software/autoconf-archive/ax_check_compile_flag.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_COMPILE_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
#
# DESCRIPTION
#
#   Check whether the given FLAG works with the current language's compiler
#   or gives an error.  (Warnings, however, are ignored)
#
#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
#   success/failure.
#
#   If EXTRA-FLAGS is defined, it is added to the current language's default
#   flags (e.g. CFLAGS) when the check is done.  The check is thus made with
#   the flags: "CFLAGS EXTRA-FLAGS FLAG".  This can for example be used to
#   force the compiler to issue an error when a bad flag is given.
#
#   INPUT gives an alternative input source to AC_COMPILE_IFELSE.
#
#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
#   macro in sync with AX_CHECK_{PREPROC,LINK}_FLAG.
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#   Copyright (c) 2011 Maarten Bosmans <mkbosmans@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 4

AC_DEFUN([AX_CHECK_COMPILE_FLAG],
[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]flags_$4_$1])dnl
AC_CACHE_CHECK([whether _AC_LANG compiler accepts $1], CACHEVAR, [
  ax_check_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
  _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $4 $1"
  AC_COMPILE_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
    [AS_VAR_SET(CACHEVAR,[yes])],
    [AS_VAR_SET(CACHEVAR,[no])])
  _AC_LANG_PREFIX[]FLAGS=$ax_check_save_flags])
AS_VAR_IF(CACHEVAR,yes,
  [m4_default([$2], :)],
  [m4_default([$3], :)])
AS_VAR_POPDEF([CACHEVAR])dnl
])dnl AX_CHECK_COMPILE_FLAGS

# ===========================================================================
#    http://www.gnu.org/software/autoconf-archive/ax_compiler_vendor.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_COMPILER_VENDOR
#
# DESCRIPTION
#
#   Determine the vendor of the C/C++ compiler, e.g., gnu, intel, ibm, sun,
#   hp, borland, comeau, dec, cray, kai, lcc, metrowerks, sgi, microsoft,
#   watcom, etc. The vendor is returned in the cache variable
#   $ax_cv_c_compiler_vendor for C and $ax_cv_cxx_compiler_vendor for C++.
#
# LICENSE
#
#   Copyright (c) 2008 Steven G. Johnson <stevenj@alum.mit.edu>
#   Copyright (c) 2008 Matteo Frigo
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 15

AC_DEFUN([AX_COMPILER_VENDOR],
[AC_CACHE_CHECK([for _AC_LANG compiler vendor], ax_cv_[]_AC_LANG_ABBREV[]_compiler_vendor,
  dnl Please add if possible support to ax_compiler_version.m4
  [# note: don't check for gcc first since some other compilers define __GNUC__
  vendors="intel:     __ICC,__ECC,__INTEL_COMPILER
           ibm:       __xlc__,__xlC__,__IBMC__,__IBMCPP__
           pathscale: __PATHCC__,__PATHSCALE__
           clang:     __clang__
           cray:      _CRAYC
           fujitsu:   __FUJITSU
           gnu:       __GNUC__
           sun:       __SUNPRO_C,__SUNPRO_CC
           hp:        __HP_cc,__HP_aCC
           dec:       __DECC,__DECCXX,__DECC_VER,__DECCXX_VER
           borland:   __BORLANDC__,__CODEGEARC__,__TURBOC__
           comeau:    __COMO__
           kai:       __KCC
           lcc:       __LCC__
           sgi:       __sgi,sgi
           microsoft: _MSC_VER
           metrowerks: __MWERKS__
           watcom:    __WATCOMC__
           portland:  __PGI
	   tcc:       __TINYC__
           unknown:   UNKNOWN"
  for ventest in $vendors; do
    case $ventest in
      *:) vendor=$ventest; continue ;;
      *)  vencpp="defined("`echo $ventest | sed 's/,/) || defined(/g'`")" ;;
    esac
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM(,[
      #if !($vencpp)
        thisisanerror;
      #endif
    ])], [break])
  done
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_vendor=`echo $vendor | cut -d: -f1`
 ])
])

# ===========================================================================
#    http://www.gnu.org/software/autoconf-archive/ax_compiler_version.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_COMPILER_VERSION
#
# DESCRIPTION
#
#   This macro retrieves the compiler version and returns it in the cache
#   variable $ax_cv_c_compiler_version for C and $ax_cv_cxx_compiler_version
#   for C++.
#
#   Version is returned as epoch:major.minor.patchversion
#
#   Epoch is used in order to have an increasing version number in case of
#   marketing change.
#
#   Epoch use: * borland compiler use chronologically 0turboc for turboc
#   era,
#
#     1borlanc BORLANC++ before 5, 2cppbuilder for cppbuilder era,
#     3borlancpp for return of BORLANC++ (after version 5.5),
#     4cppbuilder for cppbuilder with year version,
#     and 5xe for XE era.
#
#   An empty string is returned otherwise.
#
# LICENSE
#
#   Copyright (c) 2014 Bastien ROUCARIES <roucaries.bastien+autoconf@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 4

# for intel
AC_DEFUN([_AX_COMPILER_VERSION_INTEL],
  [ dnl
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    [__INTEL_COMPILER/100],,
    AC_MSG_FAILURE([[[$0]] unknown intel compiler version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    [(__INTEL_COMPILER%100)/10],,
    AC_MSG_FAILURE([[[$0]] unknown intel compiler version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    [(__INTEL_COMPILER%10)],,
    AC_MSG_FAILURE([[[$0]] unknown intel compiler version]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# for IBM
AC_DEFUN([_AX_COMPILER_VERSION_IBM],
  [ dnl
  dnl check between z/OS C/C++  and XL C/C++
  AC_COMPILE_IFELSE([
    AC_LANG_PROGRAM([],
      [
        #if defined(__COMPILER_VER__)
        choke me;
        #endif
      ])],
    [
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
        [__xlC__/100],,
      	AC_MSG_FAILURE([[[$0]] unknown IBM compiler major version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
        [__xlC__%100],,
      	AC_MSG_FAILURE([[[$0]] unknown IBM compiler minor version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
        [__xlC_ver__/0x100],,
      	AC_MSG_FAILURE([[[$0]] unknown IBM compiler patch version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_build,
        [__xlC_ver__%0x100],,
      	AC_MSG_FAILURE([[[$0]] unknown IBM compiler build version]))
      ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_build"
    ],
    [
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
        [__xlC__%1000],,
      	AC_MSG_FAILURE([[[$0]] unknown IBM compiler patch version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
        [(__xlC__/10000)%10],,
      	AC_MSG_FAILURE([[[$0]] unknown IBM compiler minor version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
        [(__xlC__/100000)%10],,
      	AC_MSG_FAILURE([[[$0]] unknown IBM compiler major version]))
      ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
    ])
])

# for pathscale
AC_DEFUN([_AX_COMPILER_VERSION_PATHSCALE],[
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    __PATHCC__,,
    AC_MSG_FAILURE([[[$0]] unknown pathscale major]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    __PATHCC_MINOR__,,
    AC_MSG_FAILURE([[[$0]] unknown pathscale minor]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    [__PATHCC_PATCHLEVEL__],,
    AC_MSG_FAILURE([[[$0]] unknown pathscale patch level]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# for clang
AC_DEFUN([_AX_COMPILER_VERSION_CLANG],[
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    __clang_major__,,
    AC_MSG_FAILURE([[[$0]] unknown clang major]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    __clang_minor__,,
    AC_MSG_FAILURE([[[$0]] unknown clang minor]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    [__clang_patchlevel__],,0)
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# for crayc
AC_DEFUN([_AX_COMPILER_VERSION_CRAY],[
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    _RELEASE,,
    AC_MSG_FAILURE([[[$0]] unknown crayc release]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    _RELEASE_MINOR,,
    AC_MSG_FAILURE([[[$0]] unknown crayc minor]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor"
  ])

# for fujitsu
AC_DEFUN([_AX_COMPILER_VERSION_FUJITSU],[
  AC_COMPUTE_INT(ax_cv_[]_AC_LANG_ABBREV[]_compiler_version,
                 __FCC_VERSION,,
		 AC_MSG_FAILURE([[[$0]]unknown fujitsu release]))
  ])

# for GNU
AC_DEFUN([_AX_COMPILER_VERSION_GNU],[
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    __GNUC__,,
    AC_MSG_FAILURE([[[$0]] unknown gcc major]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    __GNUC_MINOR__,,
    AC_MSG_FAILURE([[[$0]] unknown gcc minor]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    [__GNUC_PATCHLEVEL__],,
    AC_MSG_FAILURE([[[$0]] unknown gcc patch level]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# For sun
AC_DEFUN([_AX_COMPILER_VERSION_SUN],[
  m4_define([_AX_COMPILER_VERSION_SUN_NUMBER],
            [
	     #if defined(__SUNPRO_CC)
	     __SUNPRO_CC
	     #else
	     __SUNPRO_C
	     #endif
	    ])
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_until59,
    !!(_AX_COMPILER_VERSION_SUN_NUMBER < 0x1000),,
    AC_MSG_FAILURE([[[$0]] unknown sun release version]))
  AS_IF([test "X$_ax_[]_AC_LANG_ABBREV[]_compiler_version_until59" = X1],
    [dnl
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
        _AX_COMPILER_VERSION_SUN_NUMBER % 0x10,,
	AC_MSG_FAILURE([[[$0]] unknown sun patch version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
        (_AX_COMPILER_VERSION_SUN_NUMBER / 0x10) % 0x10,,
        AC_MSG_FAILURE([[[$0]] unknown sun minor version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
        (_AX_COMPILER_VERSION_SUN_NUMBER / 0x100),,
        AC_MSG_FAILURE([[[$0]] unknown sun major version]))
    ],
    [dnl
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
        _AX_COMPILER_VERSION_SUN_NUMBER % 0x10,,
        AC_MSG_FAILURE([[[$0]] unknown sun patch version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
        (_AX_COMPILER_VERSION_SUN_NUMBER / 0x100) % 0x100,,
        AC_MSG_FAILURE([[[$0]] unknown sun minor version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
        (_AX_COMPILER_VERSION_SUN_NUMBER / 0x1000),,
        AC_MSG_FAILURE([[[$0]] unknown sun major version]))
    ])
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
])

AC_DEFUN([_AX_COMPILER_VERSION_HP],[
  m4_define([_AX_COMPILER_VERSION_HP_NUMBER],
            [
	     #if defined(__HP_cc)
	     __HP_cc
	     #else
	     __HP_aCC
	     #endif
	    ])
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_untilA0121,
    !!(_AX_COMPILER_VERSION_HP_NUMBER <= 1),,
    AC_MSG_FAILURE([[[$0]] unknown hp release version]))
  AS_IF([test "X$_ax_[]_AC_LANG_ABBREV[]_compiler_version_untilA0121" = X1],
    [dnl By default output last version with this behavior.
     dnl it is so old
      ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="01.21.00"
    ],
    [dnl
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
        (_AX_COMPILER_VERSION_HP_NUMBER % 100),,
        AC_MSG_FAILURE([[[$0]] unknown hp release version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
        ((_AX_COMPILER_VERSION_HP_NUMBER / 100)%100),,
        AC_MSG_FAILURE([[[$0]] unknown hp minor version]))
      AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
        ((_AX_COMPILER_VERSION_HP_NUMBER / 10000)%100),,
        AC_MSG_FAILURE([[[$0]] unknown hp major version]))
      ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
    ])
])

AC_DEFUN([_AX_COMPILER_VERSION_DEC],[dnl
  m4_define([_AX_COMPILER_VERSION_DEC_NUMBER],
            [
	     #if defined(__DECC_VER)
	     __DECC_VER
	     #else
	     __DECCXX_VER
	     #endif
	    ])
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    (_AX_COMPILER_VERSION_DEC_NUMBER % 10000),,
    AC_MSG_FAILURE([[[$0]] unknown dec release version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    ((_AX_COMPILER_VERSION_DEC_NUMBER / 100000UL)%100),,
    AC_MSG_FAILURE([[[$0]] unknown dec minor version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    ((_AX_COMPILER_VERSION_DEC_NUMBER / 10000000UL)%100),,
    AC_MSG_FAILURE([[[$0]] unknown dec major version]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# borland
AC_DEFUN([_AX_COMPILER_VERSION_BORLAND],[dnl
  m4_define([_AX_COMPILER_VERSION_TURBOC_NUMBER],
            [
	     #if defined(__TURBOC__)
	     __TURBOC__
	     #else
	     choke me
	     #endif
	    ])
  m4_define([_AX_COMPILER_VERSION_BORLANDC_NUMBER],
            [
	     #if defined(__BORLANDC__)
	     __BORLANDC__
	     #else
	     __CODEGEARC__
	     #endif
	    ])
 AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM(,
     _AX_COMPILER_VERSION_TURBOC_NUMBER)],
   [dnl TURBOC
     AC_COMPUTE_INT(
       _ax_[]_AC_LANG_ABBREV[]_compiler_version_turboc_raw,
       _AX_COMPILER_VERSION_TURBOC_NUMBER,,
       AC_MSG_FAILURE([[[$0]] unknown turboc version]))
     AS_IF(
       [test $_ax_[]_AC_LANG_ABBREV[]_compiler_version_turboc_raw -lt 661 || test $_ax_[]_AC_LANG_ABBREV[]_compiler_version_turboc_raw -gt 1023],
       [dnl compute normal version
        AC_COMPUTE_INT(
	  _ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
	  _AX_COMPILER_VERSION_TURBOC_NUMBER % 0x100,,
	  AC_MSG_FAILURE([[[$0]] unknown turboc minor version]))
	AC_COMPUTE_INT(
	  _ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
	  (_AX_COMPILER_VERSION_TURBOC_NUMBER/0x100)%0x100,,
	  AC_MSG_FAILURE([[[$0]] unknown turboc major version]))
	ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="0turboc:$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor"],
      [dnl special version
       AS_CASE([$_ax_[]_AC_LANG_ABBREV[]_compiler_version_turboc_raw],
         [661],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="0turboc:1.00"],
	 [662],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="0turboc:1.01"],
         [663],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="0turboc:2.00"],
	 [
	 AC_MSG_WARN([[[$0]] unknown turboc version between 0x295 and 0x400 please report bug])
	 ax_cv_[]_AC_LANG_ABBREV[]_compiler_version=""
	 ])
      ])
    ],
    # borlandc
    [
    AC_COMPUTE_INT(
      _ax_[]_AC_LANG_ABBREV[]_compiler_version_borlandc_raw,
      _AX_COMPILER_VERSION_BORLANDC_NUMBER,,
      AC_MSG_FAILURE([[[$0]] unknown borlandc version]))
    AS_CASE([$_ax_[]_AC_LANG_ABBREV[]_compiler_version_borlandc_raw],
      dnl BORLANC++ before 5.5
      [512] ,[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="1borlanc:2.00"],
      [1024],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="1borlanc:3.00"],
      [1024],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="1borlanc:3.00"],
      [1040],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="1borlanc:3.1"],
      [1106],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="1borlanc:4.0"],
      [1280],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="1borlanc:5.0"],
      [1312],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="1borlanc:5.02"],
      dnl C++ Builder era
      [1328],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="2cppbuilder:3.0"],
      [1344],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="2cppbuilder:4.0"],
      dnl BORLANC++ after 5.5
      [1360],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="3borlancpp:5.5"],
      [1361],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="3borlancpp:5.51"],
      [1378],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="3borlancpp:5.6.4"],
      dnl C++ Builder with year number
      [1392],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="4cppbuilder:2006"],
      [1424],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="4cppbuilder:2007"],
      [1555],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="4cppbuilder:2009"],
      [1569],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="4cppbuilder:2010"],
      dnl XE version
      [1584],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="5xe"],
      [1600],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="5xe:2"],
      [1616],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="5xe:3"],
      [1632],[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="5xe:4"],
      [
      AC_MSG_WARN([[[$0]] Unknow borlanc compiler version $_ax_[]_AC_LANG_ABBREV[]_compiler_version_borlandc_raw please report bug])
      ])
    ])
  ])

# COMO
AC_DEFUN([_AX_COMPILER_VERSION_COMEAU],
  [ dnl
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    [__COMO_VERSION__%100],,
    AC_MSG_FAILURE([[[$0]] unknown comeau compiler minor version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    [(__COMO_VERSION__/100)%10],,
    AC_MSG_FAILURE([[[$0]] unknown comeau compiler major version]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor"
  ])

# KAI
AC_DEFUN([_AX_COMPILER_VERSION_KAI],[
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    [__KCC_VERSION%100],,
    AC_MSG_FAILURE([[[$0]] unknown kay compiler patch version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    [(__KCC_VERSION/100)%10],,
    AC_MSG_FAILURE([[[$0]] unknown kay compiler minor version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    [(__KCC_VERSION/1000)%10],,
    AC_MSG_FAILURE([[[$0]] unknown kay compiler major version]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

dnl LCC
dnl LCC does not output version...

# SGI
AC_DEFUN([_AX_COMPILER_VERSION_SGI],[
   m4_define([_AX_COMPILER_VERSION_SGI_NUMBER],
            [
	     #if defined(_COMPILER_VERSION)
	     _COMPILER_VERSION
	     #else
	     _SGI_COMPILER_VERSION
	     #endif
	    ])
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    [_AX_COMPILER_VERSION_SGI_NUMBER%10],,
    AC_MSG_FAILURE([[[$0]] unknown SGI compiler patch version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    [(_AX_COMPILER_VERSION_SGI_NUMBER/10)%10],,
    AC_MSG_FAILURE([[[$0]] unknown SGI compiler minor version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    [(_AX_COMPILER_VERSION_SGI_NUMBER/100)%10],,
    AC_MSG_FAILURE([[[$0]] unknown SGI compiler major version]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# microsoft
AC_DEFUN([_AX_COMPILER_VERSION_MICROSOFT],[
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    _MSC_VER%100,,
    AC_MSG_FAILURE([[[$0]] unknown microsoft compiler minor version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    (_MSC_VER/100)%100,,
    AC_MSG_FAILURE([[[$0]] unknown microsoft compiler major version]))
  dnl could be overriden
  _ax_[]_AC_LANG_ABBREV[]_compiler_version_patch=0
  _ax_[]_AC_LANG_ABBREV[]_compiler_version_build=0
  # special case for version 6
  AS_IF([test "X$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major" = "X12"],
    [AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
       _MSC_FULL_VER%1000,,
       _ax_[]_AC_LANG_ABBREV[]_compiler_version_patch=0)])
  # for version 7
  AS_IF([test "X$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major" = "X13"],
    [AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
       _MSC_FULL_VER%1000,,
       AC_MSG_FAILURE([[[$0]] unknown microsoft compiler patch version]))
    ])
  # for version > 8
 AS_IF([test $_ax_[]_AC_LANG_ABBREV[]_compiler_version_major -ge 14],
    [AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
       _MSC_FULL_VER%10000,,
       AC_MSG_FAILURE([[[$0]] unknown microsoft compiler patch version]))
    ])
 AS_IF([test $_ax_[]_AC_LANG_ABBREV[]_compiler_version_major -ge 15],
    [AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_build,
       _MSC_BUILD,,
       AC_MSG_FAILURE([[[$0]] unknown microsoft compiler build version]))
    ])
 ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_build"
 ])

# for metrowerks
AC_DEFUN([_AX_COMPILER_VERSION_METROWERKS],[dnl
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    __MWERKS__%0x100,,
    AC_MSG_FAILURE([[[$0]] unknown metrowerks compiler patch version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    (__MWERKS__/0x100)%0x10,,
    AC_MSG_FAILURE([[[$0]] unknown metrowerks compiler minor version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    (__MWERKS__/0x1000)%0x10,,
    AC_MSG_FAILURE([[[$0]] unknown metrowerks compiler major version]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# for watcom
AC_DEFUN([_AX_COMPILER_VERSION_WATCOM],[dnl
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    __WATCOMC__%100,,
    AC_MSG_FAILURE([[[$0]] unknown watcom compiler minor version]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    (__WATCOMC__/100)%100,,
    AC_MSG_FAILURE([[[$0]] unknown watcom compiler major version]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor"
  ])

# for PGI
AC_DEFUN([_AX_COMPILER_VERSION_PORTLAND],[
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_major,
    __PGIC__,,
    AC_MSG_FAILURE([[[$0]] unknown pgi major]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor,
    __PGIC_MINOR__,,
    AC_MSG_FAILURE([[[$0]] unknown pgi minor]))
  AC_COMPUTE_INT(_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch,
    [__PGIC_PATCHLEVEL__],,
    AC_MSG_FAILURE([[[$0]] unknown pgi patch level]))
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version="$_ax_[]_AC_LANG_ABBREV[]_compiler_version_major.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_minor.$_ax_[]_AC_LANG_ABBREV[]_compiler_version_patch"
  ])

# tcc
AC_DEFUN([_AX_COMPILER_VERSION_TCC],[
  ax_cv_[]_AC_LANG_ABBREV[]_compiler_version=[`tcc -v | $SED 's/^[ ]*tcc[ ]\+version[ ]\+\([0-9.]\+\).*/\1/g'`]
  ])
# main entry point
AC_DEFUN([AX_COMPILER_VERSION],[dnl
  AC_REQUIRE([AX_COMPILER_VENDOR])
  AC_REQUIRE([AC_PROG_SED])
  AC_CACHE_CHECK([for _AC_LANG compiler version],
    ax_cv_[]_AC_LANG_ABBREV[]_compiler_version,
    [ dnl
      AS_CASE([$ax_cv_[]_AC_LANG_ABBREV[]_compiler_vendor],
        [intel],[_AX_COMPILER_VERSION_INTEL],
	[ibm],[_AX_COMPILER_VERSION_IBM],
	[pathscale],[_AX_COMPILER_VERSION_PATHSCALE],
	[clang],[_AX_COMPILER_VERSION_CLANG],
	[cray],[_AX_COMPILER_VERSION_CRAY],
	[fujitsu],[_AX_COMPILER_VERSION_FUJITSU],
        [gnu],[_AX_COMPILER_VERSION_GNU],
	[sun],[_AX_COMPILER_VERSION_SUN],
	[hp],[_AX_COMPILER_VERSION_HP],
	[dec],[_AX_COMPILER_VERSION_DEC],
	[borland],[_AX_COMPILER_VERSION_BORLAND],
	[comeau],[_AX_COMPILER_VERSION_COMEAU],
	[kai],[_AX_COMPILER_VERSION_KAI],
	[sgi],[_AX_COMPILER_VERSION_SGI],
	[microsoft],[_AX_COMPILER_VERSION_MICROSOFT],
	[metrowerks],[_AX_COMPILER_VERSION_METROWERKS],
	[watcom],[_AX_COMPILER_VERSION_WATCOM],
	[portland],[_AX_COMPILER_VERSION_PORTLAND],
	[tcc],[_AX_COMPILER_VERSION_TCC],
  	[ax_cv_[]_AC_LANG_ABBREV[]_compiler_version=""])
    ])
])

# ===========================================================================
#         http://www.gnu.org/software/autoconf-archive/ax_openmp.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_OPENMP([ACTION-IF-FOUND[, ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   This macro tries to find out how to compile programs that use OpenMP a
#   standard API and set of compiler directives for parallel programming
#   (see http://www-unix.mcs/)
#
#   On success, it sets the OPENMP_CFLAGS/OPENMP_CXXFLAGS/OPENMP_F77FLAGS
#   output variable to the flag (e.g. -omp) used both to compile *and* link
#   OpenMP programs in the current language.
#
#   NOTE: You are assumed to not only compile your program with these flags,
#   but also link it with them as well.
#
#   If you want to compile everything with OpenMP, you should set:
#
#     CFLAGS="$CFLAGS $OPENMP_CFLAGS"
#     #OR#  CXXFLAGS="$CXXFLAGS $OPENMP_CXXFLAGS"
#     #OR#  FFLAGS="$FFLAGS $OPENMP_FFLAGS"
#
#   (depending on the selected language).
#
#   The user can override the default choice by setting the corresponding
#   environment variable (e.g. OPENMP_CFLAGS).
#
#   ACTION-IF-FOUND is a list of shell commands to run if an OpenMP flag is
#   found, and ACTION-IF-NOT-FOUND is a list of commands to run it if it is
#   not found. If ACTION-IF-FOUND is not specified, the default action will
#   define HAVE_OPENMP.
#
# LICENSE
#
#   Copyright (c) 2008 Steven G. Johnson <stevenj@alum.mit.edu>
#   Copyright (c) 2015 John W. Peterson <jwpeterson@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 11

AC_DEFUN([AX_OPENMP], [
AC_PREREQ([2.69]) dnl for _AC_LANG_PREFIX

AC_CACHE_CHECK([for OpenMP flag of _AC_LANG compiler], ax_cv_[]_AC_LANG_ABBREV[]_openmp, [save[]_AC_LANG_PREFIX[]FLAGS=$[]_AC_LANG_PREFIX[]FLAGS
ax_cv_[]_AC_LANG_ABBREV[]_openmp=unknown
# Flags to try:  -fopenmp (gcc), -openmp (icc), -mp (SGI & PGI),
#                -xopenmp (Sun), -omp (Tru64), -qsmp=omp (AIX), none
ax_openmp_flags="-fopenmp -openmp -mp -xopenmp -omp -qsmp=omp none"
if test "x$OPENMP_[]_AC_LANG_PREFIX[]FLAGS" != x; then
  ax_openmp_flags="$OPENMP_[]_AC_LANG_PREFIX[]FLAGS $ax_openmp_flags"
fi
for ax_openmp_flag in $ax_openmp_flags; do
  case $ax_openmp_flag in
    none) []_AC_LANG_PREFIX[]FLAGS=$save[]_AC_LANG_PREFIX[] ;;
    *) []_AC_LANG_PREFIX[]FLAGS="$save[]_AC_LANG_PREFIX[]FLAGS $ax_openmp_flag" ;;
  esac
  AC_LINK_IFELSE([AC_LANG_SOURCE([[
@%:@include <omp.h>

static void
parallel_fill(int * data, int n)
{
  int i;
@%:@pragma omp parallel for
  for (i = 0; i < n; ++i)
    data[i] = i;
}

int
main()
{
  int arr[100000];
  omp_set_num_threads(2);
  parallel_fill(arr, 100000);
  return 0;
}
]])],[ax_cv_[]_AC_LANG_ABBREV[]_openmp=$ax_openmp_flag; break],[])
done
[]_AC_LANG_PREFIX[]FLAGS=$save[]_AC_LANG_PREFIX[]FLAGS
])
if test "x$ax_cv_[]_AC_LANG_ABBREV[]_openmp" = "xunknown"; then
  m4_default([$2],:)
else
  if test "x$ax_cv_[]_AC_LANG_ABBREV[]_openmp" != "xnone"; then
    OPENMP_[]_AC_LANG_PREFIX[]FLAGS=$ax_cv_[]_AC_LANG_ABBREV[]_openmp
  fi
  m4_default([$1], [AC_DEFINE(HAVE_OPENMP,1,[Define if OpenMP is enabled])])
fi
])dnl AX_OPENMP

# Copyright (C) 2002-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_AUTOMAKE_VERSION(VERSION)
# ----------------------------
# Automake X.Y traces this macro to ensure aclocal.m4 has been
# generated from the m4 files accompanying Automake X.Y.
# (This private macro should not be called outside this file.)
AC_DEFUN([AM_AUTOMAKE_VERSION],
[am__api_version='1.15'
dnl Some users find AM_AUTOMAKE_VERSION and mistake it for a way to
dnl require some minimum version.  Point them to the right macro.
m4_if([$1], [1.15], [],
      [AC_FATAL([Do not call $0, use AM_INIT_AUTOMAKE([$1]).])])dnl
])

# _AM_AUTOCONF_VERSION(VERSION)
# -----------------------------
# aclocal traces this macro to find the Autoconf version.
# This is a private macro too.  Using m4_define simplifies
# the logic in aclocal, which can simply ignore this definition.
m4_define([_AM_AUTOCONF_VERSION], [])

# AM_SET_CURRENT_AUTOMAKE_VERSION
# -------------------------------
# Call AM_AUTOMAKE_VERSION and AM_AUTOMAKE_VERSION so they can be traced.
# This function is AC_REQUIREd by AM_INIT_AUTOMAKE.
AC_DEFUN([AM_SET_CURRENT_AUTOMAKE_VERSION],
[AM_AUTOMAKE_VERSION([1.15])dnl
m4_ifndef([AC_AUTOCONF_VERSION],
  [m4_copy([m4_PACKAGE_VERSION], [AC_AUTOCONF_VERSION])])dnl
_AM_AUTOCONF_VERSION(m4_defn([AC_AUTOCONF_VERSION]))])

# AM_AUX_DIR_EXPAND                                         -*- Autoconf -*-

# Copyright (C) 2001-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# For projects using AC_CONFIG_AUX_DIR([foo]), Autoconf sets
# $ac_aux_dir to '$srcdir/foo'.  In other projects, it is set to
# '$srcdir', '$srcdir/..', or '$srcdir/../..'.
#
# Of course, Automake must honor this variable whenever it calls a
# tool from the auxiliary directory.  The problem is that $srcdir (and
# therefore $ac_aux_dir as well) can be either absolute or relative,
# depending on how configure is run.  This is pretty annoying, since
# it makes $ac_aux_dir quite unusable in subdirectories: in the top
# source directory, any form will work fine, but in subdirectories a
# relative path needs to be adjusted first.
#
# $ac_aux_dir/missing
#    fails when called from a subdirectory if $ac_aux_dir is relative
# $top_srcdir/$ac_aux_dir/missing
#    fails if $ac_aux_dir is absolute,
#    fails when called from a subdirectory in a VPATH build with
#          a relative $ac_aux_dir
#
# The reason of the latter failure is that $top_srcdir and $ac_aux_dir
# are both prefixed by $srcdir.  In an in-source build this is usually
# harmless because $srcdir is '.', but things will broke when you
# start a VPATH build or use an absolute $srcdir.
#
# So we could use something similar to $top_srcdir/$ac_aux_dir/missing,
# iff we strip the leading $srcdir from $ac_aux_dir.  That would be:
#   am_aux_dir='\$(top_srcdir)/'`expr "$ac_aux_dir" : "$srcdir//*\(.*\)"`
# and then we would define $MISSING as
#   MISSING="\${SHELL} $am_aux_dir/missing"
# This will work as long as MISSING is not called from configure, because
# unfortunately $(top_srcdir) has no meaning in configure.
# However there are other variables, like CC, which are often used in
# configure, and could therefore not use this "fixed" $ac_aux_dir.
#
# Another solution, used here, is to always expand $ac_aux_dir to an
# absolute PATH.  The drawback is that using absolute paths prevent a
# configured tree to be moved without reconfiguration.

AC_DEFUN([AM_AUX_DIR_EXPAND],
[AC_REQUIRE([AC_CONFIG_AUX_DIR_DEFAULT])dnl
# Expand $ac_aux_dir to an absolute path.
am_aux_dir=`cd "$ac_aux_dir" && pwd`
])

# AM_CONDITIONAL                                            -*- Autoconf -*-

# Copyright (C) 1997-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_CONDITIONAL(NAME, SHELL-CONDITION)
# -------------------------------------
# Define a conditional.
AC_DEFUN([AM_CONDITIONAL],
[AC_PREREQ([2.52])dnl
 m4_if([$1], [TRUE],  [AC_FATAL([$0: invalid condition: $1])],
       [$1], [FALSE], [AC_FATAL([$0: invalid condition: $1])])dnl
AC_SUBST([$1_TRUE])dnl
AC_SUBST([$1_FALSE])dnl
_AM_SUBST_NOTMAKE([$1_TRUE])dnl
_AM_SUBST_NOTMAKE([$1_FALSE])dnl
m4_define([_AM_COND_VALUE_$1], [$2])dnl
if $2; then
  $1_TRUE=
  $1_FALSE='#'
else
  $1_TRUE='#'
  $1_FALSE=
fi
AC_CONFIG_COMMANDS_PRE(
[if test -z "${$1_TRUE}" && test -z "${$1_FALSE}"; then
  AC_MSG_ERROR([[conditional "$1" was never defined.
Usually this means the macro was only invoked conditionally.]])
fi])])

# Copyright (C) 1999-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.


# There are a few dirty hacks below to avoid letting 'AC_PROG_CC' be
# written in clear, in which case automake, when reading aclocal.m4,
# will think it sees a *use*, and therefore will trigger all it's
# C support machinery.  Also note that it means that autoscan, seeing
# CC etc. in the Makefile, will ask for an AC_PROG_CC use...


# _AM_DEPENDENCIES(NAME)
# ----------------------
# See how the compiler implements dependency checking.
# NAME is "CC", "CXX", "OBJC", "OBJCXX", "UPC", or "GJC".
# We try a few techniques and use that to set a single cache variable.
#
# We don't AC_REQUIRE the corresponding AC_PROG_CC since the latter was
# modified to invoke _AM_DEPENDENCIES(CC); we would have a circular
# dependency, and given that the user is not expected to run this macro,
# just rely on AC_PROG_CC.
AC_DEFUN([_AM_DEPENDENCIES],
[AC_REQUIRE([AM_SET_DEPDIR])dnl
AC_REQUIRE([AM_OUTPUT_DEPENDENCY_COMMANDS])dnl
AC_REQUIRE([AM_MAKE_INCLUDE])dnl
AC_REQUIRE([AM_DEP_TRACK])dnl

m4_if([$1], [CC],   [depcc="$CC"   am_compiler_list=],
      [$1], [CXX],  [depcc="$CXX"  am_compiler_list=],
      [$1], [OBJC], [depcc="$OBJC" am_compiler_list='gcc3 gcc'],
      [$1], [OBJCXX], [depcc="$OBJCXX" am_compiler_list='gcc3 gcc'],
      [$1], [UPC],  [depcc="$UPC"  am_compiler_list=],
      [$1], [GCJ],  [depcc="$GCJ"  am_compiler_list='gcc3 gcc'],
                    [depcc="$$1"   am_compiler_list=])

AC_CACHE_CHECK([dependency style of $depcc],
               [am_cv_$1_dependencies_compiler_type],
[if test -z "$AMDEP_TRUE" && test -f "$am_depcomp"; then
  # We make a subdir and do the tests there.  Otherwise we can end up
  # making bogus files that we don't know about and never remove.  For
  # instance it was reported that on HP-UX the gcc test will end up
  # making a dummy file named 'D' -- because '-MD' means "put the output
  # in D".
  rm -rf conftest.dir
  mkdir conftest.dir
  # Copy depcomp to subdir because otherwise we won't find it if we're
  # using a relative directory.
  cp "$am_depcomp" conftest.dir
  cd conftest.dir
  # We will build objects and dependencies in a subdirectory because
  # it helps to detect inapplicable dependency modes.  For instance
  # both Tru64's cc and ICC support -MD to output dependencies as a
  # side effect of compilation, but ICC will put the dependencies in
  # the current directory while Tru64 will put them in the object
  # directory.
  mkdir sub

  am_cv_$1_dependencies_compiler_type=none
  if test "$am_compiler_list" = ""; then
     am_compiler_list=`sed -n ['s/^#*\([a-zA-Z0-9]*\))$/\1/p'] < ./depcomp`
  fi
  am__universal=false
  m4_case([$1], [CC],
    [case " $depcc " in #(
     *\ -arch\ *\ -arch\ *) am__universal=true ;;
     esac],
    [CXX],
    [case " $depcc " in #(
     *\ -arch\ *\ -arch\ *) am__universal=true ;;
     esac])

  for depmode in $am_compiler_list; do
    # Setup a source with many dependencies, because some compilers
    # like to wrap large dependency lists on column 80 (with \), and
    # we should not choose a depcomp mode which is confused by this.
    #
    # We need to recreate these files for each test, as the compiler may
    # overwrite some of them when testing with obscure command lines.
    # This happens at least with the AIX C compiler.
    : > sub/conftest.c
    for i in 1 2 3 4 5 6; do
      echo '#include "conftst'$i'.h"' >> sub/conftest.c
      # Using ": > sub/conftst$i.h" creates only sub/conftst1.h with
      # Solaris 10 /bin/sh.
      echo '/* dummy */' > sub/conftst$i.h
    done
    echo "${am__include} ${am__quote}sub/conftest.Po${am__quote}" > confmf

    # We check with '-c' and '-o' for the sake of the "dashmstdout"
    # mode.  It turns out that the SunPro C++ compiler does not properly
    # handle '-M -o', and we need to detect this.  Also, some Intel
    # versions had trouble with output in subdirs.
    am__obj=sub/conftest.${OBJEXT-o}
    am__minus_obj="-o $am__obj"
    case $depmode in
    gcc)
      # This depmode causes a compiler race in universal mode.
      test "$am__universal" = false || continue
      ;;
    nosideeffect)
      # After this tag, mechanisms are not by side-effect, so they'll
      # only be used when explicitly requested.
      if test "x$enable_dependency_tracking" = xyes; then
	continue
      else
	break
      fi
      ;;
    msvc7 | msvc7msys | msvisualcpp | msvcmsys)
      # This compiler won't grok '-c -o', but also, the minuso test has
      # not run yet.  These depmodes are late enough in the game, and
      # so weak that their functioning should not be impacted.
      am__obj=conftest.${OBJEXT-o}
      am__minus_obj=
      ;;
    none) break ;;
    esac
    if depmode=$depmode \
       source=sub/conftest.c object=$am__obj \
       depfile=sub/conftest.Po tmpdepfile=sub/conftest.TPo \
       $SHELL ./depcomp $depcc -c $am__minus_obj sub/conftest.c \
         >/dev/null 2>conftest.err &&
       grep sub/conftst1.h sub/conftest.Po > /dev/null 2>&1 &&
       grep sub/conftst6.h sub/conftest.Po > /dev/null 2>&1 &&
       grep $am__obj sub/conftest.Po > /dev/null 2>&1 &&
       ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
      # icc doesn't choke on unknown options, it will just issue warnings
      # or remarks (even with -Werror).  So we grep stderr for any message
      # that says an option was ignored or not supported.
      # When given -MP, icc 7.0 and 7.1 complain thusly:
      #   icc: Command line warning: ignoring option '-M'; no argument required
      # The diagnosis changed in icc 8.0:
      #   icc: Command line remark: option '-MP' not supported
      if (grep 'ignoring option' conftest.err ||
          grep 'not supported' conftest.err) >/dev/null 2>&1; then :; else
        am_cv_$1_dependencies_compiler_type=$depmode
        break
      fi
    fi
  done

  cd ..
  rm -rf conftest.dir
else
  am_cv_$1_dependencies_compiler_type=none
fi
])
AC_SUBST([$1DEPMODE], [depmode=$am_cv_$1_dependencies_compiler_type])
AM_CONDITIONAL([am__fastdep$1], [
  test "x$enable_dependency_tracking" != xno \
  && test "$am_cv_$1_dependencies_compiler_type" = gcc3])
])


# AM_SET_DEPDIR
# -------------
# Choose a directory name for dependency files.
# This macro is AC_REQUIREd in _AM_DEPENDENCIES.
AC_DEFUN([AM_SET_DEPDIR],
[AC_REQUIRE([AM_SET_LEADING_DOT])dnl
AC_SUBST([DEPDIR], ["${am__leading_dot}deps"])dnl
])


# AM_DEP_TRACK
# ------------
AC_DEFUN([AM_DEP_TRACK],
[AC_ARG_ENABLE([dependency-tracking], [dnl
AS_HELP_STRING(
  [--enable-dependency-tracking],
  [do not reject slow dependency extractors])
AS_HELP_STRING(
  [--disable-dependency-tracking],
  [speeds up one-time build])])
if test "x$enable_dependency_tracking" != xno; then
  am_depcomp="$ac_aux_dir/depcomp"
  AMDEPBACKSLASH='\'
  am__nodep='_no'
fi
AM_CONDITIONAL([AMDEP], [test "x$enable_dependency_tracking" != xno])
AC_SUBST([AMDEPBACKSLASH])dnl
_AM_SUBST_NOTMAKE([AMDEPBACKSLASH])dnl
AC_SUBST([am__nodep])dnl
_AM_SUBST_NOTMAKE([am__nodep])dnl
])

# Generate code to set up dependency tracking.              -*- Autoconf -*-

# Copyright (C) 1999-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.


# _AM_OUTPUT_DEPENDENCY_COMMANDS
# ------------------------------
AC_DEFUN([_AM_OUTPUT_DEPENDENCY_COMMANDS],
[{
  # Older Autoconf quotes --file arguments for eval, but not when files
  # are listed without --file.  Let's play safe and only enable the eval
  # if we detect the quoting.
  case $CONFIG_FILES in
  *\'*) eval set x "$CONFIG_FILES" ;;
  *)   set x $CONFIG_FILES ;;
  esac
  shift
  for mf
  do
    # Strip MF so we end up with the name of the file.
    mf=`echo "$mf" | sed -e 's/:.*$//'`
    # Check whether this is an Automake generated Makefile or not.
    # We used to match only the files named 'Makefile.in', but
    # some people rename them; so instead we look at the file content.
    # Grep'ing the first line is not enough: some people post-process
    # each Makefile.in and add a new line on top of each file to say so.
    # Grep'ing the whole file is not good either: AIX grep has a line
    # limit of 2048, but all sed's we know have understand at least 4000.
    if sed -n 's,^#.*generated by automake.*,X,p' "$mf" | grep X >/dev/null 2>&1; then
      dirpart=`AS_DIRNAME("$mf")`
    else
      continue
    fi
    # Extract the definition of DEPDIR, am__include, and am__quote
    # from the Makefile without running 'make'.
    DEPDIR=`sed -n 's/^DEPDIR = //p' < "$mf"`
    test -z "$DEPDIR" && continue
    am__include=`sed -n 's/^am__include = //p' < "$mf"`
    test -z "$am__include" && continue
    am__quote=`sed -n 's/^am__quote = //p' < "$mf"`
    # Find all dependency output files, they are included files with
    # $(DEPDIR) in their names.  We invoke sed twice because it is the
    # simplest approach to changing $(DEPDIR) to its actual value in the
    # expansion.
    for file in `sed -n "
      s/^$am__include $am__quote\(.*(DEPDIR).*\)$am__quote"'$/\1/p' <"$mf" | \
	 sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g'`; do
      # Make sure the directory exists.
      test -f "$dirpart/$file" && continue
      fdir=`AS_DIRNAME(["$file"])`
      AS_MKDIR_P([$dirpart/$fdir])
      # echo "creating $dirpart/$file"
      echo '# dummy' > "$dirpart/$file"
    done
  done
}
])# _AM_OUTPUT_DEPENDENCY_COMMANDS


# AM_OUTPUT_DEPENDENCY_COMMANDS
# -----------------------------
# This macro should only be invoked once -- use via AC_REQUIRE.
#
# This code is only required when automatic dependency tracking
# is enabled.  FIXME.  This creates each '.P' file that we will
# need in order to bootstrap the dependency handling code.
AC_DEFUN([AM_OUTPUT_DEPENDENCY_COMMANDS],
[AC_CONFIG_COMMANDS([depfiles],
     [test x"$AMDEP_TRUE" != x"" || _AM_OUTPUT_DEPENDENCY_COMMANDS],
     [AMDEP_TRUE="$AMDEP_TRUE" ac_aux_dir="$ac_aux_dir"])
])

# Do all the work for Automake.                             -*- Autoconf -*-

# Copyright (C) 1996-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This macro actually does too much.  Some checks are only needed if
# your package does certain things.  But this isn't really a big deal.

dnl Redefine AC_PROG_CC to automatically invoke _AM_PROG_CC_C_O.
m4_define([AC_PROG_CC],
m4_defn([AC_PROG_CC])
[_AM_PROG_CC_C_O
])

# AM_INIT_AUTOMAKE(PACKAGE, VERSION, [NO-DEFINE])
# AM_INIT_AUTOMAKE([OPTIONS])
# -----------------------------------------------
# The call with PACKAGE and VERSION arguments is the old style
# call (pre autoconf-2.50), which is being phased out.  PACKAGE
# and VERSION should now be passed to AC_INIT and removed from
# the call to AM_INIT_AUTOMAKE.
# We support both call styles for the transition.  After
# the next Automake release, Autoconf can make the AC_INIT
# arguments mandatory, and then we can depend on a new Autoconf
# release and drop the old call support.
AC_DEFUN([AM_INIT_AUTOMAKE],
[AC_PREREQ([2.65])dnl
dnl Autoconf wants to disallow AM_ names.  We explicitly allow
dnl the ones we care about.
m4_pattern_allow([^AM_[A-Z]+FLAGS$])dnl
AC_REQUIRE([AM_SET_CURRENT_AUTOMAKE_VERSION])dnl
AC_REQUIRE([AC_PROG_INSTALL])dnl
if test "`cd $srcdir && pwd`" != "`pwd`"; then
  # Use -I$(srcdir) only when $(srcdir) != ., so that make's output
  # is not polluted with repeated "-I."
  AC_SUBST([am__isrc], [' -I$(srcdir)'])_AM_SUBST_NOTMAKE([am__isrc])dnl
  # test to see if srcdir already configured
  if test -f $srcdir/config.status; then
    AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
  fi
fi

# test whether we have cygpath
if test -z "$CYGPATH_W"; then
  if (cygpath --version) >/dev/null 2>/dev/null; then
    CYGPATH_W='cygpath -w'
  else
    CYGPATH_W=echo
  fi
fi
AC_SUBST([CYGPATH_W])

# Define the identity of the package.
dnl Distinguish between old-style and new-style calls.
m4_ifval([$2],
[AC_DIAGNOSE([obsolete],
             [$0: two- and three-arguments forms are deprecated.])
m4_ifval([$3], [_AM_SET_OPTION([no-define])])dnl
 AC_SUBST([PACKAGE], [$1])dnl
 AC_SUBST([VERSION], [$2])],
[_AM_SET_OPTIONS([$1])dnl
dnl Diagnose old-style AC_INIT with new-style AM_AUTOMAKE_INIT.
m4_if(
  m4_ifdef([AC_PACKAGE_NAME], [ok]):m4_ifdef([AC_PACKAGE_VERSION], [ok]),
  [ok:ok],,
  [m4_fatal([AC_INIT should be called with package and version arguments])])dnl
 AC_SUBST([PACKAGE], ['AC_PACKAGE_TARNAME'])dnl
 AC_SUBST([VERSION], ['AC_PACKAGE_VERSION'])])dnl

_AM_IF_OPTION([no-define],,
[AC_DEFINE_UNQUOTED([PACKAGE], ["$PACKAGE"], [Name of package])
 AC_DEFINE_UNQUOTED([VERSION], ["$VERSION"], [Version number of package])])dnl

# Some tools Automake needs.
AC_REQUIRE([AM_SANITY_CHECK])dnl
AC_REQUIRE([AC_ARG_PROGRAM])dnl
AM_MISSING_PROG([ACLOCAL], [aclocal-${am__api_version}])
AM_MISSING_PROG([AUTOCONF], [autoconf])
AM_MISSING_PROG([AUTOMAKE], [automake-${am__api_version}])
AM_MISSING_PROG([AUTOHEADER], [autoheader])
AM_MISSING_PROG([MAKEINFO], [makeinfo])
AC_REQUIRE([AM_PROG_INSTALL_SH])dnl
AC_REQUIRE([AM_PROG_INSTALL_STRIP])dnl
AC_REQUIRE([AC_PROG_MKDIR_P])dnl
# For better backward compatibility.  To be removed once Automake 1.9.x
# dies out for good.  For more background, see:
# <http://lists.gnu.org/archive/html/automake/2012-07/msg00001.html>
# <http://lists.gnu.org/archive/html/automake/2012-07/msg00014.html>
AC_SUBST([mkdir_p], ['$(MKDIR_P)'])
# We need awk for the "check" target (and possibly the TAP driver).  The
# system "awk" is bad on some platforms.
AC_REQUIRE([AC_PROG_AWK])dnl
AC_REQUIRE([AC_PROG_MAKE_SET])dnl
AC_REQUIRE([AM_SET_LEADING_DOT])dnl
_AM_IF_OPTION([tar-ustar], [_AM_PROG_TAR([ustar])],
	      [_AM_IF_OPTION([tar-pax], [_AM_PROG_TAR([pax])],
			     [_AM_PROG_TAR([v7])])])
_AM_IF_OPTION([no-dependencies],,
[AC_PROVIDE_IFELSE([AC_PROG_CC],
		  [_AM_DEPENDENCIES([CC])],
		  [m4_define([AC_PROG_CC],
			     m4_defn([AC_PROG_CC])[_AM_DEPENDENCIES([CC])])])dnl
AC_PROVIDE_IFELSE([AC_PROG_CXX],
		  [_AM_DEPENDENCIES([CXX])],
		  [m4_define([AC_PROG_CXX],
			     m4_defn([AC_PROG_CXX])[_AM_DEPENDENCIES([CXX])])])dnl
AC_PROVIDE_IFELSE([AC_PROG_OBJC],
		  [_AM_DEPENDENCIES([OBJC])],
		  [m4_define([AC_PROG_OBJC],
			     m4_defn([AC_PROG_OBJC])[_AM_DEPENDENCIES([OBJC])])])dnl
AC_PROVIDE_IFELSE([AC_PROG_OBJCXX],
		  [_AM_DEPENDENCIES([OBJCXX])],
		  [m4_define([AC_PROG_OBJCXX],
			     m4_defn([AC_PROG_OBJCXX])[_AM_DEPENDENCIES([OBJCXX])])])dnl
])
AC_REQUIRE([AM_SILENT_RULES])dnl
dnl The testsuite driver may need to know about EXEEXT, so add the
dnl 'am__EXEEXT' conditional if _AM_COMPILER_EXEEXT was seen.  This
dnl macro is hooked onto _AC_COMPILER_EXEEXT early, see below.
AC_CONFIG_COMMANDS_PRE(dnl
[m4_provide_if([_AM_COMPILER_EXEEXT],
  [AM_CONDITIONAL([am__EXEEXT], [test -n "$EXEEXT"])])])dnl

# POSIX will say in a future version that running "rm -f" with no argument
# is OK; and we want to be able to make that assumption in our Makefile
# recipes.  So use an aggressive probe to check that the usage we want is
# actually supported "in the wild" to an acceptable degree.
# See automake bug#10828.
# To make any issue more visible, cause the running configure to be aborted
# by default if the 'rm' program in use doesn't match our expectations; the
# user can still override this though.
if rm -f && rm -fr && rm -rf; then : OK; else
  cat >&2 <<'END'
Oops!

Your 'rm' program seems unable to run without file operands specified
on the command line, even when the '-f' option is present.  This is contrary
to the behaviour of most rm programs out there, and not conforming with
the upcoming POSIX standard: <http://austingroupbugs.net/view.php?id=542>

Please tell bug-automake@gnu.org about your system, including the value
of your $PATH and any error possibly output before this message.  This
can help us improve future automake versions.

END
  if test x"$ACCEPT_INFERIOR_RM_PROGRAM" = x"yes"; then
    echo 'Configuration will proceed anyway, since you have set the' >&2
    echo 'ACCEPT_INFERIOR_RM_PROGRAM variable to "yes"' >&2
    echo >&2
  else
    cat >&2 <<'END'
Aborting the configuration process, to ensure you take notice of the issue.

You can download and install GNU coreutils to get an 'rm' implementation
that behaves properly: <http://www.gnu.org/software/coreutils/>.

If you want to complete the configuration process using your problematic
'rm' anyway, export the environment variable ACCEPT_INFERIOR_RM_PROGRAM
to "yes", and re-run configure.

END
    AC_MSG_ERROR([Your 'rm' program is bad, sorry.])
  fi
fi
dnl The trailing newline in this macro's definition is deliberate, for
dnl backward compatibility and to allow trailing 'dnl'-style comments
dnl after the AM_INIT_AUTOMAKE invocation. See automake bug#16841.
])

dnl Hook into '_AC_COMPILER_EXEEXT' early to learn its expansion.  Do not
dnl add the conditional right here, as _AC_COMPILER_EXEEXT may be further
dnl mangled by Autoconf and run in a shell conditional statement.
m4_define([_AC_COMPILER_EXEEXT],
m4_defn([_AC_COMPILER_EXEEXT])[m4_provide([_AM_COMPILER_EXEEXT])])

# When config.status generates a header, we must update the stamp-h file.
# This file resides in the same directory as the config header
# that is generated.  The stamp files are numbered to have different names.

# Autoconf calls _AC_AM_CONFIG_HEADER_HOOK (when defined) in the
# loop where config.status creates the headers, so we can generate
# our stamp files there.
AC_DEFUN([_AC_AM_CONFIG_HEADER_HOOK],
[# Compute $1's index in $config_headers.
_am_arg=$1
_am_stamp_count=1
for _am_header in $config_headers :; do
  case $_am_header in
    $_am_arg | $_am_arg:* )
      break ;;
    * )
      _am_stamp_count=`expr $_am_stamp_count + 1` ;;
  esac
done
echo "timestamp for $_am_arg" >`AS_DIRNAME(["$_am_arg"])`/stamp-h[]$_am_stamp_count])

# Copyright (C) 2001-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_PROG_INSTALL_SH
# ------------------
# Define $install_sh.
AC_DEFUN([AM_PROG_INSTALL_SH],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
if test x"${install_sh+set}" != xset; then
  case $am_aux_dir in
  *\ * | *\	*)
    install_sh="\${SHELL} '$am_aux_dir/install-sh'" ;;
  *)
    install_sh="\${SHELL} $am_aux_dir/install-sh"
  esac
fi
AC_SUBST([install_sh])])

# Copyright (C) 2003-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# Check whether the underlying file-system supports filenames
# with a leading dot.  For instance MS-DOS doesn't.
AC_DEFUN([AM_SET_LEADING_DOT],
[rm -rf .tst 2>/dev/null
mkdir .tst 2>/dev/null
if test -d .tst; then
  am__leading_dot=.
else
  am__leading_dot=_
fi
rmdir .tst 2>/dev/null
AC_SUBST([am__leading_dot])])

# Check to see how 'make' treats includes.	            -*- Autoconf -*-

# Copyright (C) 2001-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_MAKE_INCLUDE()
# -----------------
# Check to see how make treats includes.
AC_DEFUN([AM_MAKE_INCLUDE],
[am_make=${MAKE-make}
cat > confinc << 'END'
am__doit:
	@echo this is the am__doit target
.PHONY: am__doit
END
# If we don't find an include directive, just comment out the code.
AC_MSG_CHECKING([for style of include used by $am_make])
am__include="#"
am__quote=
_am_result=none
# First try GNU make style include.
echo "include confinc" > confmf
# Ignore all kinds of additional output from 'make'.
case `$am_make -s -f confmf 2> /dev/null` in #(
*the\ am__doit\ target*)
  am__include=include
  am__quote=
  _am_result=GNU
  ;;
esac
# Now try BSD make style include.
if test "$am__include" = "#"; then
   echo '.include "confinc"' > confmf
   case `$am_make -s -f confmf 2> /dev/null` in #(
   *the\ am__doit\ target*)
     am__include=.include
     am__quote="\""
     _am_result=BSD
     ;;
   esac
fi
AC_SUBST([am__include])
AC_SUBST([am__quote])
AC_MSG_RESULT([$_am_result])
rm -f confinc confmf
])

# Fake the existence of programs that GNU maintainers use.  -*- Autoconf -*-

# Copyright (C) 1997-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_MISSING_PROG(NAME, PROGRAM)
# ------------------------------
AC_DEFUN([AM_MISSING_PROG],
[AC_REQUIRE([AM_MISSING_HAS_RUN])
$1=${$1-"${am_missing_run}$2"}
AC_SUBST($1)])

# AM_MISSING_HAS_RUN
# ------------------
# Define MISSING if not defined so far and test if it is modern enough.
# If it is, set am_missing_run to use it, otherwise, to nothing.
AC_DEFUN([AM_MISSING_HAS_RUN],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
AC_REQUIRE_AUX_FILE([missing])dnl
if test x"${MISSING+set}" != xset; then
  case $am_aux_dir in
  *\ * | *\	*)
    MISSING="\${SHELL} \"$am_aux_dir/missing\"" ;;
  *)
    MISSING="\${SHELL} $am_aux_dir/missing" ;;
  esac
fi
# Use eval to expand $SHELL
if eval "$MISSING --is-lightweight"; then
  am_missing_run="$MISSING "
else
  am_missing_run=
  AC_MSG_WARN(['missing' script is too old or missing])
fi
])

# Helper functions for option handling.                     -*- Autoconf -*-

# Copyright (C) 2001-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# _AM_MANGLE_OPTION(NAME)
# -----------------------
AC_DEFUN([_AM_MANGLE_OPTION],
[[_AM_OPTION_]m4_bpatsubst($1, [[^a-zA-Z0-9_]], [_])])

# _AM_SET_OPTION(NAME)
# --------------------
# Set option NAME.  Presently that only means defining a flag for this option.
AC_DEFUN([_AM_SET_OPTION],
[m4_define(_AM_MANGLE_OPTION([$1]), [1])])

# _AM_SET_OPTIONS(OPTIONS)
# ------------------------
# OPTIONS is a space-separated list of Automake options.
AC_DEFUN([_AM_SET_OPTIONS],
[m4_foreach_w([_AM_Option], [$1], [_AM_SET_OPTION(_AM_Option)])])

# _AM_IF_OPTION(OPTION, IF-SET, [IF-NOT-SET])
# -------------------------------------------
# Execute IF-SET if OPTION is set, IF-NOT-SET otherwise.
AC_DEFUN([_AM_IF_OPTION],
[m4_ifset(_AM_MANGLE_OPTION([$1]), [$2], [$3])])

# Check to make sure that the build environment is sane.    -*- Autoconf -*-

# Copyright (C) 1996-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_SANITY_CHECK
# ---------------
AC_DEFUN([AM_SANITY_CHECK],
[AC_MSG_CHECKING([whether build environment is sane])
# Reject unsafe characters in $srcdir or the absolute working directory
# name.  Accept space and tab only in the latter.
am_lf='
'
case `pwd` in
  *[[\\\"\#\$\&\'\`$am_lf]]*)
    AC_MSG_ERROR([unsafe absolute working directory name]);;
esac
case $srcdir in
  *[[\\\"\#\$\&\'\`$am_lf\ \	]]*)
    AC_MSG_ERROR([unsafe srcdir value: '$srcdir']);;
esac

# Do 'set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   am_has_slept=no
   for am_try in 1 2; do
     echo "timestamp, slept: $am_has_slept" > conftest.file
     set X `ls -Lt "$srcdir/configure" conftest.file 2> /dev/null`
     if test "$[*]" = "X"; then
	# -L didn't work.
	set X `ls -t "$srcdir/configure" conftest.file`
     fi
     if test "$[*]" != "X $srcdir/configure conftest.file" \
	&& test "$[*]" != "X conftest.file $srcdir/configure"; then

	# If neither matched, then we have a broken ls.  This can happen
	# if, for instance, CONFIG_SHELL is bash and it inherits a
	# broken ls alias from the environment.  This has actually
	# happened.  Such a system could not be considered "sane".
	AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
  alias in your environment])
     fi
     if test "$[2]" = conftest.file || test $am_try -eq 2; then
       break
     fi
     # Just in case.
     sleep 1
     am_has_slept=yes
   done
   test "$[2]" = conftest.file
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
AC_MSG_RESULT([yes])
# If we didn't sleep, we still need to ensure time stamps of config.status and
# generated files are strictly newer.
am_sleep_pid=
if grep 'slept: no' conftest.file >/dev/null 2>&1; then
  ( sleep 1 ) &
  am_sleep_pid=$!
fi
AC_CONFIG_COMMANDS_PRE(
  [AC_MSG_CHECKING([that generated files are newer than configure])
   if test -n "$am_sleep_pid"; then
     # Hide warnings about reused PIDs.
     wait $am_sleep_pid 2>/dev/null
   fi
   AC_MSG_RESULT([done])])
rm -f conftest.file
])

# Copyright (C) 2009-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_SILENT_RULES([DEFAULT])
# --------------------------
# Enable less verbose build rules; with the default set to DEFAULT
# ("yes" being less verbose, "no" or empty being verbose).
AC_DEFUN([AM_SILENT_RULES],
[AC_ARG_ENABLE([silent-rules], [dnl
AS_HELP_STRING(
  [--enable-silent-rules],
  [less verbose build output (undo: "make V=1")])
AS_HELP_STRING(
  [--disable-silent-rules],
  [verbose build output (undo: "make V=0")])dnl
])
case $enable_silent_rules in @%:@ (((
  yes) AM_DEFAULT_VERBOSITY=0;;
   no) AM_DEFAULT_VERBOSITY=1;;
    *) AM_DEFAULT_VERBOSITY=m4_if([$1], [yes], [0], [1]);;
esac
dnl
dnl A few 'make' implementations (e.g., NonStop OS and NextStep)
dnl do not support nested variable expansions.
dnl See automake bug#9928 and bug#10237.
am_make=${MAKE-make}
AC_CACHE_CHECK([whether $am_make supports nested variables],
   [am_cv_make_support_nested_variables],
   [if AS_ECHO([['TRUE=$(BAR$(V))
BAR0=false
BAR1=true
V=1
am__doit:
	@$(TRUE)
.PHONY: am__doit']]) | $am_make -f - >/dev/null 2>&1; then
  am_cv_make_support_nested_variables=yes
else
  am_cv_make_support_nested_variables=no
fi])
if test $am_cv_make_support_nested_variables = yes; then
  dnl Using '$V' instead of '$(V)' breaks IRIX make.
  AM_V='$(V)'
  AM_DEFAULT_V='$(AM_DEFAULT_VERBOSITY)'
else
  AM_V=$AM_DEFAULT_VERBOSITY
  AM_DEFAULT_V=$AM_DEFAULT_VERBOSITY
fi
AC_SUBST([AM_V])dnl
AM_SUBST_NOTMAKE([AM_V])dnl
AC_SUBST([AM_DEFAULT_V])dnl
AM_SUBST_NOTMAKE([AM_DEFAULT_V])dnl
AC_SUBST([AM_DEFAULT_VERBOSITY])dnl
AM_BACKSLASH='\'
AC_SUBST([AM_BACKSLASH])dnl
_AM_SUBST_NOTMAKE([AM_BACKSLASH])dnl
])

# Copyright (C) 2001-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_PROG_INSTALL_STRIP
# ---------------------
# One issue with vendor 'install' (even GNU) is that you can't
# specify the program used to strip binaries.  This is especially
# annoying in cross-compiling environments, where the build's strip
# is unlikely to handle the host's binaries.
# Fortunately install-sh will honor a STRIPPROG variable, so we
# always use install-sh in "make install-strip", and initialize
# STRIPPROG with the value of the STRIP variable (set by the user).
AC_DEFUN([AM_PROG_INSTALL_STRIP],
[AC_REQUIRE([AM_PROG_INSTALL_SH])dnl
# Installed binaries are usually stripped using 'strip' when the user
# run "make install-strip".  However 'strip' might not be the right
# tool to use in cross-compilation environments, therefore Automake
# will honor the 'STRIP' environment variable to overrule this program.
dnl Don't test for $cross_compiling = yes, because it might be 'maybe'.
if test "$cross_compiling" != no; then
  AC_CHECK_TOOL([STRIP], [strip], :)
fi
INSTALL_STRIP_PROGRAM="\$(install_sh) -c -s"
AC_SUBST([INSTALL_STRIP_PROGRAM])])

# Copyright (C) 2006-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# _AM_SUBST_NOTMAKE(VARIABLE)
# ---------------------------
# Prevent Automake from outputting VARIABLE = @VARIABLE@ in Makefile.in.
# This macro is traced by Automake.
AC_DEFUN([_AM_SUBST_NOTMAKE])

# AM_SUBST_NOTMAKE(VARIABLE)
# --------------------------
# Public sister of _AM_SUBST_NOTMAKE.
AC_DEFUN([AM_SUBST_NOTMAKE], [_AM_SUBST_NOTMAKE($@)])

# Check how to create a tarball.                            -*- Autoconf -*-

# Copyright (C) 2004-2014 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# _AM_PROG_TAR(FORMAT)
# --------------------
# Check how to create a tarball in format FORMAT.
# FORMAT should be one of 'v7', 'ustar', or 'pax'.
#
# Substitute a variable $(am__tar) that is a command
# writing to stdout a FORMAT-tarball containing the directory
# $tardir.
#     tardir=directory && $(am__tar) > result.tar
#
# Substitute a variable $(am__untar) that extract such
# a tarball read from stdin.
#     $(am__untar) < result.tar
#
AC_DEFUN([_AM_PROG_TAR],
[# Always define AMTAR for backward compatibility.  Yes, it's still used
# in the wild :-(  We should find a proper way to deprecate it ...
AC_SUBST([AMTAR], ['$${TAR-tar}'])

# We'll loop over all known methods to create a tar archive until one works.
_am_tools='gnutar m4_if([$1], [ustar], [plaintar]) pax cpio none'

m4_if([$1], [v7],
  [am__tar='$${TAR-tar} chof - "$$tardir"' am__untar='$${TAR-tar} xf -'],

  [m4_case([$1],
    [ustar],
     [# The POSIX 1988 'ustar' format is defined with fixed-size fields.
      # There is notably a 21 bits limit for the UID and the GID.  In fact,
      # the 'pax' utility can hang on bigger UID/GID (see automake bug#8343
      # and bug#13588).
      am_max_uid=2097151 # 2^21 - 1
      am_max_gid=$am_max_uid
      # The $UID and $GID variables are not portable, so we need to resort
      # to the POSIX-mandated id(1) utility.  Errors in the 'id' calls
      # below are definitely unexpected, so allow the users to see them
      # (that is, avoid stderr redirection).
      am_uid=`id -u || echo unknown`
      am_gid=`id -g || echo unknown`
      AC_MSG_CHECKING([whether UID '$am_uid' is supported by ustar format])
      if test $am_uid -le $am_max_uid; then
         AC_MSG_RESULT([yes])
      else
         AC_MSG_RESULT([no])
         _am_tools=none
      fi
      AC_MSG_CHECKING([whether GID '$am_gid' is supported by ustar format])
      if test $am_gid -le $am_max_gid; then
         AC_MSG_RESULT([yes])
      else
        AC_MSG_RESULT([no])
        _am_tools=none
      fi],

  [pax],
    [],

  [m4_fatal([Unknown tar format])])

  AC_MSG_CHECKING([how to create a $1 tar archive])

  # Go ahead even if we have the value already cached.  We do so because we
  # need to set the values for the 'am__tar' and 'am__untar' variables.
  _am_tools=${am_cv_prog_tar_$1-$_am_tools}

  for _am_tool in $_am_tools; do
    case $_am_tool in
    gnutar)
      for _am_tar in tar gnutar gtar; do
        AM_RUN_LOG([$_am_tar --version]) && break
      done
      am__tar="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$$tardir"'
      am__tar_="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$tardir"'
      am__untar="$_am_tar -xf -"
      ;;
    plaintar)
      # Must skip GNU tar: if it does not support --format= it doesn't create
      # ustar tarball either.
      (tar --version) >/dev/null 2>&1 && continue
      am__tar='tar chf - "$$tardir"'
      am__tar_='tar chf - "$tardir"'
      am__untar='tar xf -'
      ;;
    pax)
      am__tar='pax -L -x $1 -w "$$tardir"'
      am__tar_='pax -L -x $1 -w "$tardir"'
      am__untar='pax -r'
      ;;
    cpio)
      am__tar='find "$$tardir" -print | cpio -o -H $1 -L'
      am__tar_='find "$tardir" -print | cpio -o -H $1 -L'
      am__untar='cpio -i -H $1 -d'
      ;;
    none)
      am__tar=false
      am__tar_=false
      am__untar=false
      ;;
    esac

    # If the value was cached, stop now.  We just wanted to have am__tar
    # and am__untar set.
    test -n "${am_cv_prog_tar_$1}" && break

    # tar/untar a dummy directory, and stop if the command works.
    rm -rf conftest.dir
    mkdir conftest.dir
    echo GrepMe > conftest.dir/file
    AM_RUN_LOG([tardir=conftest.dir && eval $am__tar_ >conftest.tar])
    rm -rf conftest.dir
    if test -s conftest.tar; then
      AM_RUN_LOG([$am__untar <conftest.tar])
      AM_RUN_LOG([cat conftest.dir/file])
      grep GrepMe conftest.dir/file >/dev/null 2>&1 && break
    fi
  done
  rm -rf conftest.dir

  AC_CACHE_VAL([am_cv_prog_tar_$1], [am_cv_prog_tar_$1=$_am_tool])
  AC_MSG_RESULT([$am_cv_prog_tar_$1])])

AC_SUBST([am__tar])
AC_SUBST([am__untar])
]) # _AM_PROG_TAR
