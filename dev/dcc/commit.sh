#! /usr/bin/env bash
set -euxo nounset
(( $UID ))
if (( ! $# )) ; then
  M=update
else M="$*"
fi
for k in $(ls -d */) ; do (
  cd "$k"
  ./commit.sh $M
) ; done

