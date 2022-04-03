#!/usr/bin/env bash
#Copyright (C) 2022 Yannick Defais aka Chevek, Wamuu-sudo
#This program is free software: you can redistribute it and/or modify it under
#the terms of the GNU General Public License as published by the Free Software
#Foundation, either version 3 of the License, or (at your option) any later
#version.
#This program is distributed in the hope that it will be useful, but WITHOUT
#ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with
#this program. If not, see https://www.gnu.org/licenses/.

# Count all files + directories
# e.g. "44262 directories, 380176 files"
RESULT_TREE=$(tree -a -- /PATH/TO/WHERE/THE/FILES/ARE | tail -n 1)
# declare as a integer:
declare -i NUMBER
IFS=',' read -ra PARTS <<< "$RESULT_TREE"
for i in "${PARTS[@]}"; do
  # process "$i"
  NUMBER+=$(echo "$i" | tr -dc '0-9')
done
echo "$NUMBER"

