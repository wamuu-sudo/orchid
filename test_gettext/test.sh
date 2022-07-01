#!/usr/bin/env bash

#alias GETTEXT='gettext "test"'

. gettext.sh

export TEXTDOMAIN=test
export TEXTDOMAINDIR=$PWD/locale

pwd=$PWD

echo $(gettext "Hello World!")
echo $(eval_gettext "Current dir: \$pwd")
echo $(gettext "End of the script")
