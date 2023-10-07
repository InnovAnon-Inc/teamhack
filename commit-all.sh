#! /usr/bin/env bash
set -euxo nounset -o pipefail

if (( ! UID )) ; then
echo de-escalate privileges 1>&2
exit 1
fi

if (( ! $# )) ; then
  M=update
else M="$@"
fi

#find -mindepth 1 -maxdepth 5 -type d |
#while IFS= read -r k ; do
#[[ -d "$k.git" ]] || continue
#echo "$k"
#git -C "$k" add .
#git -C "$k" commit -m "$M"
#git -C "$k" push
#done

#git pull
#git add .
#git commit -m update
#git push

#contrib/afl/AFLPlusPlus
#contrib/xmrig/xmrig
while IFS= read -r line ; do (
  echo line: $line
  IFS=\  read -ra cols <<< "$line"
  case ${#cols[@]} in
  1) cols=( "${cols[@]}" main ) ;;
  2) ;;
  *) echo unexpected number of columns: $line 1>&2
     exit 1
     ;;
  esac
  echo cols: ${cols[@]}

  subm="${cols[0]}"
  brch="${cols[1]}"

  git -C "$subm" pull --set-upstream origin "$brch"
  git -C "$subm" add .
  git -C "$subm" commit -m "$M" || :
  git -C "$subm" push --set-upstream origin "HEAD:$brch"
) ; done << "EOF"
contrib/xmrig/main
contrib/xmrig/pgo pgo
contrib/xmrig/pg  pg
dev/bash-syslog
dev/dcc/kali      kali
dev/dcc/main
dev/dcc/ubuntu    ubuntu
dev/dcc/voidlinux voidlinux
htb/db
htb/dns
htb/import_db
htb/msfrpcd
htb/nmap
htb/recond
htb/rest
htw/aircrack/main
htw/aircrack/pgo  pgo
htw/aircrack/pg   pg
htw/capsrv
it/ca
it/pgldap
it/pgrsyslog
it/web
ops/ppa
rk/slrk
EOF

git add -A
git commit -m "$M"
git push

