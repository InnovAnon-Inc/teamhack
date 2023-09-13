#! /usr/bin/env bash
set -euxo nounset
(( $UID ))
(( $# ))
D="$1"
[[ -d "$D" ]]
shift
if (( ! $# )) ; then
  M=update
else M="$*"
fi
git -C "$D" add .
git -C "$D" commit -m "$M"
git -C "$D" push
git         add .
git         commit -m "$M"
git         push

