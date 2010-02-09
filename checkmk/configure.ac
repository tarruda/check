#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)
AC_INIT(checkmk, [1.0.1], micah@cowan.name)
AC_CONFIG_SRCDIR([./checkmk.in])
AM_INIT_AUTOMAKE([foreign dist-bzip2])

# Checks for programs.

# awk
AC_ARG_VAR(AWK_PATH)
AC_PROG_AWK
AC_PATH_PROG(AWK_PATH, $AWK, [*NO AWK*])

if test "$AWK_PATH" = '*NO AWK*'
then
    AC_MSG_ERROR([Couldn't find a usable awk!])
fi

# docbook2man
AC_ARG_VAR(DOCBOOK2MAN)
AC_PATH_PROG(DOCBOOK2MAN, "docbook2man", [])
AM_CONDITIONAL(DO_MANS, test "x$DOCBOOK2MAN" != "x")
if test "x$DOCBOOK2MAN" = "x"
then
    AC_MSG_WARN([Couldn't find docbook2man! Won't rebuild documentation.])
fi

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
AC_CONFIG_FILES(Makefile checkmk)
AC_CONFIG_COMMANDS(checkmk-x, [chmod +x checkmk])
AC_OUTPUT
