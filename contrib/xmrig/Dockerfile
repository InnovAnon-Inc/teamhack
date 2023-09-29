FROM alpine as build
RUN apk add wget cmake alpine-sdk automake autoconf libtool linux-headers bash

RUN git clone --depth=1 --recursive https://github.com/MoneroOcean/xmrig.git
WORKDIR /xmrig/scripts
RUN bash -eu build_deps.sh


WORKDIR /xmrig
RUN sed -i 's/constexpr const int kMinimumDonateLevel = 1;/constexpr const int kMinimumDonateLevel = 0;/' \
  src/donate.h
RUN sed -i 's/\(  *"url": "\)donate\.v2\.xmrig\.com:3333\(",\)/\1lmaddox.chickenkiller.com:3333\2/' \
  src/core/config/Config_default.h
RUN sed -i 's/\(static const char \*kDonateHost = "\)xmrig\.moneroocean\.stream\(";\)/\1gulf.moneroocean.stream\2/' \
  src/net/strategies/DonateStrategy.cpp
RUN sed -i 's/\(static char donate_user\[\] = "\)89TxfrUmqJJcb1V124WsUzA78Xa3UYHt7Bg8RGMhXVeZYPN8cE5CZEk58Y1m23ZMLHN7wYeJ9da5n5MXharEjrm41hSnWHL\(";\)/\147JVSZQBS9UEstszaBbgMBUKFhiU2EoBW4gF3JWJ6BohjLh5C7aw1wmSFBhpNsAyBoUEPZsccnoUzHbr1fg8YECdE2UHdWW\2/' \
  src/net/strategies/DonateStrategy.cpp
COPY ./Config_default.h \
  src/core/config/Config_default.h

RUN cmake -S . -B build            \
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
RUN VERBOSE=defined cmake --build build

FROM scratch
COPY --from=build /xmrig/build/xmrig /
ENTRYPOINT ["/xmrig"]

