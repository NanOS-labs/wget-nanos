#!/bin/sh
# post_configure.sh — x86_64 only: route picolibc's stdio/errno/ctype DATA exports through
# libc.ndl IAT slots (see inetutils-port for the full story). WGET NOTE: configure generates
# config.h in src/ (AC_CONFIG_HEADERS([src/config.h])), NOT at the stage root — append to the
# file configure actually wrote, and never invent an empty stage-root config.h that would
# shadow it for gnulib's `#include <config.h>` (-I..).
set -e
[ "${NX_HOST:-i686-nanos}" = "x86_64-nanos" ] || exit 0
CFG="$STAGE/config.h"
[ -f "$STAGE/src/config.h" ] && CFG="$STAGE/src/config.h"
printf '\n#include <nx-dllimport.h>\n' >> "$CFG"
echo "  [post_configure] appended nx-dllimport.h to ${CFG#$STAGE/} (x86_64 data-import shim)"
