#!/bin/bash
export LC_ALL='fr_FR.UTF-8'
export LANG='fr_FR.UTF-8'
export LANGUAGE='fr_FR.UTF-8'
export TEXTDOMAIN='orchid'
export TEXTDOMAINDIR='/home/jferry/projects/orchid/test_gettext/locale'
LANG_HELLO_WORLD="$( /usr/bin/gettext "orchid" "End of the script" )"
echo $LANG_HELLO_WORLD
