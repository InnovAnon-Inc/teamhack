#! /usr/bin/env bash
set -euxo nounset
(( $UID ))
if (( ! $# )) ; then
  M=update
else M="$*"
fi

find -mindepth 1 -maxdepth 5 -type d |
while IFS= read -r k ; do
[[ -d "$k.git" ]] || continue
echo "$k"
git -C "$k" add .
git -C "$k" commit -m "$M"
git -C "$k" push
done

git pull
git add .
git commit -m update
git push

