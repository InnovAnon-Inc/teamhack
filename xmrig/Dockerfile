FROM alpine
RUN apk add wget cmake alpine-sdk automake autoconf libtool linux-headers bash
RUN git clone --depth=1 --recursive https://github.com/MoneroOcean/xmrig.git
WORKDIR /xmrig/scripts
RUN bash build_deps.sh
WORKDIR /xmrig/build
RUN cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=on
RUN make
RUN make install

