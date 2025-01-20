#!/bin/bash

function fail()
{
	echo Error: "$@" >&2
	exit 1
}

function check_for_file()
{
	if [ ! -e "$1" ]; then
		fail "Missing file: $1"
	fi
}

check_for_file "./mods"
mods_setup_file="./mods/dedicated_server_mods_setup.lua"
echo "" > "$mods_setup_file"

shopt -s nullglob dotglob
for file in ./Master/modoverrides.lua; do
    if [ -f "$file" ]; then
        grep -o 'workshop-[0-9]*' "$file" | sed 's/workshop-//' | sort -u | awk '{print "    ServerModSetup(\"" $1 "\")"}' >> "$mods_setup_file"
    fi
done