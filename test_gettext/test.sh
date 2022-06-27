#!/usr/bin/env bash

#alias GETTEXT

export TEXTDOMAIN=test
export TEXTDOMAINDIR=$PWD/locale

echo $(gettext "test" "Hello World!")

echo $(gettext "test" "End of the script")
