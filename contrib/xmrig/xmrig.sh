#! /usr/bin/env bash
set -euxo nounset
(( ! $#  ))
(( UID ))

export PATH=/usr/local/sbin:/usr/local/bin
export PATH=$PATH:/usr/sbin:/usr/bin
export PATH=$PATH:/sbin:bin
export PATH=$PATH:/usr/local/games:/usr/games
export PATH=$PATH:/usr/share/apache-ant/bin
export PATH=$PATH:/usr/lib/psql15/bin
export PATH=$PATH:/opt/texlive/2023/bin/x86_64-linuxmusl
export PATH=/usr/lib/ccache/bin:$PATH
export PATH=$HOME/node_modules/.bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/perl5/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

if [[ ! -d xmrig ]] ; then
git clone --depth=1 --recursive https://github.com/MoneroOcean/xmrig.git
else
git -C xmrig reset --hard
git -C xmrig clean -fdX
git -C xmrig clean -fdX
git -C xmrig pull
fi
cd xmrig/scripts
bash -eu build_deps.sh

cd ..
sed -i 's/constexpr const int kMinimumDonateLevel = 1;/constexpr const int kMinimumDonateLevel = 0;/' \
  src/donate.h
sed -i 's/\(  *"url": "\)donate\.v2\.xmrig\.com:3333\(",\)/\1lmaddox.chickenkiller.com:3333\2/' \
  src/core/config/Config_default.h
sed -i 's/\(static const char \*kDonateHost = "\)xmrig\.moneroocean\.stream\(";\)/\1gulf.moneroocean.stream\2/' \
  src/net/strategies/DonateStrategy.cpp
sed -i 's/\(static char donate_user\[\] = "\)89TxfrUmqJJcb1V124WsUzA78Xa3UYHt7Bg8RGMhXVeZYPN8cE5CZEk58Y1m23ZMLHN7wYeJ9da5n5MXharEjrm41hSnWHL\(";\)/\147JVSZQBS9UEstszaBbgMBUKFhiU2EoBW4gF3JWJ6BohjLh5C7aw1wmSFBhpNsAyBoUEPZsccnoUzHbr1fg8YECdE2UHdWW\2/' \
  src/net/strategies/DonateStrategy.cpp
cp -v ../Config_default.h \
  src/core/config/Config_default.h

cmake -S . -B build            \
  -DXMRIG_DEPS=scripts/deps        \
  -DBUILD_STATIC=ON                \
  -DCMAKE_BUILD_TYPE=Release       \
  -DWITH_HTTP=OFF                  \
  -DWITH_ENV_VARS=OFF              \
  -DWITH_OPENCL=OFF                \
  -DWITH_ADL=OFF                   \
  -DWITH_CUDA=OFF                  \
  -DWITH_NVML=OFF                  \
  -DWITH_MO_BENCHMARK=ON           \
  -DWITH_TLS=ON                    \
  -DWITH_EMBEDDED_CONFIG=ON
VERBOSE=defined cmake --build build

