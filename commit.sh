for k in \
./dev/bash-syslog   \
./dev/dcc/voidlinux \
./dev/dcc/ubuntu    \
./dev/dcc/main      \
./dev/dcc/kali      \
./htb/db            \
./htb/dns           \
./htb/recond        \
./htb/rest          \
./it/pgrsyslog      \
./it/pgldap
do (
  cd "$k"
  git pull origin
#  git add .
#  git commit -m update
#  git push
  ) || {
  echo $k ; exit 2
}; done

git pull
git add .
git commit -m update
git push

