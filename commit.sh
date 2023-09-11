for k in \
./dev/bash-syslog   \
./dev/dcc/voidlinux \
./dev/dcc/ubuntu    \
./dev/dcc/main      \
./dev/dcc/kali      \
./it/pgrsyslog      \
./it/pgldap
do (
  cd "$k"
  git pull
  git add .
  git commit -m update
  git push
) ; done

