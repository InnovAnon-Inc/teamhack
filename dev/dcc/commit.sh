#! /usr/bin/env bash
set -euxo nounset
(( $UID ))
if (( ! $# )) ; then
  M=update
else M="$*"
fi
pwd
for k in $(ls -d */) ; do (
  cd "$k"
  ./commit.sh $M
) ; done

