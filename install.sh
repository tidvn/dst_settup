#!/bin/bash

steamcmd_dir="${STEAMCMD_DIR:-$HOME/steamcmd}"
install_dir="${DST_INSTALL_DIR:-$HOME/steamapps/DST}"
dontstarve_dir="${DONTSTARVE_DIR:-$HOME/.klei/DoNotStarveTogether}"

for arg in "$@"; do
    key=$(echo "$arg" | cut -d'=' -f1)
    value=$(echo "$arg" | cut -d'=' -f2)

    if [[ "$key" != "steamcmd_dir" && "$key" != "install_dir" && "$key" != "dontstarve_dir" ]]; then
        continue
    fi

    eval "$key=\"$value\""
done

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

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

check_for_file "steamcmd.sh"

./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit

check_for_file "$install_dir/mods"
mods_setup_file="$install_dir/mods/dedicated_server_mods_setup.lua"
echo "" > "$mods_setup_file"

shopt -s nullglob dotglob
for file in "$dontstarve_dir"/*/Master/modoverrides.lua; do
    if [ -f "$file" ]; then
        grep -o 'workshop-[0-9]*' "$file" | sed 's/workshop-//' | sort -u | awk '{print "    ServerModSetup(\"" $1 "\")"}' >> "$mods_setup_file"
    fi
done