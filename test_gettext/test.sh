#!/usr/bin/env bash

#alias GETTEXT='gettext "test"'

. gettext.sh

export TEXTDOMAIN=test
export TEXTDOMAINDIR=$PWD/locale

pwd=$PWD

gettext "Hello World!"
eval_gettext "Current dir: \$pwd"
gettext "End of the script"
