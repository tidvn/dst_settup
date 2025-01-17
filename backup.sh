#!/bin/bash

dontstarve_dir="${1:-$HOME/.klei/DoNotStarveTogether}"

function fail()
{
        echo Error: "$@" >&2
        exit 1
}

cd "$dontstarve_dir" || fail "Missing directory!"

git add .
git commit -m "Update at $(date +"%Y-%m-%d %H:%M:%S")"
git push origin main