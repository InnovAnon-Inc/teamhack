#! /usr/bin/env bash
set -euxo nounset
(( $# == 3 ))
(( $UID    ))
[[ "$1" ]]
[[ "$2" ]]
[[ "$3" ]]
REP="$1"
REP="https://github.com/InnovAnon-Inc/$REP.git"
SRC="$2"
DST="$3"
git clone --recursive -b "$SRC" "$REP" "$DST"
cd "$DST"
git checkout -b "$DST"
git push --set-upstream origin "$DST"

